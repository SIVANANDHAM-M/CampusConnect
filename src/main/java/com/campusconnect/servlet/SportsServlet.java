package com.campusconnect.servlet;

import com.campusconnect.dao.SportsDAO;
import com.campusconnect.model.SportsEvent;
import com.campusconnect.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/sports")
public class SportsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private SportsDAO dao = new SportsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Student student = (session != null) ? (Student) session.getAttribute("student") : null;
        int studentId = (student != null) ? student.getStudentId() : 0;

        List<SportsEvent> sportsList = dao.getAllSportsEvents(studentId);
        request.setAttribute("sportsList", sportsList);
        request.getRequestDispatcher("sports.jsp").forward(request, response);
    }
}
