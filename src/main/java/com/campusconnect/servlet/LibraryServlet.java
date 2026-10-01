package com.campusconnect.servlet;

import com.campusconnect.dao.LibraryDAO;
import com.campusconnect.model.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/library")
public class LibraryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private LibraryDAO dao = new LibraryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Book> books = dao.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("library.jsp").forward(request, response);
    }
}
