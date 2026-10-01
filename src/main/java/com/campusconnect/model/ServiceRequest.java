package com.campusconnect.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class ServiceRequest implements Serializable {
    private static final long serialVersionUID = 1L;

    private int requestId;
    private int studentId;
    private String studentName;
    private String category;
    private String location;
    private String description;
    private String priority; // 'Low', 'Medium', 'High'
    private String status;   // 'Submitted', 'Under Review', 'Assigned', 'In Progress', 'Resolved'
    private Timestamp createdDate;

    public ServiceRequest() {}

    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
}
