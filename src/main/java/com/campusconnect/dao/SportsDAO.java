package com.campusconnect.dao;

import com.campusconnect.model.SportsEvent;
import com.campusconnect.model.SportsRegistration;
import com.campusconnect.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SportsDAO {

    public List<SportsEvent> getAllSportsEvents(int studentId) {
        List<SportsEvent> list = new ArrayList<>();
        String sql = "SELECT se.*, (SELECT COUNT(*) FROM sports_registrations sr WHERE sr.sports_id = se.sports_id AND sr.student_id = ?) as is_reg FROM sports_events se ORDER BY se.event_date ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    SportsEvent se = new SportsEvent();
                    se.setSportsId(rs.getInt("sports_id"));
                    se.setSportName(rs.getString("sport_name"));
                    se.setEventName(rs.getString("event_name"));
                    se.setEventDate(rs.getDate("event_date"));
                    se.setVenue(rs.getString("venue"));
                    se.setDescription(rs.getString("description"));
                    se.setStatus(rs.getString("status"));
                    se.setRegistered(rs.getInt("is_reg") > 0);
                    list.add(se);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean registerForSports(int sportsId, int studentId) {
        String sql = "INSERT INTO sports_registrations (sports_id, student_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, sportsId);
            stmt.setInt(2, studentId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<SportsRegistration> getAllRegistrations() {
        List<SportsRegistration> list = new ArrayList<>();
        String sql = "SELECT sr.*, se.event_name, s.name as student_name FROM sports_registrations sr JOIN sports_events se ON sr.sports_id = se.sports_id JOIN students s ON sr.student_id = s.student_id ORDER BY sr.registration_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                SportsRegistration reg = new SportsRegistration();
                reg.setRegistrationId(rs.getInt("registration_id"));
                reg.setSportsId(rs.getInt("sports_id"));
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
