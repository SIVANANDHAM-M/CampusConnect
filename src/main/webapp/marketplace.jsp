<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.MarketplaceItem" %>
<%@ page import="java.util.List" %>
<%
    List<MarketplaceItem> items = (List<MarketplaceItem>) request.getAttribute("items");
    if (items == null) {
        response.sendRedirect("marketplace");
        return;
    }
    String msg = request.getParameter("msg");
    String searchQuery = (String) request.getAttribute("searchQuery");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Campus Marketplace - Buy &amp; Sell</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Campus Marketplace</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>Campus Buy &amp; Sell Marketplace</h2>
                <p>Peer-to-peer campus marketplace for students to buy or sell used textbooks, calculators, lab items, and stationery.</p>
            </div>
            <a href="sellItem.jsp" class="btn-primary" style="background-color: var(--success);">🏷️ Sell an Item</a>
        </div>

        <% if (msg != null) { %>
            <div class="alert alert-success">✅ <%= msg %></div>
        <% } %>

        <!-- Filter / Search Bar -->
        <div style="background: #fff; padding: 20px; border-radius: 10px; margin-bottom: 25px; box-shadow: var(--shadow-sm);">
            <form action="marketplace" method="get" style="display: flex; gap: 15px; align-items: flex-end;">
                <div style="flex: 2;">
                    <label>Search Marketplace</label>
                    <input type="text" name="query" class="form-control" placeholder="Search by book title or item name..." value="<%= searchQuery != null ? searchQuery : "" %>">
                </div>
                <div style="flex: 1;">
                    <label>Category</label>
                    <select name="category" class="form-control">
                        <option value="All">All Categories</option>
                        <option value="Used Books">Used Books</option>
                        <option value="Calculator">Calculator</option>
                        <option value="Lab Equipment">Lab Equipment</option>
                        <option value="Electronics">Electronics</option>
                    </select>
                </div>
                <button type="submit" class="btn-primary">🔍 Filter</button>
            </form>
        </div>

        <!-- Marketplace Products Grid -->
        <div class="card-grid">
            <% if (items.isEmpty()) { %>
                <p class="text-muted" style="grid-column: 1 / -1;">No products available matching your search term.</p>
            <% } else { %>
                <% for (MarketplaceItem item : items) { %>
                    <div class="service-card" style="border-top: 4px solid var(--primary-light);">
                        <div>
                            <span class="badge badge-info" style="float: right;"><%= item.getCategory() %></span>
                            <h3 style="margin-top: 5px;"><%= item.getItemName() %></h3>
                            <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 8px;"><%= item.getDescription() %></p>
                            
                            <div style="margin: 15px 0;">
                                <h4 style="color: var(--success); font-size: 1.4rem;">₹ <%= item.getPrice() %></h4>
                                <small style="color: var(--text-muted);">Seller: <%= item.getStudentName() %></small>
                            </div>
                        </div>

                        <div>
                            <span class="badge <%= "AVAILABLE".equalsIgnoreCase(item.getStatus()) ? "badge-success" : "badge-danger" %>" style="display: block; text-align: center; margin-bottom: 10px;">
                                <%= item.getStatus() %>
                            </span>
                            <a href="mailto:<%= item.getContact() %>" class="btn-access" style="background-color: var(--accent);">
                                📞 Contact Seller (<%= item.getContact() %>)
                            </a>
                        </div>
                    </div>
                <% } %>
            <% } %>
        </div>

    </div>

</body>
</html>
