package com.campusconnect.servlet;

import com.campusconnect.dao.LostFoundDAO;
import com.campusconnect.model.FoundItem;
import com.campusconnect.model.LostItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/searchLostFound")
public class LostFoundSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private LostFoundDAO dao = new LostFoundDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String query = request.getParameter("query");
        String category = request.getParameter("category");
        String location = request.getParameter("location");

        List<LostItem> allLost = dao.getAllLostItems();
        List<FoundItem> allFound = dao.getAllFoundItems();

        List<LostItem> filteredLost = new ArrayList<>();
        List<FoundItem> filteredFound = new ArrayList<>();

        for (LostItem l : allLost) {
            boolean matchesQuery = (query == null || query.trim().isEmpty() || l.getItemName().toLowerCase().contains(query.toLowerCase()) || l.getDescription().toLowerCase().contains(query.toLowerCase()));
            boolean matchesCategory = (category == null || category.trim().isEmpty() || category.equalsIgnoreCase("All") || l.getCategory().equalsIgnoreCase(category));
            boolean matchesLocation = (location == null || location.trim().isEmpty() || l.getLocation().toLowerCase().contains(location.toLowerCase()));

            if (matchesQuery && matchesCategory && matchesLocation) {
                filteredLost.add(l);
            }
        }

        for (FoundItem f : allFound) {
            boolean matchesQuery = (query == null || query.trim().isEmpty() || f.getItemName().toLowerCase().contains(query.toLowerCase()) || f.getDescription().toLowerCase().contains(query.toLowerCase()));
            boolean matchesCategory = (category == null || category.trim().isEmpty() || category.equalsIgnoreCase("All") || f.getCategory().equalsIgnoreCase(category));
            boolean matchesLocation = (location == null || location.trim().isEmpty() || f.getLocation().toLowerCase().contains(location.toLowerCase()));

            if (matchesQuery && matchesCategory && matchesLocation) {
                filteredFound.add(f);
            }
        }

        request.setAttribute("lostItems", filteredLost);
        request.setAttribute("foundItems", filteredFound);
        request.setAttribute("searchQuery", query);
        request.setAttribute("searchCategory", category);
        request.setAttribute("searchLocation", location);

        request.getRequestDispatcher("lostFound.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
