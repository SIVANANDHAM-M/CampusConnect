<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Report Found Item - Campus Connect</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js" defer></script>
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Report Found Item</span></div>
        <div class="nav-links">
            <a href="searchLostFound">&larr; Back to Lost &amp; Found</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="form-card">
            <h2 style="color: var(--primary-dark); margin-bottom: 20px;">📦 Report a Found Item</h2>
            
            <div id="jsErrorMessage" style="display:none;"></div>

            <form id="foundForm" action="reportFound" method="post">
                <div class="form-group">
                    <label for="itemName">Item Name</label>
                    <input type="text" id="itemName" name="itemName" class="form-control" required placeholder="e.g. Casio Calculator, Blue Wallet">
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <select id="category" name="category" class="form-control" required>
                        <option value="Mobile Phone">Mobile Phone</option>
                        <option value="Key">Key</option>
                        <option value="College ID Card">College ID Card</option>
                        <option value="Wallet">Wallet</option>
                        <option value="Bag">Bag</option>
                        <option value="Earphones">Earphones</option>
                        <option value="Calculator">Calculator</option>
                        <option value="Book">Book</option>
                        <option value="Watch">Watch</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="dateFound">Date Found</label>
                    <input type="date" id="dateFound" name="dateFound" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="location">Location Found</label>
                    <input type="text" id="location" name="location" class="form-control" required placeholder="e.g. Library Main Gate, Corridor">
                </div>

                <div class="form-group">
                    <label for="description">Item Description &amp; Details</label>
                    <textarea id="description" name="description" class="form-control" required placeholder="Describe condition, exact place, or office where it is stored..."></textarea>
                </div>

                <div class="form-group">
                    <label for="contactInfo">Contact / Claim Info</label>
                    <input type="text" id="contactInfo" name="contactInfo" class="form-control" required placeholder="Security office or student phone number">
                </div>

                <button type="submit" class="btn-primary" style="width: 100%; justify-content: center;">Submit Found Item Report</button>
            </form>
        </div>
    </div>

</body>
</html>
