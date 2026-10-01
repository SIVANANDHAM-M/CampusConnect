<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%
    // Check if savedUsername cookie exists
    String savedUsername = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("savedUsername".equals(c.getName())) {
                savedUsername = c.getValue();
                break;
            }
        }
    }

    String logoutMsg = request.getParameter("logout");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Connect - Unified Login</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js" defer></script>
</head>
<body class="login-body">

    <div class="login-card">
        <div class="login-header">
            <h1>🏛️ CAMPUS CONNECT</h1>
            <p>Integrated Campus Service &amp; Fresher Portal</p>
        </div>

        <% if (logoutMsg != null && "true".equals(logoutMsg)) { %>
            <div class="alert alert-info">
                ℹ️ You have logged out successfully.
            </div>
        <% } %>

        <% if (errorMessage != null) { %>
            <div class="alert alert-error">
                ⚠️ <%= errorMessage %>
            </div>
        <% } %>

        <!-- JS Dynamic Error Container -->
        <div id="jsErrorMessage" style="display: none;"></div>

        <form id="loginForm" action="login" method="post">
            <div class="form-group">
                <label for="username">Username / Register Number</label>
                <input type="text" id="username" name="username" class="form-control" 
                       placeholder="e.g., 21CS001 or admin" value="<%= savedUsername %>" required autofocus>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" 
                       placeholder="Enter your password" required>
            </div>

            <div class="form-group" style="display: flex; align-items: center; gap: 8px;">
                <input type="checkbox" id="rememberMe" name="rememberMe" <%= !savedUsername.isEmpty() ? "checked" : "" %>>
                <label for="rememberMe" style="margin-bottom: 0; font-weight: normal;">Remember Username (Cookies)</label>
            </div>

            <div style="display: flex; gap: 10px; margin-top: 25px;">
                <button type="submit" class="btn-primary" style="flex: 1; justify-content: center;">🔑 Login</button>
                <button type="reset" class="btn-secondary" style="flex: 1;">🧹 Clear</button>
            </div>
        </form>

        <div style="margin-top: 25px; text-align: center; font-size: 0.85rem; color: var(--text-muted); border-top: 1px solid var(--border-color); padding-top: 15px;">
            <p><strong>Demo Credentials:</strong></p>
            <p><strong>Student:</strong> 21CS001 / student123</p>
            <p><strong>Admin:</strong> admin / admin123</p>
        </div>
    </div>

</body>
</html>
