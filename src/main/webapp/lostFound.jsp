<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.LostItem" %>
<%@ page import="com.campusconnect.model.FoundItem" %>
<%@ page import="java.util.List" %>
<%
    List<LostItem> lostItems = (List<LostItem>) request.getAttribute("lostItems");
    List<FoundItem> foundItems = (List<FoundItem>) request.getAttribute("foundItems");
    if (lostItems == null || foundItems == null) {
        response.sendRedirect("searchLostFound");
        return;
    }
    String msg = request.getParameter("msg");
    String searchQuery = (String) request.getAttribute("searchQuery");
    String searchCategory = (String) request.getAttribute("searchCategory");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Campus Lost &amp; Found Portal</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Lost &amp; Found Hub</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>Lost &amp; Found Central Portal</h2>
                <p>Report lost belongings, log found objects, or search for potential lost/found item matches.</p>
            </div>
            <div style="display: flex; gap: 10px;">
                <a href="reportLost.jsp" class="btn-primary" style="background-color: var(--danger);">🚨 Report Lost Item</a>
                <a href="reportFound.jsp" class="btn-primary" style="background-color: var(--success);">📦 Report Found Item</a>
            </div>
        </div>

        <% if (msg != null) { %>
            <div class="alert alert-success">✅ <%= msg %></div>
        <% } %>

        <!-- Filter / Search Box -->
        <div style="background: #fff; padding: 20px; border-radius: 10px; margin-bottom: 25px; box-shadow: var(--shadow-sm);">
            <form action="searchLostFound" method="get" style="display: flex; gap: 15px; align-items: flex-end;">
                <div style="flex: 2;">
                    <label>Search Keyword (Item name, location, details)</label>
                    <input type="text" name="query" class="form-control" placeholder="e.g. Samsung, Key, CSE Block" value="<%= searchQuery != null ? searchQuery : "" %>">
                </div>
                <div style="flex: 1;">
                    <label>Category Filter</label>
                    <select name="category" class="form-control">
                        <option value="All">All Categories</option>
                        <option value="Mobile Phone">Mobile Phone</option>
                        <option value="Key">Key</option>
                        <option value="College ID Card">College ID Card</option>
                        <option value="Calculator">Calculator</option>
                        <option value="Book">Book</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <button type="submit" class="btn-primary">🔍 Search &amp; Match</button>
            </form>
        </div>

        <!-- 2 Column Display (Lost Items & Found Items) -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 25px;">
            
            <!-- Column 1: Lost Items -->
            <div style="background: #fff; padding: 20px; border-radius: 10px; box-shadow: var(--shadow-sm);">
                <h3 style="color: var(--danger); margin-bottom: 15px;">🔴 Reported Lost Items</h3>
                <% if (lostItems.isEmpty()) { %>
                    <p class="text-muted">No lost items match the current search criteria.</p>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Category / Location</th>
                                    <th>Date Lost</th>
                                    <th>Contact</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (LostItem l : lostItems) { %>
                                    <tr>
                                        <td>
                                            <strong><%= l.getItemName() %></strong><br>
                                            <small><%= l.getDescription() %></small>
                                        </td>
                                        <td>
                                            <span class="badge badge-info"><%= l.getCategory() %></span><br>
                                            <small>📍 <%= l.getLocation() %></small>
                                        </td>
                                        <td><%= l.getDateLost() %></td>
                                        <td><small><%= l.getContactInfo() %></small></td>
                                        <td><span class="badge badge-danger"><%= l.getStatus() %></span></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            </div>

            <!-- Column 2: Found Items -->
            <div style="background: #fff; padding: 20px; border-radius: 10px; box-shadow: var(--shadow-sm);">
                <h3 style="color: var(--success); margin-bottom: 15px;">🟢 Reported Found Items</h3>
                <% if (foundItems.isEmpty()) { %>
                    <p class="text-muted">No found items match the current search criteria.</p>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Category / Location</th>
                                    <th>Date Found</th>
                                    <th>Contact</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (FoundItem f : foundItems) { %>
                                    <tr>
                                        <td>
                                            <strong><%= f.getItemName() %></strong><br>
                                            <small><%= f.getDescription() %></small>
                                        </td>
                                        <td>
                                            <span class="badge badge-info"><%= f.getCategory() %></span><br>
                                            <small>📍 <%= f.getLocation() %></small>
                                        </td>
                                        <td><%= f.getDateFound() %></td>
                                        <td><small><%= f.getContactInfo() %></small></td>
                                        <td><span class="badge badge-success"><%= f.getStatus() %></span></td>
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
