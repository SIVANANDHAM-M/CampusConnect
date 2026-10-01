package com.campusconnect.dao;

import com.campusconnect.model.ServiceRequest;
import com.campusconnect.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ServiceRequestDAO {

    public boolean addServiceRequest(ServiceRequest request) {
        String sql = "INSERT INTO service_requests (student_id, category, location, description, priority, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, request.getStudentId());
            stmt.setString(2, request.getCategory());
            stmt.setString(3, request.getLocation());
            stmt.setString(4, request.getDescription());
            stmt.setString(5, request.getPriority());
            stmt.setString(6, "Submitted");
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<ServiceRequest> getAllServiceRequests() {
        List<ServiceRequest> list = new ArrayList<>();
        String sql = "SELECT r.*, s.name as student_name FROM service_requests r JOIN students s ON r.student_id = s.student_id ORDER BY r.created_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(extractRequest(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ServiceRequest> getRequestsByStudent(int studentId) {
        List<ServiceRequest> list = new ArrayList<>();
        String sql = "SELECT r.*, s.name as student_name FROM service_requests r JOIN students s ON r.student_id = s.student_id WHERE r.student_id = ? ORDER BY r.created_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(extractRequest(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int requestId, String status) {
        String sql = "UPDATE service_requests SET status = ? WHERE request_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, requestId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private ServiceRequest extractRequest(ResultSet rs) throws SQLException {
        ServiceRequest req = new ServiceRequest();
        req.setRequestId(rs.getInt("request_id"));
        req.setStudentId(rs.getInt("student_id"));
        req.setStudentName(rs.getString("student_name"));
        req.setCategory(rs.getString("category"));
        req.setLocation(rs.getString("location"));
        req.setDescription(rs.getString("description"));
        req.setPriority(rs.getString("priority"));
        req.setStatus(rs.getString("status"));
        req.setCreatedDate(rs.getTimestamp("created_date"));
        return req;
    }
}
