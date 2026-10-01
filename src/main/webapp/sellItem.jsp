<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sell Item - Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/validation.js" defer></script>
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Sell Item</span></div>
        <div class="nav-links">
            <a href="marketplace">&larr; Back to Marketplace</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="form-card">
            <h2 style="color: var(--primary-dark); margin-bottom: 20px;">🏷️ List Item for Sale on Campus Marketplace</h2>
            
            <div id="jsErrorMessage" style="display:none;"></div>

            <form id="sellForm" action="sellItem" method="post">
                <div class="form-group">
                    <label for="itemName">Item Name / Book Title</label>
                    <input type="text" id="itemName" name="itemName" class="form-control" required placeholder="e.g. Data Structures in Java Book, Casio Calculator">
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <select id="category" name="category" class="form-control" required>
                        <option value="Used Books">Used Books</option>
                        <option value="Calculator">Calculator</option>
                        <option value="Lab Equipment">Lab Equipment</option>
                        <option value="Electronics">Electronics</option>
                        <option value="Bags">Bags</option>
                        <option value="Stationery">Stationery</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="price">Price (₹ INR)</label>
                    <input type="number" step="0.01" id="price" name="price" class="form-control" required placeholder="e.g. 450.00">
                </div>

                <div class="form-group">
                    <label for="description">Item Condition &amp; Details</label>
                    <textarea id="description" name="description" class="form-control" required placeholder="Book edition, physical condition, missing pages or notes..."></textarea>
                </div>

                <div class="form-group">
                    <label for="contact">Seller Contact Information</label>
                    <input type="text" id="contact" name="contact" class="form-control" required placeholder="Email or Phone Number">
                </div>

                <button type="submit" class="btn-primary" style="width: 100%; justify-content: center;">Post Listing on Marketplace</button>
            </form>
        </div>
    </div>

</body>
</html>
