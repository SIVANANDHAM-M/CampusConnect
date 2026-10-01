<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.Student" %>
<%
    User user = (User) session.getAttribute("user");
    Student student = (Student) request.getAttribute("studentProfile");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (student == null && "STUDENT".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("profile");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Profile - Campus Connect</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Student Profile</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="form-card" style="max-width: 600px;">
            <div style="text-align: center; margin-bottom: 25px;">
                <div style="width: 80px; height: 80px; background: #e0e7ff; color: var(--accent); font-size: 2.5rem; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px;">
                    👤
                </div>
                <h2 style="color: var(--primary-dark);"><%= student != null ? student.getName() : user.getUsername() %></h2>
                <span class="badge badge-primary"><%= student != null ? student.getDepartment() : user.getRole() %></span>
            </div>

            <% if (student != null) { %>
                <div style="background: #f8fafc; border-radius: 8px; padding: 20px; border: 1px solid var(--border-color);">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                        <div>
                            <label style="font-size: 0.8rem; color: var(--text-muted); text-transform: uppercase;">Register Number</label>
                            <p style="font-weight: 700; font-size: 1.1rem; color: var(--primary-dark);"><%= student.getRegisterNo() %></p>
                        </div>
                        <div>
                            <label style="font-size: 0.8rem; color: var(--text-muted); text-transform: uppercase;">Academic Year</label>
                            <p style="font-weight: 700; font-size: 1.1rem; color: var(--primary-dark);"><%= student.getYear() %></p>
                        </div>
                        <div style="grid-column: 1 / -1;">
                            <label style="font-size: 0.8rem; color: var(--text-muted); text-transform: uppercase;">Department</label>
                            <p style="font-weight: 600; color: var(--text-main);"><%= student.getDepartment() %></p>
                        </div>
                        <div>
                            <label style="font-size: 0.8rem; color: var(--text-muted); text-transform: uppercase;">Email Address</label>
                            <p style="font-weight: 600; color: var(--text-main);"><%= student.getEmail() %></p>
                        </div>
                        <div>
                            <label style="font-size: 0.8rem; color: var(--text-muted); text-transform: uppercase;">Phone Number</label>
                            <p style="font-weight: 600; color: var(--text-main);"><%= student.getPhone() %></p>
                        </div>
                    </div>
                </div>
            <% } else { %>
                <p class="text-muted">Administrator account details. Role: <strong>ADMIN</strong></p>
            <% } %>
        </div>
    </div>

</body>
</html>
