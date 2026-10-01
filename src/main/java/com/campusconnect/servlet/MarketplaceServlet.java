package com.campusconnect.servlet;

import com.campusconnect.dao.MarketplaceDAO;
import com.campusconnect.model.MarketplaceItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/marketplace")
public class MarketplaceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private MarketplaceDAO dao = new MarketplaceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String query = request.getParameter("query");
        String category = request.getParameter("category");

        List<MarketplaceItem> items = dao.searchItems(query, category);
        request.setAttribute("items", items);
        request.setAttribute("searchQuery", query);
        request.setAttribute("selectedCategory", category);

        request.getRequestDispatcher("marketplace.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
