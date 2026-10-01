<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.*" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    String msg = request.getParameter("msg");
    String error = request.getParameter("error");

    List<ServiceRequest> serviceRequests = (List<ServiceRequest>) request.getAttribute("serviceRequests");
    List<LostItem> lostItems = (List<LostItem>) request.getAttribute("lostItems");
    List<FoundItem> foundItems = (List<FoundItem>) request.getAttribute("foundItems");
    List<MarketplaceItem> marketplaceItems = (List<MarketplaceItem>) request.getAttribute("marketplaceItems");
    List<HostelComplaint> hostelComplaints = (List<HostelComplaint>) request.getAttribute("hostelComplaints");
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    List<Notice> notices = (List<Notice>) request.getAttribute("notices");

    if (serviceRequests == null) {
        response.sendRedirect("admin");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Connect - Admin Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <div class="brand">
            🏛️ CAMPUS CONNECT <span>| Admin Management Console</span>
        </div>
        <div class="nav-links">
            <span>Logged in as <strong>Administrator</strong></span>
            <a href="logout" class="btn-logout">🚪 Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>Admin Control Center</h2>
                <p>Manage all campus services, update request statuses, publish official notices, and organize events.</p>
            </div>
            <div>
                <span class="badge badge-danger">ADMINISTRATOR</span>
            </div>
        </div>

        <% if (msg != null) { %>
            <div class="alert alert-success">✅ <%= msg %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert alert-error">⚠️ <%= error %></div>
        <% } %>

        <!-- Admin Quick Actions (Add Event & Add Notice Forms) -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px;">
            
            <!-- Add New College Event Form -->
            <div class="form-card" style="margin: 0; max-width: 100%;">
                <h3 style="color: var(--primary-dark); margin-bottom: 15px;">➕ Create New College Event</h3>
                <form action="events" method="post">
                    <div class="form-group">
                        <label>Event Name</label>
                        <input type="text" name="eventName" class="form-control" required placeholder="e.g. CYBERTRON 2026">
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                        <div class="form-group">
                            <label>Event Date</label>
                            <input type="date" name="eventDate" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Event Time</label>
                            <input type="text" name="eventTime" class="form-control" required placeholder="09:30 AM">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Venue</label>
                        <input type="text" name="venue" class="form-control" required placeholder="Main Auditorium">
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" class="form-control" required placeholder="Event description and rules..."></textarea>
                    </div>
                    <button type="submit" class="btn-primary">Post Event</button>
                </form>
            </div>

            <!-- Publish New Notice Form -->
            <div class="form-card" style="margin: 0; max-width: 100%;">
                <h3 style="color: var(--primary-dark); margin-bottom: 15px;">📌 Publish Official Campus Notice</h3>
                <form action="notices" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="form-group">
                        <label>Notice Title</label>
                        <input type="text" name="title" class="form-control" required placeholder="e.g. Exam Schedule Release">
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                        <div class="form-group">
                            <label>Category</label>
                            <select name="category" class="form-control">
                                <option>Examination</option>
                                <option>Placement</option>
                                <option>Hostel</option>
                                <option>Transport</option>
                                <option>General</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Date</label>
                            <input type="date" name="noticeDate" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Notice Description</label>
                        <textarea name="description" class="form-control" required placeholder="Full notice announcement text..."></textarea>
                    </div>
                    <button type="submit" class="btn-primary">Publish Notice</button>
                </form>
            </div>

        </div>

        <!-- Section 1: Manage Campus Service Requests -->
        <div style="background: #fff; padding: 20px; border-radius: 10px; margin-bottom: 30px; box-shadow: var(--shadow-sm);">
            <h3 style="color: var(--primary-dark); margin-bottom: 15px;">🛠️ Campus Service Requests Management</h3>
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Req ID</th>
                            <th>Student</th>
                            <th>Category</th>
                            <th>Location</th>
                            <th>Priority</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Update Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (ServiceRequest req : serviceRequests) { %>
                            <tr>
                                <td>#<%= req.getRequestId() %></td>
                                <td><%= req.getStudentName() %></td>
                                <td><span class="badge badge-info"><%= req.getCategory() %></span></td>
                                <td><%= req.getLocation() %></td>
                                <td><span class="badge <%= "High".equalsIgnoreCase(req.getPriority()) ? "badge-danger" : "badge-warning" %>"><%= req.getPriority() %></span></td>
                                <td><%= req.getDescription() %></td>
                                <td><span class="badge badge-primary"><%= req.getStatus() %></span></td>
                                <td>
                                    <form action="admin" method="post" style="display: flex; gap: 6px;">
                                        <input type="hidden" name="action" value="updateServiceStatus">
                                        <input type="hidden" name="requestId" value="<%= req.getRequestId() %>">
                                        <select name="status" class="form-control" style="padding: 4px; font-size: 0.8rem;">
                                            <option value="Submitted">Submitted</option>
                                            <option value="Under Review">Under Review</option>
                                            <option value="Assigned">Assigned</option>
                                            <option value="In Progress">In Progress</option>
                                            <option value="Resolved">Resolved</option>
                                        </select>
                                        <button type="submit" class="btn-primary" style="padding: 4px 8px; font-size: 0.8rem;">Save</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Section 2: Manage General Helpdesk Complaints -->
        <div style="background: #fff; padding: 20px; border-radius: 10px; margin-bottom: 30px; box-shadow: var(--shadow-sm);">
            <h3 style="color: var(--primary-dark); margin-bottom: 15px;">📬 General Complaints / Help Desk</h3>
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Student</th>
                            <th>Category</th>
                            <th>Subject</th>
                            <th>Description</th>
                            <th>Current Status</th>
                            <th>Update Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Complaint c : complaints) { %>
                            <tr>
                                <td>#<%= c.getComplaintId() %></td>
                                <td><%= c.getStudentName() %></td>
                                <td><span class="badge badge-info"><%= c.getCategory() %></span></td>
                                <td><strong><%= c.getSubject() %></strong></td>
                                <td><%= c.getDescription() %></td>
                                <td><span class="badge badge-primary"><%= c.getStatus() %></span></td>
                                <td>
                                    <form action="admin" method="post" style="display: flex; gap: 6px;">
                                        <input type="hidden" name="action" value="updateComplaintStatus">
                                        <input type="hidden" name="complaintId" value="<%= c.getComplaintId() %>">
                                        <select name="status" class="form-control" style="padding: 4px; font-size: 0.8rem;">
                                            <option value="Submitted">Submitted</option>
                                            <option value="Under Review">Under Review</option>
                                            <option value="In Progress">In Progress</option>
                                            <option value="Resolved">Resolved</option>
                                        </select>
                                        <button type="submit" class="btn-primary" style="padding: 4px 8px; font-size: 0.8rem;">Save</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</body>
</html>
