package com.campusconnect.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class SportsRegistration implements Serializable {
    private static final long serialVersionUID = 1L;

    private int registrationId;
    private int sportsId;
    private int studentId;
    private String eventName;
    private String studentName;
    private Timestamp registrationDate;

    public SportsRegistration() {}

    public int getRegistrationId() { return registrationId; }
    public void setRegistrationId(int registrationId) { this.registrationId = registrationId; }

    public int getSportsId() { return sportsId; }
    public void setSportsId(int sportsId) { this.sportsId = sportsId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public Timestamp getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(Timestamp registrationDate) { this.registrationDate = registrationDate; }
}
