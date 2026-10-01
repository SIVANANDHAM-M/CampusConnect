package com.campusconnect.servlet;

import com.campusconnect.dao.MarketplaceDAO;
import com.campusconnect.model.MarketplaceItem;
import com.campusconnect.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/sellItem")
public class SellItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private MarketplaceDAO dao = new MarketplaceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("sellItem.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Student student = (session != null) ? (Student) session.getAttribute("student") : null;
        if (student == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String itemName = request.getParameter("itemName");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String contact = request.getParameter("contact");

            MarketplaceItem item = new MarketplaceItem();
            item.setStudentId(student.getStudentId());
            item.setItemName(itemName);
            item.setCategory(category);
            item.setDescription(description);
            item.setPrice(new BigDecimal(priceStr));
            item.setContact(contact);

            boolean success = dao.addMarketplaceItem(item);
            if (success) {
                response.sendRedirect("marketplace.jsp?msg=Item+listed+for+sale+successfully");
            } else {
                request.setAttribute("error", "Failed to list item for sale.");
                request.getRequestDispatcher("sellItem.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid price or missing input values.");
            request.getRequestDispatcher("sellItem.jsp").forward(request, response);
        }
    }
}
