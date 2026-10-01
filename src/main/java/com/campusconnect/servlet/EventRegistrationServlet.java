package com.campusconnect.servlet;

import com.campusconnect.dao.EventDAO;
import com.campusconnect.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/registerEvent")
public class EventRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EventDAO dao = new EventDAO();

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
            int eventId = Integer.parseInt(request.getParameter("eventId"));

            if (dao.isStudentRegistered(eventId, student.getStudentId())) {
                response.sendRedirect("events.jsp?error=Already+registered+for+this+event!");
                return;
            }

            boolean success = dao.registerForEvent(eventId, student.getStudentId());
            if (success) {
                response.sendRedirect("events.jsp?msg=Event+registration+successful!");
            } else {
                response.sendRedirect("events.jsp?error=Registration+failed.+Please+try+again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("events.jsp?error=Invalid+event+id");
        }
    }
}
