package com.campusconnect.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class LostItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private int lostId;
    private int studentId;
    private String studentName;
    private String itemName;
    private String category;
    private Date dateLost;
    private String location;
    private String description;
    private String contactInfo;
    private String status; // 'LOST', 'FOUND', 'CLAIMED', 'RETURNED'
    private Timestamp createdAt;

    public LostItem() {}

    public int getLostId() { return lostId; }
    public void setLostId(int lostId) { this.lostId = lostId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public Date getDateLost() { return dateLost; }
    public void setDateLost(Date dateLost) { this.dateLost = dateLost; }

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
