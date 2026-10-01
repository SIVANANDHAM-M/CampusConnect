package com.campusconnect.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection - Database utility class using standard JDBC DriverManager.
 * Automatically attempts connection with configured root credentials.
 */
public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/campus_connect?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException ex) {
                System.err.println("Error: MySQL JDBC Driver not found in classpath!");
                ex.printStackTrace();
            }
        }
    }

    /**
     * Gets an active Connection to the MySQL database.
     */
    public static Connection getConnection() throws SQLException {
        try {
            // First try empty password (standard default for local dev)
            return DriverManager.getConnection(URL, USER, "");
        } catch (SQLException e) {
            try {
                // Fallback to 'root' password
                return DriverManager.getConnection(URL, USER, "root");
            } catch (SQLException ex) {
                // Fallback to 'admin' password
                return DriverManager.getConnection(URL, USER, "admin");
            }
        }
    }
}
