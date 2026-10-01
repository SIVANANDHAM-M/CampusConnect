<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.Event" %>
<%@ page import="java.util.List" %>
<%
    List<Event> events = (List<Event>) request.getAttribute("events");
    if (events == null) {
        response.sendRedirect("events");
        return;
    }
    String msg = request.getParameter("msg");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>College Event Management - Campus Connect</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| College Events</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>College Events &amp; Symposiums</h2>
                <p>Register for technical symposiums, orientation gala, workshops, and coding competitions.</p>
            </div>
        </div>

        <% if (msg != null) { %>
            <div class="alert alert-success">✅ <%= msg %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert alert-error">⚠️ <%= error %></div>
        <% } %>

        <div class="card-grid">
            <% if (events.isEmpty()) { %>
                <p class="text-muted">No upcoming college events scheduled at this time.</p>
            <% } else { %>
                <% for (Event ev : events) { %>
                    <div class="service-card" style="border-top: 4px solid var(--accent);">
                        <div>
                            <span class="badge badge-primary" style="float: right;"><%= ev.getStatus() %></span>
                            <h3 style="color: var(--primary-dark);"><%= ev.getEventName() %></h3>
                            <p style="margin-top: 10px;"><%= ev.getDescription() %></p>
                            
                            <div style="background: #f8fafc; padding: 12px; border-radius: 6px; margin: 15px 0; font-size: 0.9rem;">
                                <p>📅 <strong>Date:</strong> <%= ev.getEventDate() %></p>
                                <p>⏰ <strong>Time:</strong> <%= ev.getEventTime() %></p>
                                <p>📍 <strong>Venue:</strong> <%= ev.getVenue() %></p>
                            </div>
                        </div>

                        <div>
                            <% if (ev.isRegistered()) { %>
                                <button class="btn-primary" style="width: 100%; justify-content: center; background-color: var(--success); cursor: default;" disabled>
                                    ✓ Already Registered
                                </button>
                            <% } else { %>
                                <form action="registerEvent" method="post">
                                    <input type="hidden" name="eventId" value="<%= ev.getEventId() %>">
                                    <button type="submit" class="btn-primary" style="width: 100%; justify-content: center;">
                                        ✍️ Register Now
                                    </button>
                                </form>
                            <% } %>
                        </div>
                    </div>
                <% } %>
            <% } %>
        </div>

    </div>

</body>
</html>
