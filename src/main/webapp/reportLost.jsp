<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Report Lost Item - Campus Connect</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js" defer></script>
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Report Lost Item</span></div>
        <div class="nav-links">
            <a href="searchLostFound">&larr; Back to Lost &amp; Found</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="form-card">
            <h2 style="color: var(--primary-dark); margin-bottom: 20px;">🔍 Report a Lost Item</h2>
            
            <div id="jsErrorMessage" style="display:none;"></div>

            <form id="lostForm" action="reportLost" method="post">
                <div class="form-group">
                    <label for="itemName">Item Name</label>
                    <input type="text" id="itemName" name="itemName" class="form-control" required placeholder="e.g. Samsung Galaxy Phone, Honda Key">
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
                    <label for="dateLost">Date Lost</label>
                    <input type="date" id="dateLost" name="dateLost" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="location">Location Lost</label>
                    <input type="text" id="location" name="location" class="form-control" required placeholder="e.g. CSE Block Lab 3 or Canteen">
                </div>

                <div class="form-group">
                    <label for="description">Item Description &amp; Identifying Marks</label>
                    <textarea id="description" name="description" class="form-control" required placeholder="Color, brand, unique keychains, or specific marks..."></textarea>
                </div>

                <div class="form-group">
                    <label for="contactInfo">Contact Information</label>
                    <input type="text" id="contactInfo" name="contactInfo" class="form-control" required placeholder="Phone number or Email address">
                </div>

                <button type="submit" class="btn-primary" style="width: 100%; justify-content: center;">Submit Lost Item Report</button>
            </form>
        </div>
    </div>

</body>
</html>
