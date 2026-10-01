package com.campusconnect.model;

import java.io.Serializable;

public class Hostel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int hostelId;
    private String hostelName;
    private String warden;
    private String contact;
    private String description;

    public Hostel() {}

    public int getHostelId() { return hostelId; }
    public void setHostelId(int hostelId) { this.hostelId = hostelId; }

    public String getHostelName() { return hostelName; }
    public void setHostelName(String hostelName) { this.hostelName = hostelName; }

    public String getWarden() { return warden; }
    public void setWarden(String warden) { this.warden = warden; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
