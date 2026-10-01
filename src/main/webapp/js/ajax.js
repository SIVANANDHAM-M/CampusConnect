/**
 * ajax.js - Vanilla JavaScript XMLHttpRequest (AJAX) Utilities for CAMPUS CONNECT
 * Handles asynchronous data loading without refreshing the web page.
 */

// 1. Bus Route Search AJAX Handler
function searchBusRoutes() {
    var query = document.getElementById('busSearchInput').value;
    var resultsContainer = document.getElementById('busResultsContainer');

    if (!resultsContainer) return;

    // Show loading state DOM element
    resultsContainer.innerHTML = "<div class='alert alert-info'><p>⏳ Fetching matching bus routes from server...</p></div>";

    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'busSearch?query=' + encodeURIComponent(query), true);

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                // Update DOM dynamically
                resultsContainer.innerHTML = xhr.responseText;
            } else {
                resultsContainer.innerHTML = "<div class='alert alert-error'><p>❌ Error loading bus details from server (HTTP " + xhr.status + ").</p></div>";
            }
        }
    };

    xhr.send();
}

// 2. Library Book Search AJAX Handler
function searchLibraryBooks() {
    var query = document.getElementById('bookSearchInput').value;
    var categorySelect = document.getElementById('bookCategorySelect');
    var category = categorySelect ? categorySelect.value : 'All';
    var tableBody = document.getElementById('bookTableBody');

    if (!tableBody) return;

    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'bookSearch?query=' + encodeURIComponent(query) + '&category=' + encodeURIComponent(category), true);

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                // Dynamic DOM table row update
                tableBody.innerHTML = xhr.responseText;
            } else {
                tableBody.innerHTML = "<tr><td colspan='6' class='text-center text-danger'>Error fetching book catalog.</td></tr>";
            }
        }
    };

    xhr.send();
}
