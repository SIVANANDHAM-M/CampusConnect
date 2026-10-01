<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.Complaint" %>
<%@ page import="java.util.List" %>
<%
    List<Complaint> myComplaints = (List<Complaint>) request.getAttribute("myComplaints");
    if (myComplaints == null) {
        response.sendRedirect("complaints");
        return;
    }
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Complaint &amp; Help Desk - Campus Connect</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js" defer></script>
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Student Help Desk</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>Student Complaint &amp; Help Desk Tracker</h2>
                <p>Submit formal complaints or academic grievances and monitor real-time resolution progress.</p>
            </div>
        </div>

        <% if (msg != null) { %>
            <div class="alert alert-success">✅ <%= msg %></div>
        <% } %>

        <div style="display: grid; grid-template-columns: 1fr 1.5fr; gap: 25px;">
            
            <!-- Complaint Submission Form -->
            <div class="form-card" style="margin: 0; max-width: 100%;">
                <h3 style="color: var(--primary-dark); margin-bottom: 15px;">📝 Submit New Complaint</h3>
                <form action="complaints" method="post">
                    <div class="form-group">
                        <label>Category</label>
                        <select name="category" class="form-control" required>
                            <option value="Hostel">Hostel</option>
                            <option value="Transport">Transport / Bus</option>
                            <option value="Library">Library</option>
                            <option value="Department">Department / Academic</option>
                            <option value="Examination">Examination Cell</option>
                            <option value="IT Support">IT Support / ERP Portal</option>
                            <option value="Campus">Campus Infrastructure</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Subject</label>
                        <input type="text" name="subject" class="form-control" required placeholder="Brief summary of issue...">
                    </div>

                    <div class="form-group">
                        <label>Detailed Description</label>
                        <textarea name="description" class="form-control" required placeholder="Provide clear details regarding your grievance..."></textarea>
                    </div>

                    <button type="submit" class="btn-primary">Submit Complaint</button>
                </form>
            </div>

            <!-- List of My Complaints -->
            <div style="background: #fff; padding: 20px; border-radius: 10px; box-shadow: var(--shadow-sm);">
                <h3 style="color: var(--primary-dark); margin-bottom: 15px;">📋 My Filed Complaints</h3>
                
                <% if (myComplaints.isEmpty()) { %>
                    <p class="text-muted">You have not filed any complaints yet.</p>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Subject</th>
                                    <th>Category</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Complaint c : myComplaints) { %>
                                    <tr>
                                        <td><strong><%= c.getSubject() %></strong></td>
                                        <td><span class="badge badge-info"><%= c.getCategory() %></span></td>
                                        <td><span class="badge badge-primary"><%= c.getStatus() %></span></td>
                                        <td><small><%= c.getCreatedDate() %></small></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            </div>

        </div>
    </div>

</body>
</html>
