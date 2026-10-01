<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.Bus" %>
<%@ page import="com.campusconnect.model.BusStop" %>
<%@ page import="java.util.List" %>
<%
    List<Bus> buses = (List<Bus>) request.getAttribute("buses");
    if (buses == null) {
        response.sendRedirect("bus");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>College Bus Management - Campus Connect</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/ajax.js" defer></script>
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Bus Route Management</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>College Bus Routes &amp; Timings</h2>
                <p>Search routes, stops, starting points, and driver contacts dynamically without refreshing the page.</p>
            </div>
            <div>
                <span class="badge badge-info">AJAX DYNAMIC SEARCH</span>
            </div>
        </div>

        <!-- AJAX Search Input Box -->
        <div style="background: #fff; padding: 20px; border-radius: 10px; margin-bottom: 25px; box-shadow: var(--shadow-sm);">
            <div style="display: flex; gap: 15px; align-items: center;">
                <div style="flex: 1;">
                    <label style="font-weight: 600; margin-bottom: 6px; display: block;">Search Bus Route / Stop Name (AJAX Real-Time Search):</label>
                    <input type="text" id="busSearchInput" class="form-control" 
                           placeholder="Type route name, stop name, or bus number (e.g. Route 05, Central, Railway Station)..." 
                           onkeyup="searchBusRoutes()">
                </div>
                <button type="button" class="btn-primary" onclick="searchBusRoutes()" style="margin-top: 24px;">🔍 Search Route</button>
            </div>
        </div>

        <!-- Bus Search Results Container (Updated dynamically via AJAX DOM manipulation) -->
        <div id="busResultsContainer">
            <% for (Bus bus : buses) { %>
                <div class="bus-card">
                    <div class="bus-header">
                        <h3>🚌 <%= bus.getBusNumber() %> - <%= bus.getRouteName() %></h3>
                        <span class="timing-badge">Starts: <%= bus.getTiming() %></span>
                    </div>
                    <div class="bus-details">
                        <p><strong>Starting Point:</strong> <%= bus.getStartingPoint() %></p>
                        <p><strong>Driver:</strong> <%= bus.getDriverName() %> (📞 <%= bus.getDriverContact() %>)</p>
                    </div>
                    <div class="route-stops" style="margin-top: 15px;">
                        <h4>Route Stops:</h4>
                        <ol class="stops-timeline">
                            <% if (bus.getStops() != null) { %>
                                <% for (BusStop stop : bus.getStops()) { %>
                                    <li><%= stop.getStopName() %></li>
                                <% } %>
                            <% } %>
                        </ol>
                    </div>
                </div>
            <% } %>
        </div>

    </div>

</body>
</html>
