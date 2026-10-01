<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campusconnect.model.Book" %>
<%@ page import="java.util.List" %>
<%
    List<Book> books = (List<Book>) request.getAttribute("books");
    if (books == null) {
        response.sendRedirect("library");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Library Services - Campus Connect</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/ajax.js" defer></script>
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Library Services</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>Central Library Book Catalog</h2>
                <p>Real-time AJAX catalog search for book titles, authors, categories, availability, and shelf locations.</p>
            </div>
            <div>
                <span class="badge badge-info">LIVE AJAX SEARCH</span>
            </div>
        </div>

        <!-- AJAX Live Search Controls -->
        <div style="background: #fff; padding: 20px; border-radius: 10px; margin-bottom: 25px; box-shadow: var(--shadow-sm);">
            <div style="display: flex; gap: 15px; align-items: flex-end;">
                <div style="flex: 2;">
                    <label style="font-weight: 600; margin-bottom: 6px; display: block;">Live Search (Book Title / Author):</label>
                    <input type="text" id="bookSearchInput" class="form-control" 
                           placeholder="Type book title or author name (e.g. Java, Herbert Schildt, Operating Systems)..." 
                           onkeyup="searchLibraryBooks()">
                </div>
                <div style="flex: 1;">
                    <label style="font-weight: 600; margin-bottom: 6px; display: block;">Category Filter:</label>
                    <select id="bookCategorySelect" class="form-control" onchange="searchLibraryBooks()">
                        <option value="All">All Categories</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Web Technology">Web Technology</option>
                        <option value="Electronics">Electronics</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Book Catalog Table -->
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Book ID</th>
                        <th>Book Title</th>
                        <th>Author</th>
                        <th>Category</th>
                        <th>Availability Status</th>
                        <th>Shelf Location</th>
                    </tr>
                </thead>
                <tbody id="bookTableBody">
                    <% for (Book b : books) { %>
                        <tr>
                            <td><strong><%= b.getBookId() %></strong></td>
                            <td><%= b.getTitle() %></td>
                            <td><%= b.getAuthor() %></td>
                            <td><span class="badge badge-info"><%= b.getCategory() %></span></td>
                            <td>
                                <span class="badge <%= "AVAILABLE".equalsIgnoreCase(b.getAvailability()) ? "badge-success" : ("ISSUED".equalsIgnoreCase(b.getAvailability()) ? "badge-danger" : "badge-warning") %>">
                                    <%= b.getAvailability() %>
                                </span>
                            </td>
                            <td><code><%= b.getShelfNo() %></code></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>

</body>
</html>
