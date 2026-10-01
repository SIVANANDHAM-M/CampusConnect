<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fresher Assistance &amp; Campus Guide</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <div class="brand">🏛️ CAMPUS CONNECT <span>| Fresher Assistance Portal</span></div>
        <div class="nav-links">
            <a href="studentDashboard.jsp">&larr; Dashboard</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <div>
                <h2>Welcome Freshers! - Campus Orientation &amp; Guide</h2>
                <p>Find department locations, administrative block, library, hostels, canteen, and sports grounds.</p>
            </div>
            <a href="xml/campus.xml" target="_blank" class="btn-primary" style="background-color: var(--accent);">📜 View Campus XML Directory</a>
        </div>

        <!-- Campus Layout Representation (Pure HTML/CSS Grid Map - NO Google Maps API) -->
        <div class="campus-layout-container">
            <h3 style="color: var(--primary-dark); margin-bottom: 10px;">🗺️ Interactive Campus Layout &amp; Zone Guide</h3>
            <p class="text-muted">Visual representation of key campus blocks for 1st-year orientation.</p>

            <div class="campus-grid-map">
                <div class="map-zone">
                    <h4>🏛️ Administrative Block</h4>
                    <p style="font-size: 0.85rem; color: var(--text-muted);">Principal Office, Admissions, COE, Accounts Cell</p>
                </div>
                <div class="map-zone">
                    <h4>📚 Knowledge Resource Center</h4>
                    <p style="font-size: 0.85rem; color: var(--text-muted);">Central Library, Digital Lab, Seminar Halls</p>
                </div>
                <div class="map-zone">
                    <h4>💻 CSE &amp; IT Engineering Block</h4>
                    <p style="font-size: 0.85rem; color: var(--text-muted);">Computer Labs, Web Tech Lab, AI Research Center</p>
                </div>
                <div class="map-zone">
                    <h4>⚡ ECE &amp; EEE Block</h4>
                    <p style="font-size: 0.85rem; color: var(--text-muted);">VLSI Lab, Circuit Workshop, DSP Center</p>
                </div>
                <div class="map-zone">
                    <h4>⚙️ Mechanical &amp; Civil Block</h4>
                    <p style="font-size: 0.85rem; color: var(--text-muted);">Heavy Machinery Workshop, CAD/CAM Lab</p>
                </div>
                <div class="map-zone">
                    <h4>🍱 Student Activity Center</h4>
                    <p style="font-size: 0.85rem; color: var(--text-muted);">Food Court, Canteen, Stationary Shop, ATM</p>
                </div>
                <div class="map-zone">
                    <h4>🏢 Kaveri Boys Hostel</h4>
                    <p style="font-size: 0.85rem; color: var(--text-muted);">Boys Resident Block A &amp; Dining Hall</p>
                </div>
                <div class="map-zone">
                    <h4>🏢 Ganga Girls Hostel</h4>
                    <p style="font-size: 0.85rem; color: var(--text-muted);">Girls Resident Block B &amp; Security Counter</p>
                </div>
                <div class="map-zone">
                    <h4>⚽ Sports Complex &amp; Bus Stop</h4>
                    <p style="font-size: 0.85rem; color: var(--text-muted);">Cricket Ground, Indoor Courts, Main Bus Depot</p>
                </div>
            </div>
        </div>

        <!-- Key Directory Contacts -->
        <div style="background: #fff; padding: 25px; border-radius: 10px; margin-top: 25px; box-shadow: var(--shadow-sm);">
            <h3 style="color: var(--primary-dark); margin-bottom: 15px;">📞 Key Institutional Contacts for Freshers</h3>
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Office / Helpdesk</th>
                            <th>In-Charge Officer</th>
                            <th>Contact Phone</th>
                            <th>Email Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Fresher Orientation Desk</strong></td>
                            <td>Prof. S. Anita</td>
                            <td>044-24500010</td>
                            <td>fresher.help@campusconnect.edu</td>
                        </tr>
                        <tr>
                            <td><strong>Exam Cell (COE)</strong></td>
                            <td>Dr. M. Ganesan</td>
                            <td>044-24500002</td>
                            <td>coe@campusconnect.edu</td>
                        </tr>
                        <tr>
                            <td><strong>Chief Warden Office</strong></td>
                            <td>Dr. R. Sundaram</td>
                            <td>044-24500004</td>
                            <td>warden@campusconnect.edu</td>
                        </tr>
                        <tr>
                            <td><strong>Transport Coordinator</strong></td>
                            <td>Mr. M. Rajesh</td>
                            <td>9123456780</td>
                            <td>bus.help@campusconnect.edu</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</body>
</html>
