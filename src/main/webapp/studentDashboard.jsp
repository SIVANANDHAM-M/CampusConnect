<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.Student" %>
<%
    User user = (User) session.getAttribute("user");
    Student student = (Student) session.getAttribute("student");
    if (user == null || !"STUDENT".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Connect - Student Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <!-- Navigation Header -->
    <nav class="navbar">
        <div class="brand">
            🏛️ CAMPUS CONNECT <span>| Student Portal</span>
        </div>
        <div class="nav-links">
            <span style="font-size: 0.9rem;">Welcome, <strong><%= student != null ? student.getName() : user.getUsername() %></strong> (<%= student != null ? student.getRegisterNo() : "" %>)</span>
            <a href="profile.jsp">👤 My Profile</a>
            <a href="logout" class="btn-logout">🚪 Logout</a>
        </div>
    </nav>

    <!-- Main Content Container -->
    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>Student Dashboard</h2>
                <p>Access all campus services, lost &amp; found items, marketplace, events, bus routes, and fresher assistance from one centralized hub.</p>
            </div>
            <div>
                <span class="badge badge-primary"><%= student != null ? student.getDepartment() : "Student" %></span>
            </div>
        </div>

        <!-- 12 Service Cards Grid -->
        <div class="card-grid">

            <!-- 1. Campus Services -->
            <div class="service-card">
                <div class="icon-wrap">🛠️</div>
                <h3>Campus Services</h3>
                <p>Report electrical, plumbing, lab, Wi-Fi, or maintenance issues across campus facilities.</p>
                <a href="serviceRequest" class="btn-access">Open Service Portal &rarr;</a>
            </div>

            <!-- 2. Lost & Found -->
            <div class="service-card">
                <div class="icon-wrap">🔍</div>
                <h3>Lost &amp; Found</h3>
                <p>Report lost belongings, search found items, and match reported lost objects easily.</p>
                <a href="searchLostFound" class="btn-access">Lost &amp; Found Hub &rarr;</a>
            </div>

            <!-- 3. Campus Marketplace -->
            <div class="service-card">
                <div class="icon-wrap">🛒</div>
                <h3>Campus Marketplace</h3>
                <p>Buy or sell used textbooks, calculators, lab equipment, and electronics with fellow students.</p>
                <a href="marketplace" class="btn-access">Explore Marketplace &rarr;</a>
            </div>

            <!-- 4. College Events -->
            <div class="service-card">
                <div class="icon-wrap">🎉</div>
                <h3>College Events</h3>
                <p>Explore technical symposiums, freshers day, workshops, and register online.</p>
                <a href="events" class="btn-access">View Events &rarr;</a>
            </div>

            <!-- 5. Hostel Management -->
            <div class="service-card">
                <div class="icon-wrap">🏢</div>
                <h3>Hostel Management</h3>
                <p>Check hostel rules, warden contacts, dining hall info, and submit room complaints.</p>
                <a href="hostel" class="btn-access">Hostel Portal &rarr;</a>
            </div>

            <!-- 6. College Bus Management -->
            <div class="service-card">
                <div class="icon-wrap">🚌</div>
                <h3>Bus Management</h3>
                <p>Search college bus routes, stop timings, and driver details using dynamic AJAX lookup.</p>
                <a href="bus" class="btn-access">Check Bus Routes &rarr;</a>
            </div>

            <!-- 7. Sports Event Management -->
            <div class="service-card">
                <div class="icon-wrap">🏆</div>
                <h3>Sports Events</h3>
                <p>Register for cricket, football, volleyball, badminton, and campus sports tournaments.</p>
                <a href="sports" class="btn-access">Sports Registration &rarr;</a>
            </div>

            <!-- 8. Library Services -->
            <div class="service-card">
                <div class="icon-wrap">📚</div>
                <h3>Library Services</h3>
                <p>Search books by title, author, or category with real-time AJAX shelf checking.</p>
                <a href="library" class="btn-access">Search Catalog &rarr;</a>
            </div>

            <!-- 9. Fresher Assistance -->
            <div class="service-card">
                <div class="icon-wrap">🧭</div>
                <h3>Fresher Assistance</h3>
                <p>Interactive campus map, department guide, administrative contacts, and XML campus report.</p>
                <a href="fresher.jsp" class="btn-access">Fresher Guide &rarr;</a>
            </div>

            <!-- 10. Notice Board -->
            <div class="service-card">
                <div class="icon-wrap">📌</div>
                <h3>Notice Board</h3>
                <p>Stay updated with official announcements regarding exams, placements, and college events.</p>
                <a href="notices" class="btn-access">Read Notices &rarr;</a>
            </div>

            <!-- 11. Complaint / Help Desk -->
            <div class="service-card">
                <div class="icon-wrap">📬</div>
                <h3>Complaint / Help Desk</h3>
                <p>Submit formal complaints or academic grievances and track your resolution status.</p>
                <a href="complaints" class="btn-access">Submit Complaint &rarr;</a>
            </div>

            <!-- 12. Student Profile -->
            <div class="service-card">
                <div class="icon-wrap">👤</div>
                <h3>My Profile</h3>
                <p>View register number, department details, academic year, and registered email address.</p>
                <a href="profile" class="btn-access">View Profile &rarr;</a>
            </div>

        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2026 Campus Connect - Web Technology Laboratory Project. Developed using Servlets, JSP, JDBC &amp; MySQL.</p>
    </footer>

</body>
</html>
