package com.campusconnect.dao;

import com.campusconnect.model.Book;
import com.campusconnect.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LibraryDAO {

    public List<Book> getAllBooks() {
        return searchBooks("", "All");
    }

    public List<Book> searchBooks(String query, String category) {
        List<Book> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM books WHERE 1=1 ");

        if (query != null && !query.trim().isEmpty()) {
            sql.append("AND (title LIKE ? OR author LIKE ? OR category LIKE ?) ");
        }
        if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All")) {
            sql.append("AND category = ? ");
        }
        sql.append("ORDER BY title ASC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (query != null && !query.trim().isEmpty()) {
                String term = "%" + query.trim() + "%";
                stmt.setString(paramIndex++, term);
                stmt.setString(paramIndex++, term);
                stmt.setString(paramIndex++, term);
            }
            if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All")) {
                stmt.setString(paramIndex++, category.trim());
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Book b = new Book();
                    b.setBookId(rs.getInt("book_id"));
                    b.setTitle(rs.getString("title"));
                    b.setAuthor(rs.getString("author"));
                    b.setCategory(rs.getString("category"));
                    b.setAvailability(rs.getString("availability"));
                    b.setShelfNo(rs.getString("shelf_no"));
                    list.add(b);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
