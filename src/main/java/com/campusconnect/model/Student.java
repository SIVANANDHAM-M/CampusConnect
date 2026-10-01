package com.campusconnect.model;

import java.io.Serializable;

/**
 * Model class representing a Student profile.
 */
public class Student implements Serializable {
    private static final long serialVersionUID = 1L;

    private int studentId;
    private int userId;
    private String registerNo;
    private String name;
    private String department;
    private String year;
    private String email;
    private String phone;

    public Student() {}

    public Student(int studentId, int userId, String registerNo, String name, String department, String year, String email, String phone) {
        this.studentId = studentId;
        this.userId = userId;
        this.registerNo = registerNo;
        this.name = name;
        this.department = department;
        this.year = year;
        this.email = email;
        this.phone = phone;
    }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getRegisterNo() { return registerNo; }
    public void setRegisterNo(String registerNo) { this.registerNo = registerNo; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public String getYear() { return year; }
    public void setYear(String year) { this.year = year; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}
