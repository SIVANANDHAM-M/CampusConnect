package com.campusconnect.servlet;

import com.campusconnect.dao.StudentDAO;
import com.campusconnect.dao.UserDAO;
import com.campusconnect.model.Student;
import com.campusconnect.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO = new UserDAO();
    private StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect if already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("studentDashboard.jsp");
            }
            return;
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and Password cannot be empty!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.authenticateUser(username.trim(), password.trim());

        if (user != null) {
            // Authentication successful - setup session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("STUDENT".equalsIgnoreCase(user.getRole())) {
                Student student = studentDAO.getStudentByUserId(user.getId());
                session.setAttribute("student", student);
            }

            // Cookie handling for "Remember Username"
            if ("on".equalsIgnoreCase(rememberMe) || "true".equalsIgnoreCase(rememberMe)) {
                Cookie cookie = new Cookie("savedUsername", username.trim());
                cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days expiration
                response.addCookie(cookie);
            } else {
                Cookie cookie = new Cookie("savedUsername", "");
                cookie.setMaxAge(0); // Delete cookie
                response.addCookie(cookie);
            }

            // Role-based redirection
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("studentDashboard.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid Username or Password! Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
