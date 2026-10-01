package com.campusconnect.dao;

import com.campusconnect.model.MarketplaceItem;
import com.campusconnect.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MarketplaceDAO {

    public boolean addMarketplaceItem(MarketplaceItem item) {
        String sql = "INSERT INTO marketplace (student_id, item_name, category, description, price, contact, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, item.getStudentId());
            stmt.setString(2, item.getItemName());
            stmt.setString(3, item.getCategory());
            stmt.setString(4, item.getDescription());
            stmt.setBigDecimal(5, item.getPrice());
            stmt.setString(6, item.getContact());
            stmt.setString(7, "AVAILABLE");
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<MarketplaceItem> getAllItems() {
        List<MarketplaceItem> list = new ArrayList<>();
        String sql = "SELECT m.*, s.name as student_name FROM marketplace m JOIN students s ON m.student_id = s.student_id ORDER BY m.posted_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(extractItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<MarketplaceItem> searchItems(String query, String category) {
        List<MarketplaceItem> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT m.*, s.name as student_name FROM marketplace m JOIN students s ON m.student_id = s.student_id WHERE 1=1 ");
        if (query != null && !query.trim().isEmpty()) {
            sql.append("AND (m.item_name LIKE ? OR m.description LIKE ?) ");
        }
        if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All")) {
            sql.append("AND m.category = ? ");
        }
        sql.append("ORDER BY m.posted_date DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (query != null && !query.trim().isEmpty()) {
                String term = "%" + query.trim() + "%";
                stmt.setString(paramIndex++, term);
                stmt.setString(paramIndex++, term);
            }
            if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All")) {
                stmt.setString(paramIndex++, category.trim());
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(extractItem(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateItemStatus(int itemId, String status) {
        String sql = "UPDATE marketplace SET status = ? WHERE item_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, itemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private MarketplaceItem extractItem(ResultSet rs) throws SQLException {
        MarketplaceItem item = new MarketplaceItem();
        item.setItemId(rs.getInt("item_id"));
        item.setStudentId(rs.getInt("student_id"));
        item.setStudentName(rs.getString("student_name"));
        item.setItemName(rs.getString("item_name"));
        item.setCategory(rs.getString("category"));
        item.setDescription(rs.getString("description"));
        item.setPrice(rs.getBigDecimal("price"));
        item.setContact(rs.getString("contact"));
        item.setStatus(rs.getString("status"));
        item.setPostedDate(rs.getTimestamp("posted_date"));
        return item;
    }
}
