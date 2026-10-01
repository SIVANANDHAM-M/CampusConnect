package com.campusconnect.servlet;

import com.campusconnect.dao.LibraryDAO;
import com.campusconnect.model.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/bookSearch")
public class BookSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private LibraryDAO dao = new LibraryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String query = request.getParameter("query");
        String category = request.getParameter("category");

        List<Book> books = dao.searchBooks(query, category);

        if (books.isEmpty()) {
            out.println("<tr><td colspan='6' class='text-center muted'>No matching books found in library catalog.</td></tr>");
            return;
        }

        for (Book b : books) {
            String badgeClass = "AVAILABLE".equalsIgnoreCase(b.getAvailability()) ? "badge-success" : ("ISSUED".equalsIgnoreCase(b.getAvailability()) ? "badge-danger" : "badge-warning");
            out.println("<tr>");
            out.println("  <td><strong>" + b.getBookId() + "</strong></td>");
            out.println("  <td>" + b.getTitle() + "</td>");
            out.println("  <td>" + b.getAuthor() + "</td>");
            out.println("  <td><span class='badge badge-info'>" + b.getCategory() + "</span></td>");
            out.println("  <td><span class='badge " + badgeClass + "'>" + b.getAvailability() + "</span></td>");
            out.println("  <td><code>" + b.getShelfNo() + "</code></td>");
            out.println("</tr>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
