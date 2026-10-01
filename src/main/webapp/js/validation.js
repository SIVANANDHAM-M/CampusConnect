/**
 * validation.js - Client-side validation & DOM interactions for CAMPUS CONNECT
 * Written using Vanilla JS & DOM API methods (getElementById, addEventListener, etc.)
 */

document.addEventListener('DOMContentLoaded', function () {

    // 1. Unified Login Form Validation
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', function (e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            const errorDiv = document.getElementById('jsErrorMessage');

            if (username === '' || password === '') {
                e.preventDefault();
                showError(errorDiv, 'Please fill in both Username and Password fields!');
                return false;
            }

            if (password.length < 4) {
                e.preventDefault();
                showError(errorDiv, 'Password must be at least 4 characters long.');
                return false;
            }

            clearError(errorDiv);
        });
    }

    // 2. Report Lost Form Validation
    const lostForm = document.getElementById('lostForm');
    if (lostForm) {
        lostForm.addEventListener('submit', function (e) {
            const itemName = document.getElementById('itemName').value.trim();
            const category = document.getElementById('category').value;
            const dateLost = document.getElementById('dateLost').value;
            const location = document.getElementById('location').value.trim();
            const description = document.getElementById('description').value.trim();
            const contactInfo = document.getElementById('contactInfo').value.trim();
            const errorDiv = document.getElementById('jsErrorMessage');

            if (!itemName || !category || !dateLost || !location || !description || !contactInfo) {
                e.preventDefault();
                showError(errorDiv, 'All fields are mandatory when reporting a lost item.');
                return false;
            }

            if (description.length < 10) {
                e.preventDefault();
                showError(errorDiv, 'Please provide a detailed description (at least 10 characters).');
                return false;
            }

            clearError(errorDiv);
        });
    }

    // 3. Report Found Form Validation
    const foundForm = document.getElementById('foundForm');
    if (foundForm) {
        foundForm.addEventListener('submit', function (e) {
            const itemName = document.getElementById('itemName').value.trim();
            const category = document.getElementById('category').value;
            const dateFound = document.getElementById('dateFound').value;
            const location = document.getElementById('location').value.trim();
            const description = document.getElementById('description').value.trim();
            const contactInfo = document.getElementById('contactInfo').value.trim();
            const errorDiv = document.getElementById('jsErrorMessage');

            if (!itemName || !category || !dateFound || !location || !description || !contactInfo) {
                e.preventDefault();
                showError(errorDiv, 'All mandatory fields must be filled out.');
                return false;
            }

            clearError(errorDiv);
        });
    }

    // 4. Marketplace Sell Item Validation
    const sellForm = document.getElementById('sellForm');
    if (sellForm) {
        sellForm.addEventListener('submit', function (e) {
            const itemName = document.getElementById('itemName').value.trim();
            const price = parseFloat(document.getElementById('price').value);
            const contact = document.getElementById('contact').value.trim();
            const errorDiv = document.getElementById('jsErrorMessage');

            if (!itemName || isNaN(price) || price <= 0 || !contact) {
                e.preventDefault();
                showError(errorDiv, 'Please enter a valid item name, positive price, and contact information.');
                return false;
            }

            clearError(errorDiv);
        });
    }

    // Helper functions for DOM manipulations
    function showError(element, message) {
        if (!element) return;
        element.style.display = 'block';
        element.className = 'alert alert-error';
        element.innerHTML = '⚠️ <strong>Validation Error:</strong> ' + message;
    }

    function clearError(element) {
        if (!element) return;
        element.style.display = 'none';
        element.innerHTML = '';
    }
});
