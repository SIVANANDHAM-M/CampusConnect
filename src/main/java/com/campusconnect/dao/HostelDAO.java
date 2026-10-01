package com.campusconnect.dao;

import com.campusconnect.model.Hostel;
import com.campusconnect.model.HostelComplaint;
import com.campusconnect.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HostelDAO {

    public List<Hostel> getAllHostels() {
        List<Hostel> list = new ArrayList<>();
        String sql = "SELECT * FROM hostels";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Hostel h = new Hostel();
                h.setHostelId(rs.getInt("hostel_id"));
                h.setHostelName(rs.getString("hostel_name"));
                h.setWarden(rs.getString("warden"));
                h.setContact(rs.getString("contact"));
                h.setDescription(rs.getString("description"));
                list.add(h);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addHostelComplaint(HostelComplaint complaint) {
        String sql = "INSERT INTO hostel_complaints (student_id, hostel_id, room_no, category, description, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, complaint.getStudentId());
            stmt.setInt(2, complaint.getHostelId());
            stmt.setString(3, complaint.getRoomNo());
            stmt.setString(4, complaint.getCategory());
            stmt.setString(5, complaint.getDescription());
            stmt.setString(6, "Submitted");
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<HostelComplaint> getAllHostelComplaints() {
        List<HostelComplaint> list = new ArrayList<>();
        String sql = "SELECT hc.*, h.hostel_name, s.name as student_name FROM hostel_complaints hc JOIN hostels h ON hc.hostel_id = h.hostel_id JOIN students s ON hc.student_id = s.student_id ORDER BY hc.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                HostelComplaint hc = new HostelComplaint();
                hc.setComplaintId(rs.getInt("complaint_id"));
                hc.setStudentId(rs.getInt("student_id"));
                hc.setStudentName(rs.getString("student_name"));
                hc.setHostelId(rs.getInt("hostel_id"));
                hc.setHostelName(rs.getString("hostel_name"));
                hc.setRoomNo(rs.getString("room_no"));
                hc.setCategory(rs.getString("category"));
                hc.setDescription(rs.getString("description"));
                hc.setStatus(rs.getString("status"));
                hc.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(hc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateComplaintStatus(int complaintId, String status) {
        String sql = "UPDATE hostel_complaints SET status = ? WHERE complaint_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, complaintId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
