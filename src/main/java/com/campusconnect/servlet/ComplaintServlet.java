package com.campusconnect.servlet;

import com.campusconnect.dao.ComplaintDAO;
import com.campusconnect.model.Complaint;
import com.campusconnect.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/complaints")
public class ComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ComplaintDAO dao = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Student student = (session != null) ? (Student) session.getAttribute("student") : null;
        if (student != null) {
            request.setAttribute("myComplaints", dao.getComplaintsByStudent(student.getStudentId()));
        }
        request.getRequestDispatcher("complaints.jsp").forward(request, response);
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
        String subject = request.getParameter("subject");
        String description = request.getParameter("description");

        Complaint c = new Complaint();
        c.setStudentId(student.getStudentId());
        c.setCategory(category);
        c.setSubject(subject);
        c.setDescription(description);

        boolean success = dao.addComplaint(c);
        if (success) {
            response.sendRedirect("complaints.jsp?msg=Complaint+submitted+successfully");
        } else {
            request.setAttribute("error", "Failed to submit complaint.");
            doGet(request, response);
        }
    }
}
