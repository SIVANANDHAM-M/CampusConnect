package com.campusconnect.dao;

import com.campusconnect.model.Event;
import com.campusconnect.model.EventRegistration;
import com.campusconnect.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    public boolean addEvent(Event event) {
        String sql = "INSERT INTO events (event_name, event_date, event_time, venue, description, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, event.getEventName());
            stmt.setDate(2, event.getEventDate());
            stmt.setString(3, event.getEventTime());
            stmt.setString(4, event.getVenue());
            stmt.setString(5, event.getDescription());
            stmt.setString(6, "UPCOMING");
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Event> getAllEvents(int currentStudentId) {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT e.*, (SELECT COUNT(*) FROM event_registrations er WHERE er.event_id = e.event_id AND er.student_id = ?) as is_reg FROM events e ORDER BY e.event_date ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, currentStudentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Event ev = new Event();
                    ev.setEventId(rs.getInt("event_id"));
                    ev.setEventName(rs.getString("event_name"));
                    ev.setEventDate(rs.getDate("event_date"));
                    ev.setEventTime(rs.getString("event_time"));
                    ev.setVenue(rs.getString("venue"));
                    ev.setDescription(rs.getString("description"));
                    ev.setStatus(rs.getString("status"));
                    ev.setCreatedAt(rs.getTimestamp("created_at"));
                    ev.setRegistered(rs.getInt("is_reg") > 0);
                    list.add(ev);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean isStudentRegistered(int eventId, int studentId) {
        String sql = "SELECT COUNT(*) FROM event_registrations WHERE event_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            stmt.setInt(2, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean registerForEvent(int eventId, int studentId) {
        if (isStudentRegistered(eventId, studentId)) {
            return false; // Prevent duplicate registration
        }
        String sql = "INSERT INTO event_registrations (event_id, student_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            stmt.setInt(2, studentId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<EventRegistration> getAllRegistrations() {
        List<EventRegistration> list = new ArrayList<>();
        String sql = "SELECT er.*, e.event_name, s.name as student_name FROM event_registrations er JOIN events e ON er.event_id = e.event_id JOIN students s ON er.student_id = s.student_id ORDER BY er.registration_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                EventRegistration reg = new EventRegistration();
                reg.setRegistrationId(rs.getInt("registration_id"));
                reg.setEventId(rs.getInt("event_id"));
                reg.setStudentId(rs.getInt("student_id"));
                reg.setEventName(rs.getString("event_name"));
                reg.setStudentName(rs.getString("student_name"));
                reg.setRegistrationDate(rs.getTimestamp("registration_date"));
                list.add(reg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
