-- ============================================================================
-- DATABASE SCRIPT: campus_connect.sql
-- PROJECT: CAMPUS CONNECT - College Campus Service & Fresher Assistance Portal
-- TECH STACK: MySQL, Java Servlet, JSP, JDBC
-- DESCRIPTION: Database creation script with 17 normalized tables and sample records.
-- ============================================================================

DROP DATABASE IF EXISTS campus_connect;
CREATE DATABASE campus_connect CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE campus_connect;

-- ----------------------------------------------------------------------------
-- 1. USERS TABLE (Handles unified login authentication for Student & Admin)
-- ----------------------------------------------------------------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role ENUM('STUDENT', 'ADMIN') NOT NULL DEFAULT 'STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 2. STUDENTS TABLE (Stores detailed profile information for registered students)
-- ----------------------------------------------------------------------------
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    register_no VARCHAR(30) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    year VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 3. LOST ITEMS TABLE (Reports of lost items across campus)
-- ----------------------------------------------------------------------------
CREATE TABLE lost_items (
    lost_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    date_lost DATE NOT NULL,
    location VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    contact_info VARCHAR(100) NOT NULL,
    status ENUM('LOST', 'FOUND', 'CLAIMED', 'RETURNED') DEFAULT 'LOST',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 4. FOUND ITEMS TABLE (Reports of items found across campus)
-- ----------------------------------------------------------------------------
CREATE TABLE found_items (
    found_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    date_found DATE NOT NULL,
    location VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    contact_info VARCHAR(100) NOT NULL,
    status ENUM('FOUND', 'CLAIMED', 'RETURNED') DEFAULT 'FOUND',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 5. SERVICE REQUESTS TABLE (General campus help & maintenance requests)
-- ----------------------------------------------------------------------------
CREATE TABLE service_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    category VARCHAR(50) NOT NULL, -- Electrical, Plumbing, Internet/Wi-Fi, etc.
    location VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    priority ENUM('Low', 'Medium', 'High') DEFAULT 'Medium',
    status ENUM('Submitted', 'Under Review', 'Assigned', 'In Progress', 'Resolved') DEFAULT 'Submitted',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 6. MARKETPLACE TABLE (Campus buy/sell marketplace for used books & equipment)
-- ----------------------------------------------------------------------------
CREATE TABLE marketplace (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    contact VARCHAR(100) NOT NULL,
    status ENUM('AVAILABLE', 'SOLD') DEFAULT 'AVAILABLE',
    posted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 7. EVENTS TABLE (College technical, cultural, & orientation events)
-- ----------------------------------------------------------------------------
CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    event_time VARCHAR(30) NOT NULL,
    venue VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    status ENUM('UPCOMING', 'ONGOING', 'COMPLETED', 'CANCELLED') DEFAULT 'UPCOMING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 8. EVENT REGISTRATIONS TABLE (Tracks student event registrations)
-- ----------------------------------------------------------------------------
CREATE TABLE event_registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    student_id INT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_event_student (event_id, student_id),
    FOREIGN KEY (event_id) REFERENCES events(event_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 9. HOSTELS TABLE (Hostel block and warden details)
-- ----------------------------------------------------------------------------
CREATE TABLE hostels (
    hostel_id INT AUTO_INCREMENT PRIMARY KEY,
    hostel_name VARCHAR(100) NOT NULL,
    warden VARCHAR(100) NOT NULL,
    contact VARCHAR(50) NOT NULL,
    description TEXT NOT NULL
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 10. HOSTEL COMPLAINTS TABLE (Hostel room, mess, and utility complaints)
-- ----------------------------------------------------------------------------
CREATE TABLE hostel_complaints (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    hostel_id INT NOT NULL,
    room_no VARCHAR(20) NOT NULL,
    category VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    status ENUM('Submitted', 'Under Review', 'In Progress', 'Resolved') DEFAULT 'Submitted',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (hostel_id) REFERENCES hostels(hostel_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 11. BUSES TABLE (College bus fleet and route information)
-- ----------------------------------------------------------------------------
CREATE TABLE buses (
    bus_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_number VARCHAR(100) NOT NULL UNIQUE,
    route_name VARCHAR(100) NOT NULL,
    starting_point VARCHAR(100) NOT NULL,
    timing VARCHAR(50) NOT NULL,
    driver_name VARCHAR(100) NOT NULL,
    driver_contact VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 12. BUS STOPS TABLE (Stops along specific bus routes)
-- ----------------------------------------------------------------------------
CREATE TABLE bus_stops (
    stop_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_id INT NOT NULL,
    stop_name VARCHAR(100) NOT NULL,
    stop_order INT NOT NULL,
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 13. SPORTS EVENTS TABLE (Inter/Intra college sports tournaments)
-- ----------------------------------------------------------------------------
CREATE TABLE sports_events (
    sports_id INT AUTO_INCREMENT PRIMARY KEY,
    sport_name VARCHAR(50) NOT NULL,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    venue VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    status ENUM('UPCOMING', 'ONGOING', 'COMPLETED') DEFAULT 'UPCOMING'
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 14. SPORTS REGISTRATIONS TABLE (Tracks sports participants)
-- ----------------------------------------------------------------------------
CREATE TABLE sports_registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    sports_id INT NOT NULL,
    student_id INT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_sports_student (sports_id, student_id),
    FOREIGN KEY (sports_id) REFERENCES sports_events(sports_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 15. BOOKS TABLE (College library book catalog)
-- ----------------------------------------------------------------------------
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    availability ENUM('AVAILABLE', 'ISSUED', 'RESERVED') DEFAULT 'AVAILABLE',
    shelf_no VARCHAR(30) NOT NULL
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 16. NOTICES TABLE (Official campus notice board announcements)
-- ----------------------------------------------------------------------------
CREATE TABLE notices (
    notice_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    category VARCHAR(50) NOT NULL,
    notice_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 17. COMPLAINTS TABLE (General college helpdesk & student complaints)
-- ----------------------------------------------------------------------------
CREATE TABLE complaints (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    subject VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    status ENUM('Submitted', 'Under Review', 'In Progress', 'Resolved') DEFAULT 'Submitted',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================================
-- INSERT INITIAL SAMPLE DATA
-- ============================================================================

-- 1. Users (Admin and Students)
INSERT INTO users (username, password, role) VALUES
('admin', 'admin123', 'ADMIN'),
('21CS001', 'student123', 'STUDENT'),
('21CS002', 'student123', 'STUDENT'),
('21EC005', 'student123', 'STUDENT');

-- 2. Students
INSERT INTO students (user_id, register_no, name, department, year, email, phone) VALUES
(2, '21CS001', 'Aarav Sharma', 'Computer Science & Engineering', '3rd Year', 'aarav.sharma@campus.edu', '9876543210'),
(3, '21CS002', 'Ananya Roy', 'Computer Science & Engineering', '2nd Year', 'ananya.roy@campus.edu', '9876543211'),
(4, '21EC005', 'Rohan Verma', 'Electronics & Communication', '1st Year (Fresher)', 'rohan.verma@campus.edu', '9876543212');

-- 3. Lost Items
INSERT INTO lost_items (student_id, item_name, category, date_lost, location, description, contact_info, status) VALUES
(1, 'Samsung Galaxy S21', 'Mobile Phone', '2026-09-20', 'CSE Block Lab 3', 'Black color phone with transparent back case.', 'aarav.sharma@campus.edu / 9876543210', 'LOST'),
(2, 'Blue Honda Bike Key', 'Key', '2026-09-21', 'Library Main Gate', 'Key with a red leather keychain.', 'ananya.roy@campus.edu', 'LOST'),
(3, 'Casio Scientific Calculator', 'Calculator', '2026-09-22', 'Lecture Hall 102', 'Model fx-991EX with name tag.', 'rohan.verma@campus.edu', 'LOST');

-- 4. Found Items
INSERT INTO found_items (student_id, item_name, category, date_found, location, description, contact_info, status) VALUES
(2, 'Samsung Mobile Phone', 'Mobile Phone', '2026-09-20', 'CSE Block Corridor', 'Found black Samsung smartphone near Lab 3.', 'Security Office / 9876543211', 'FOUND'),
(1, 'College ID Card', 'College ID Card', '2026-09-21', 'Main Canteen', 'ID Card belonging to Mech Dept student.', 'aarav.sharma@campus.edu', 'FOUND');

-- 5. Service Requests
INSERT INTO service_requests (student_id, category, location, description, priority, status) VALUES
(1, 'Internet / Wi-Fi', 'Library Reading Room B', 'Wi-Fi disconnects frequently in reading area.', 'Medium', 'In Progress'),
(3, 'Electrical', 'Classroom 204', 'Ceiling fan making noisy grinding sound.', 'Low', 'Submitted');

-- 6. Marketplace
INSERT INTO marketplace (student_id, item_name, category, description, price, contact, status) VALUES
(1, 'Data Structures & Algorithms in Java (4th Ed)', 'Used Books', 'Clean book with no highlights. Great for 2nd/3rd yr CSE.', 450.00, 'aarav.sharma@campus.edu', 'AVAILABLE'),
(2, 'Casio FX-991ES Calculator', 'Calculator', 'Working condition, 1 year old.', 600.00, '9876543211', 'AVAILABLE');

-- 7. Events
INSERT INTO events (event_name, event_date, event_time, venue, description, status) VALUES
('CYBERTRON 2026 - Tech Fest', '2026-10-15', '09:30 AM', 'Main Auditorium', 'Annual National Level Technical Symposium with coding, web design, and paper presentations.', 'UPCOMING'),
('Fresher Orientation & Cultural Gala', '2026-10-01', '10:00 AM', 'Open Air Theatre', 'Welcoming event for 1st-year students with cultural programs.', 'UPCOMING');

-- 8. Event Registrations
INSERT INTO event_registrations (event_id, student_id) VALUES
(1, 1),
(2, 3);

-- 9. Hostels
INSERT INTO hostels (hostel_name, warden, contact, description) VALUES
('Kaveri Boys Hostel (Block A)', 'Dr. R. Sundaram', '9443311220', 'Hostel for 1st and 2nd year male students. Equipped with Wi-Fi and Mess.'),
('Ganga Girls Hostel (Block B)', 'Mrs. S. Lakshmi', '9443311221', 'Hostel for female students with 24/7 security and modern dining.');

-- 10. Hostel Complaints
INSERT INTO hostel_complaints (student_id, hostel_id, room_no, category, description, status) VALUES
(1, 1, '304', 'Water', 'Hot water supply interrupted in 3rd floor washrooms.', 'Under Review');

-- 11. Buses
INSERT INTO buses (bus_number, route_name, starting_point, timing, driver_name, driver_contact) VALUES
('Route 05 - Central City Express', 'City Bus Stand -> Railway Station -> College Campus', 'Central Bus Stand', '07:30 AM', 'M. Rajesh', '9123456780'),
('Route 12 - Suburban Line', 'Green Park -> Anna Nagar -> College Campus', 'Green Park Circle', '07:15 AM', 'K. Suresh', '9123456781');

-- 12. Bus Stops
INSERT INTO bus_stops (bus_id, stop_name, stop_order) VALUES
(1, 'Central Bus Stand', 1),
(1, 'Railway Station', 2),
(1, 'Gandhi Statue Square', 3),
(1, 'College Main Gate', 4),
(2, 'Green Park Circle', 1),
(2, 'Anna Nagar Junction', 2),
(2, 'College South Gate', 3);

-- 13. Sports Events
INSERT INTO sports_events (sport_name, event_name, event_date, venue, description, status) VALUES
('Cricket', 'Inter-Department Cricket Tournament', '2026-10-20', 'College Sports Ground', 'Knockout T20 matches between engineering departments.', 'UPCOMING'),
('Chess', 'Campus Chess Championship', '2026-10-12', 'Indoor Sports Complex', 'Open chess competition for all years.', 'UPCOMING');

-- 14. Sports Registrations
INSERT INTO sports_registrations (sports_id, student_id) VALUES
(1, 1),
(2, 2);

-- 15. Books
INSERT INTO books (title, author, category, availability, shelf_no) VALUES
('Java The Complete Reference', 'Herbert Schildt', 'Computer Science', 'AVAILABLE', 'CS-101'),
('Operating System Concepts', 'Silberschatz & Galvin', 'Computer Science', 'AVAILABLE', 'CS-104'),
('Web Technologies: HTML, CSS, JS, Servlet & JSP', 'A. Parthasarathy', 'Web Technology', 'ISSUED', 'WT-202'),
('Electronic Devices and Circuit Theory', 'Boylestad', 'Electronics', 'AVAILABLE', 'EC-305');

-- 16. Notices
INSERT INTO notices (title, description, category, notice_date) VALUES
('Mid-Semester Examination Schedule', 'Mid-term exams for all departments begin on Oct 25, 2026. Detailed timetable posted on department boards.', 'Examination', '2026-09-22'),
('Campus Placement Drive - TechCorp', 'On-campus recruitment drive for 3rd and 4th-year CS & EC students on Oct 10.', 'Placement', '2026-09-23');

-- 17. Complaints
INSERT INTO complaints (student_id, category, subject, description, status) VALUES
(3, 'IT Support', 'ERP Portal Login Issue', 'Unable to download hall ticket from college ERP system.', 'In Progress');
