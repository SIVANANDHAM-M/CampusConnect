package com.campusconnect.dao;

import com.campusconnect.model.Bus;
import com.campusconnect.model.BusStop;
import com.campusconnect.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BusDAO {

    public List<Bus> getAllBuses() {
        List<Bus> list = new ArrayList<>();
        String sql = "SELECT * FROM buses ORDER BY bus_number";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Bus b = extractBus(rs);
                b.setStops(getBusStops(b.getBusId(), conn));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Bus getBusById(int busId) {
        String sql = "SELECT * FROM buses WHERE bus_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, busId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Bus b = extractBus(rs);
                    b.setStops(getBusStops(b.getBusId(), conn));
                    return b;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Bus> searchBuses(String routeQuery) {
        List<Bus> list = new ArrayList<>();
        String sql = "SELECT DISTINCT b.* FROM buses b LEFT JOIN bus_stops bs ON b.bus_id = bs.bus_id WHERE b.bus_number LIKE ? OR b.route_name LIKE ? OR b.starting_point LIKE ? OR bs.stop_name LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String term = "%" + (routeQuery != null ? routeQuery.trim() : "") + "%";
            stmt.setString(1, term);
            stmt.setString(2, term);
            stmt.setString(3, term);
            stmt.setString(4, term);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Bus b = extractBus(rs);
                    b.setStops(getBusStops(b.getBusId(), conn));
                    list.add(b);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private List<BusStop> getBusStops(int busId, Connection conn) throws SQLException {
        List<BusStop> stops = new ArrayList<>();
        String sql = "SELECT * FROM bus_stops WHERE bus_id = ? ORDER BY stop_order ASC";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, busId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BusStop stop = new BusStop();
                    stop.setStopId(rs.getInt("stop_id"));
                    stop.setBusId(rs.getInt("bus_id"));
                    stop.setStopName(rs.getString("stop_name"));
                    stop.setStopOrder(rs.getInt("stop_order"));
                    stops.add(stop);
                }
            }
        }
        return stops;
    }

    private Bus extractBus(ResultSet rs) throws SQLException {
        Bus b = new Bus();
        b.setBusId(rs.getInt("bus_id"));
        b.setBusNumber(rs.getString("bus_number"));
        b.setRouteName(rs.getString("route_name"));
        b.setStartingPoint(rs.getString("starting_point"));
        b.setTiming(rs.getString("timing"));
        b.setDriverName(rs.getString("driver_name"));
        b.setDriverContact(rs.getString("driver_contact"));
        return b;
    }
}
