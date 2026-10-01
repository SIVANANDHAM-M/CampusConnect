<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.Hostel" %>
<%@ page import="java.util.List" %>
<%
    List<Hostel> hostels = (List<Hostel>) request.getAttribute("hostels");
    if (hostels == null) {
        response.sendRedirect("hostel");
        return;
    }
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hostel Management - Campus Connect</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Hostel Management</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>Campus Hostel Management</h2>
                <p>Information on hostel blocks, warden contact numbers, mess timings, and complaint lodging.</p>
            </div>
            <a href="hostelComplaint" class="btn-primary" style="background-color: var(--warning);">📝 Submit Hostel Complaint</a>
        </div>

        <% if (msg != null) { %>
            <div class="alert alert-success">✅ <%= msg %></div>
        <% } %>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 25px; margin-bottom: 30px;">
            <% for (Hostel h : hostels) { %>
                <div class="service-card">
                    <div>
                        <span class="badge badge-primary" style="float: right;">Hostel Block</span>
                        <h3 style="color: var(--primary-dark);"><%= h.getHostelName() %></h3>
                        <p style="margin-top: 10px;"><%= h.getDescription() %></p>
                        
                        <div style="background: #eff6ff; padding: 12px; border-radius: 6px; margin: 15px 0;">
                            <p>👨‍💼 <strong>Warden:</strong> <%= h.getWarden() %></p>
                            <p>📞 <strong>Phone:</strong> <%= h.getContact() %></p>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>

        <!-- Hostel Rules Section -->
        <div style="background: #fff; padding: 25px; border-radius: 10px; box-shadow: var(--shadow-sm);">
            <h3 style="color: var(--primary-dark); margin-bottom: 15px;">📜 General Hostel Rules &amp; Guidelines</h3>
            <ul style="padding-left: 20px; line-height: 1.8; color: var(--text-main);">
                <li>Curfew time for all hostels is strictly <strong>08:30 PM</strong>. Outing passes must be signed by Warden.</li>
                <li>Mess Timings: Breakfast (07:30 AM - 09:00 AM), Lunch (12:30 PM - 02:00 PM), Dinner (07:30 PM - 09:00 PM).</li>
                <li>Loud music, electric heaters, and cooking appliances inside rooms are strictly prohibited.</li>
                <li>Maintain cleanliness inside rooms and corridors. Submit utility repair requests immediately via portal.</li>
            </ul>
        </div>
    </div>

</body>
</html>
