package com.campusconnect.model;

import java.io.Serializable;

public class BusStop implements Serializable {
    private static final long serialVersionUID = 1L;

    private int stopId;
    private int busId;
    private String stopName;
    private int stopOrder;

    public BusStop() {}

    public int getStopId() { return stopId; }
    public void setStopId(int stopId) { this.stopId = stopId; }

    public int getBusId() { return busId; }
    public void setBusId(int busId) { this.busId = busId; }

    public String getStopName() { return stopName; }
    public void setStopName(String stopName) { this.stopName = stopName; }

    public int getStopOrder() { return stopOrder; }
    public void setStopOrder(int stopOrder) { this.stopOrder = stopOrder; }
}
