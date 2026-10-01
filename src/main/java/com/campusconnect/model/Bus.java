package com.campusconnect.model;

import java.io.Serializable;
import java.util.List;

public class Bus implements Serializable {
    private static final long serialVersionUID = 1L;

    private int busId;
    private String busNumber;
    private String routeName;
    private String startingPoint;
    private String timing;
    private String driverName;
    private String driverContact;
    private List<BusStop> stops;

    public Bus() {}

    public int getBusId() { return busId; }
    public void setBusId(int busId) { this.busId = busId; }

    public String getBusNumber() { return busNumber; }
    public void setBusNumber(String busNumber) { this.busNumber = busNumber; }

    public String getRouteName() { return routeName; }
    public void setRouteName(String routeName) { this.routeName = routeName; }

    public String getStartingPoint() { return startingPoint; }
    public void setStartingPoint(String startingPoint) { this.startingPoint = startingPoint; }

    public String getTiming() { return timing; }
    public void setTiming(String timing) { this.timing = timing; }

    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }

    public String getDriverContact() { return driverContact; }
    public void setDriverContact(String driverContact) { this.driverContact = driverContact; }

    public List<BusStop> getStops() { return stops; }
    public void setStops(List<BusStop> stops) { this.stops = stops; }
}
