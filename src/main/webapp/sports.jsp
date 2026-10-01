<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.SportsEvent" %>
<%@ page import="java.util.List" %>
<%
    List<SportsEvent> sportsList = (List<SportsEvent>) request.getAttribute("sportsList");
    if (sportsList == null) {
        response.sendRedirect("sports");
        return;
    }
    String msg = request.getParameter("msg");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sports Event Management - Campus Connect</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Sports Event Management</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>Inter-College Sports Competitions</h2>
                <p>Register online for cricket, football, volleyball, basketball, chess, and athletic tournaments.</p>
            </div>
        </div>

        <% if (msg != null) { %>
            <div class="alert alert-success">✅ <%= msg %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert alert-error">⚠️ <%= error %></div>
        <% } %>

        <div class="card-grid">
            <% for (SportsEvent se : sportsList) { %>
                <div class="service-card" style="border-top: 4px solid var(--success);">
                    <div>
                        <span class="badge badge-success" style="float: right;"><%= se.getSportName() %></span>
                        <h3 style="color: var(--primary-dark);"><%= se.getEventName() %></h3>
                        <p style="margin-top: 8px;"><%= se.getDescription() %></p>

                        <div style="background: #f8fafc; padding: 12px; border-radius: 6px; margin: 15px 0;">
                            <p>📅 <strong>Date:</strong> <%= se.getEventDate() %></p>
                            <p>📍 <strong>Venue:</strong> <%= se.getVenue() %></p>
                        </div>
                    </div>

                    <div>
                        <% if (se.isRegistered()) { %>
                            <button class="btn-primary" style="width: 100%; justify-content: center; background-color: var(--success); cursor: default;" disabled>
                                ✓ Participant Registered
                            </button>
                        <% } else { %>
                            <form action="registerSports" method="post">
                                <input type="hidden" name="sportsId" value="<%= se.getSportsId() %>">
                                <button type="submit" class="btn-primary" style="width: 100%; justify-content: center;">
                                    🏆 Register for Event
                                </button>
                            </form>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>

    </div>

</body>
</html>
