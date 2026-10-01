package com.campusconnect.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Read from environment variables (used by Render in the cloud)
    // with a fallback to localhost (if you run it locally on your PC)
    private static final String URL = System.getenv("DB_URL") != null ? 
            System.getenv("DB_URL") : "jdbc:mysql://localhost:3306/campus_connect";
            
    private static final String USER = System.getenv("DB_USER") != null ? 
            System.getenv("DB_USER") : "root";
            
    private static final String PASS = System.getenv("DB_PASS") != null ? 
            System.getenv("DB_PASS") : "";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found. " + e.getMessage());
        } catch (SQLException e) {
            // If empty password fails locally, try alternative local passwords
            if (System.getenv("DB_URL") == null) {
                try {
                    conn = DriverManager.getConnection(URL, USER, "root");
                } catch (SQLException ex) {
                    try {
                        conn = DriverManager.getConnection(URL, USER, "admin");
                    } catch (SQLException ex2) {
                        System.err.println("Database connection failed: " + ex2.getMessage());
                    }
                }
            } else {
                System.err.println("Cloud Database connection failed: " + e.getMessage());
            }
        }
        return conn;
    }
}
