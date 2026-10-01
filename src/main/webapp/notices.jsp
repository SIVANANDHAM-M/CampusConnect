<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.Notice" %>
<%@ page import="java.util.List" %>
<%
    List<Notice> notices = (List<Notice>) request.getAttribute("notices");
    if (notices == null) {
        response.sendRedirect("notices");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Notice Board - Campus Connect</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Official Notice Board</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>Campus Official Notice Board</h2>
                <p>Stay updated with official college announcements regarding exams, placements, events, and holidays.</p>
            </div>
            <div>
                <span class="badge badge-primary">CAMPUS FEED</span>
            </div>
        </div>

        <div style="display: flex; flex-direction: column; gap: 20px;">
            <% if (notices.isEmpty()) { %>
                <p class="text-muted">No notices posted at this time.</p>
            <% } else { %>
                <% for (Notice n : notices) { %>
                    <div style="background: #fff; padding: 22px; border-radius: 10px; border-left: 5px solid var(--primary-light); box-shadow: var(--shadow-sm);">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                            <h3 style="color: var(--primary-dark);"><%= n.getTitle() %></h3>
                            <span class="badge badge-info"><%= n.getCategory() %></span>
                        </div>
                        <p style="color: var(--text-main); font-size: 0.95rem; margin-bottom: 12px;"><%= n.getDescription() %></p>
                        <div style="color: var(--text-muted); font-size: 0.85rem;">
                            📅 <strong>Posted Date:</strong> <%= n.getNoticeDate() %>
                        </div>
                    </div>
                <% } %>
            <% } %>
        </div>

    </div>

</body>
</html>
