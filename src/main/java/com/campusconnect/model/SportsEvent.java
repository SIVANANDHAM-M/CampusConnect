package com.campusconnect.model;

import java.io.Serializable;
import java.sql.Date;

public class SportsEvent implements Serializable {
    private static final long serialVersionUID = 1L;

    private int sportsId;
    private String sportName;
    private String eventName;
    private Date eventDate;
    private String venue;
    private String description;
    private String status; // 'UPCOMING', 'ONGOING', 'COMPLETED'
    private boolean registered;

    public SportsEvent() {}

    public int getSportsId() { return sportsId; }
    public void setSportsId(int sportsId) { this.sportsId = sportsId; }

    public String getSportName() { return sportName; }
    public void setSportName(String sportName) { this.sportName = sportName; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public Date getEventDate() { return eventDate; }
    public void setEventDate(Date eventDate) { this.eventDate = eventDate; }

    public String getVenue() { return venue; }
    public void setVenue(String venue) { this.venue = venue; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public boolean isRegistered() { return registered; }
    public void setRegistered(boolean registered) { this.registered = registered; }
}
