package com.campusconnect.dao;

import com.campusconnect.model.FoundItem;
import com.campusconnect.model.LostItem;
import com.campusconnect.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LostFoundDAO {

    public boolean addLostItem(LostItem item) {
        String sql = "INSERT INTO lost_items (student_id, item_name, category, date_lost, location, description, contact_info, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, item.getStudentId());
            stmt.setString(2, item.getItemName());
            stmt.setString(3, item.getCategory());
            stmt.setDate(4, item.getDateLost());
            stmt.setString(5, item.getLocation());
            stmt.setString(6, item.getDescription());
            stmt.setString(7, item.getContactInfo());
            stmt.setString(8, "LOST");
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addFoundItem(FoundItem item) {
        String sql = "INSERT INTO found_items (student_id, item_name, category, date_found, location, description, contact_info, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, item.getStudentId());
            stmt.setString(2, item.getItemName());
            stmt.setString(3, item.getCategory());
            stmt.setDate(4, item.getDateFound());
            stmt.setString(5, item.getLocation());
            stmt.setString(6, item.getDescription());
            stmt.setString(7, item.getContactInfo());
            stmt.setString(8, "FOUND");
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<LostItem> getAllLostItems() {
        List<LostItem> list = new ArrayList<>();
        String sql = "SELECT l.*, s.name as student_name FROM lost_items l JOIN students s ON l.student_id = s.student_id ORDER BY l.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                LostItem item = new LostItem();
                item.setLostId(rs.getInt("lost_id"));
                item.setStudentId(rs.getInt("student_id"));
                item.setStudentName(rs.getString("student_name"));
                item.setItemName(rs.getString("item_name"));
                item.setCategory(rs.getString("category"));
                item.setDateLost(rs.getDate("date_lost"));
                item.setLocation(rs.getString("location"));
                item.setDescription(rs.getString("description"));
                item.setContactInfo(rs.getString("contact_info"));
                item.setStatus(rs.getString("status"));
                item.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<FoundItem> getAllFoundItems() {
        List<FoundItem> list = new ArrayList<>();
        String sql = "SELECT f.*, s.name as student_name FROM found_items f JOIN students s ON f.student_id = s.student_id ORDER BY f.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                FoundItem item = new FoundItem();
                item.setFoundId(rs.getInt("found_id"));
                item.setStudentId(rs.getInt("student_id"));
                item.setStudentName(rs.getString("student_name"));
                item.setItemName(rs.getString("item_name"));
                item.setCategory(rs.getString("category"));
                item.setDateFound(rs.getDate("date_found"));
                item.setLocation(rs.getString("location"));
                item.setDescription(rs.getString("description"));
                item.setContactInfo(rs.getString("contact_info"));
                item.setStatus(rs.getString("status"));
                item.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateLostStatus(int lostId, String status) {
        String sql = "UPDATE lost_items SET status = ? WHERE lost_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, lostId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateFoundStatus(int foundId, String status) {
        String sql = "UPDATE found_items SET status = ? WHERE found_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, foundId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
