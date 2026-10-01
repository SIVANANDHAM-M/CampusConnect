package com.campusconnect.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class Notice implements Serializable {
    private static final long serialVersionUID = 1L;

    private int noticeId;
    private String title;
    private String description;
    private String category;
    private Date noticeDate;
    private Timestamp createdAt;

    public Notice() {}

    public int getNoticeId() { return noticeId; }
    public void setNoticeId(int noticeId) { this.noticeId = noticeId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public Date getNoticeDate() { return noticeDate; }
    public void setNoticeDate(Date noticeDate) { this.noticeDate = noticeDate; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
