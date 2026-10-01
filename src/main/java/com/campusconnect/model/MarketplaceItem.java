package com.campusconnect.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class MarketplaceItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private int itemId;
    private int studentId;
    private String studentName;
    private String itemName;
    private String category;
    private String description;
    private BigDecimal price;
    private String contact;
    private String status; // 'AVAILABLE', 'SOLD'
    private Timestamp postedDate;

    public MarketplaceItem() {}

    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getPostedDate() { return postedDate; }
    public void setPostedDate(Timestamp postedDate) { this.postedDate = postedDate; }
}
