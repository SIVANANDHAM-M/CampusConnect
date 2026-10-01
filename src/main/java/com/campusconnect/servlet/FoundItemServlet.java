package com.campusconnect.servlet;

import com.campusconnect.dao.LostFoundDAO;
import com.campusconnect.model.FoundItem;
import com.campusconnect.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/reportFound")
public class FoundItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private LostFoundDAO dao = new LostFoundDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("reportFound.jsp").forward(request, response);
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
            String dateFoundStr = request.getParameter("dateFound");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            String contactInfo = request.getParameter("contactInfo");

            FoundItem item = new FoundItem();
            item.setStudentId(student.getStudentId());
            item.setItemName(itemName);
            item.setCategory(category);
            item.setDateFound(Date.valueOf(dateFoundStr));
            item.setLocation(location);
            item.setDescription(description);
            item.setContactInfo(contactInfo);

            boolean success = dao.addFoundItem(item);
            if (success) {
                response.sendRedirect("lostFound.jsp?msg=Found+item+reported+successfully");
            } else {
                request.setAttribute("error", "Failed to report found item.");
                request.getRequestDispatcher("reportFound.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input format or missing fields!");
            request.getRequestDispatcher("reportFound.jsp").forward(request, response);
        }
    }
}
