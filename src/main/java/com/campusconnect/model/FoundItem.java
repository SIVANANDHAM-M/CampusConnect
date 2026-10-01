package com.campusconnect.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class FoundItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private int foundId;
    private int studentId;
    private String studentName;
    private String itemName;
    private String category;
    private Date dateFound;
    private String location;
    private String description;
    private String contactInfo;
    private String status; // 'FOUND', 'CLAIMED', 'RETURNED'
    private Timestamp createdAt;

    public FoundItem() {}

    public int getFoundId() { return foundId; }
    public void setFoundId(int foundId) { this.foundId = foundId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public Date getDateFound() { return dateFound; }
    public void setDateFound(Date dateFound) { this.dateFound = dateFound; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getContactInfo() { return contactInfo; }
    public void setContactInfo(String contactInfo) { this.contactInfo = contactInfo; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
