package com.campusconnect.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class EventRegistration implements Serializable {
    private static final long serialVersionUID = 1L;

    private int registrationId;
    private int eventId;
    private int studentId;
    private String eventName;
    private String studentName;
    private Timestamp registrationDate;

    public EventRegistration() {}

    public int getRegistrationId() { return registrationId; }
    public void setRegistrationId(int registrationId) { this.registrationId = registrationId; }

    public int getEventId() { return eventId; }
    public void setEventId(int eventId) { this.eventId = eventId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public Timestamp getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(Timestamp registrationDate) { this.registrationDate = registrationDate; }
}
