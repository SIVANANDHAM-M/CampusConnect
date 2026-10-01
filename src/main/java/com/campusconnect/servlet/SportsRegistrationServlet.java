package com.campusconnect.servlet;

import com.campusconnect.dao.SportsDAO;
import com.campusconnect.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/registerSports")
public class SportsRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private SportsDAO dao = new SportsDAO();

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
            int sportsId = Integer.parseInt(request.getParameter("sportsId"));
            boolean success = dao.registerForSports(sportsId, student.getStudentId());
            if (success) {
                response.sendRedirect("sports.jsp?msg=Registered+for+sports+event+successfully!");
            } else {
                response.sendRedirect("sports.jsp?error=Already+registered+or+registration+failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("sports.jsp?error=Invalid+sports+id.");
        }
    }
}
