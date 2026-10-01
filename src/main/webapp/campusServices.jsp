<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.ServiceRequest" %>
<%@ page import="java.util.List" %>
<%
    List<ServiceRequest> myRequests = (List<ServiceRequest>) request.getAttribute("myRequests");
    if (myRequests == null) {
        response.sendRedirect("serviceRequest");
        return;
    }
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Services &amp; Maintenance</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js" defer></script>
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Campus Services</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>Campus Services &amp; Maintenance Help Request</h2>
                <p>Report electrical, plumbing, Wi-Fi, lab, classroom, or washroom problems across college buildings.</p>
            </div>
            <a href="searchLostFound" class="btn-primary">🔍 Lost &amp; Found Portal</a>
        </div>

        <% if (msg != null) { %>
            <div class="alert alert-success">✅ <%= msg %></div>
        <% } %>

        <div style="display: grid; grid-template-columns: 1fr 1.5fr; gap: 25px;">
            
            <!-- Service Request Submission Form -->
            <div class="form-card" style="margin: 0; max-width: 100%;">
                <h3 style="color: var(--primary-dark); margin-bottom: 15px;">📝 Report a Campus Problem</h3>
                <form action="serviceRequest" method="post">
                    <div class="form-group">
                        <label>Problem Category</label>
                        <select name="category" class="form-control" required>
                            <option value="Electrical">Electrical (Lights, Fans, Power Outlets)</option>
                            <option value="Plumbing">Plumbing (Water Leaks, Taps)</option>
                            <option value="Laboratory">Laboratory Equipment / PC</option>
                            <option value="Internet / Wi-Fi">Internet / Wi-Fi Connectivity</option>
                            <option value="Classroom">Classroom / Projector / Board</option>
                            <option value="Washroom">Washroom / Sanitation</option>
                            <option value="Furniture">Furniture (Desk, Chair Damage)</option>
                            <option value="Cleaning">Campus Cleaning</option>
                            <option value="Other">Other Issues</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Location / Block / Room Number</label>
                        <input type="text" name="location" class="form-control" required placeholder="e.g. CSE Block Room 204 or Library 1st Floor">
                    </div>

                    <div class="form-group">
                        <label>Priority</label>
                        <select name="priority" class="form-control">
                            <option value="Low">Low Priority</option>
                            <option value="Medium" selected>Medium Priority</option>
                            <option value="High">High Priority (Urgent)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Problem Description</label>
                        <textarea name="description" class="form-control" required placeholder="Describe the specific problem in detail..."></textarea>
                    </div>

                    <button type="submit" class="btn-primary">Submit Service Request</button>
                </form>
            </div>

            <!-- List of My Submitted Requests -->
            <div style="background: #fff; padding: 20px; border-radius: 10px; box-shadow: var(--shadow-sm);">
                <h3 style="color: var(--primary-dark); margin-bottom: 15px;">📋 My Reported Requests</h3>
                
                <% if (myRequests.isEmpty()) { %>
                    <p class="text-muted">You have not reported any campus service requests yet.</p>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Category</th>
                                    <th>Location</th>
                                    <th>Priority</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (ServiceRequest req : myRequests) { %>
                                    <tr>
                                        <td><span class="badge badge-info"><%= req.getCategory() %></span></td>
                                        <td><%= req.getLocation() %></td>
                                        <td><span class="badge <%= "High".equalsIgnoreCase(req.getPriority()) ? "badge-danger" : "badge-warning" %>"><%= req.getPriority() %></span></td>
                                        <td><span class="badge badge-success"><%= req.getStatus() %></span></td>
                                        <td><small><%= req.getCreatedDate() %></small></td>
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
