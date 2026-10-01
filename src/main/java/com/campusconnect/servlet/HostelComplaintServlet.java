package com.campusconnect.servlet;

import com.campusconnect.dao.HostelDAO;
import com.campusconnect.model.HostelComplaint;
import com.campusconnect.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/hostelComplaint")
public class HostelComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private HostelDAO dao = new HostelDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("hostels", dao.getAllHostels());
        request.getRequestDispatcher("hostelComplaint.jsp").forward(request, response);
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
            int hostelId = Integer.parseInt(request.getParameter("hostelId"));
            String roomNo = request.getParameter("roomNo");
            String category = request.getParameter("category");
            String description = request.getParameter("description");

            HostelComplaint complaint = new HostelComplaint();
            complaint.setStudentId(student.getStudentId());
            complaint.setHostelId(hostelId);
            complaint.setRoomNo(roomNo);
            complaint.setCategory(category);
            complaint.setDescription(description);

            boolean success = dao.addHostelComplaint(complaint);
            if (success) {
                response.sendRedirect("hostel.jsp?msg=Hostel+complaint+submitted+successfully");
            } else {
                request.setAttribute("error", "Failed to submit hostel complaint.");
                doGet(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input or missing fields.");
            doGet(request, response);
        }
    }
}
