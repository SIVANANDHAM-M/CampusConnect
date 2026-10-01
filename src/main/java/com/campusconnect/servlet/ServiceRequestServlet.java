package com.campusconnect.servlet;

import com.campusconnect.dao.ServiceRequestDAO;
import com.campusconnect.model.ServiceRequest;
import com.campusconnect.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/serviceRequest")
public class ServiceRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ServiceRequestDAO dao = new ServiceRequestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Student student = (session != null) ? (Student) session.getAttribute("student") : null;
        if (student != null) {
            request.setAttribute("myRequests", dao.getRequestsByStudent(student.getStudentId()));
        }
        request.getRequestDispatcher("campusServices.jsp").forward(request, response);
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

        String category = request.getParameter("category");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String priority = request.getParameter("priority");

        ServiceRequest req = new ServiceRequest();
        req.setStudentId(student.getStudentId());
        req.setCategory(category);
        req.setLocation(location);
        req.setDescription(description);
        req.setPriority(priority != null ? priority : "Medium");

        boolean success = dao.addServiceRequest(req);
        if (success) {
            response.sendRedirect("campusServices.jsp?msg=Service+request+submitted+successfully");
        } else {
            request.setAttribute("error", "Failed to submit request.");
            doGet(request, response);
        }
    }
}
