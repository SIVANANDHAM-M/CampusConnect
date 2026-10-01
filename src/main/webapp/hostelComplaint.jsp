<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.Hostel" %>
<%@ page import="java.util.List" %>
<%
    List<Hostel> hostels = (List<Hostel>) request.getAttribute("hostels");
    if (hostels == null) {
        response.sendRedirect("hostelComplaint");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Hostel Complaint - Campus Connect</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Hostel Complaint</span></div>
        <div class="nav-links">
            <a href="hostel">&larr; Back to Hostel Portal</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="form-card">
            <h2 style="color: var(--primary-dark); margin-bottom: 20px;">🏢 File a Hostel Complaint</h2>

            <form action="hostelComplaint" method="post">
                <div class="form-group">
                    <label>Select Hostel Block</label>
                    <select name="hostelId" class="form-control" required>
                        <% for (Hostel h : hostels) { %>
                            <option value="<%= h.getHostelId() %>"><%= h.getHostelName() %></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label>Room Number</label>
                    <input type="text" name="roomNo" class="form-control" required placeholder="e.g. Room 304">
                </div>

                <div class="form-group">
                    <label>Complaint Category</label>
                    <select name="category" class="form-control" required>
                        <option value="Room">Room (Furniture, Lock, Window)</option>
                        <option value="Mess">Mess / Food Quality</option>
                        <option value="Water">Water Supply / Hot Water</option>
                        <option value="Electricity">Electricity / Fan / Light</option>
                        <option value="Cleaning">Restroom / Room Housekeeping</option>
                        <option value="Maintenance">General Maintenance</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Complaint Description</label>
                    <textarea name="description" class="form-control" required placeholder="Detailed description of the issue..."></textarea>
                </div>

                <button type="submit" class="btn-primary" style="width: 100%; justify-content: center;">Submit Complaint to Warden</button>
            </form>
        </div>
    </div>

</body>
</html>
