package com.campusconnect.servlet;

import com.campusconnect.dao.BusDAO;
import com.campusconnect.model.Bus;
import com.campusconnect.model.BusStop;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/busSearch")
public class BusSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private BusDAO dao = new BusDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String query = request.getParameter("query");
        List<Bus> buses = dao.searchBuses(query);

        if (buses.isEmpty()) {
            out.println("<div class='no-records'><p>No bus routes found matching your search term: <strong>" + (query != null ? query : "") + "</strong></p></div>");
            return;
        }

        for (Bus bus : buses) {
            out.println("<div class='bus-card'>");
            out.println("  <div class='bus-header'>");
            out.println("    <h3><i class='icon'>🚌</i> " + bus.getBusNumber() + " - " + bus.getRouteName() + "</h3>");
            out.println("    <span class='timing-badge'>Starts: " + bus.getTiming() + "</span>");
            out.println("  </div>");
            out.println("  <div class='bus-details'>");
            out.println("    <p><strong>Starting Point:</strong> " + bus.getStartingPoint() + "</p>");
            out.println("    <p><strong>Driver:</strong> " + bus.getDriverName() + " (📞 " + bus.getDriverContact() + ")</p>");
            out.println("  </div>");
            out.println("  <div class='route-stops'>");
            out.println("    <h4>Route Stops & Timelines:</h4>");
            out.println("    <ol class='stops-timeline'>");
            if (bus.getStops() != null) {
                for (BusStop stop : bus.getStops()) {
                    out.println("      <li>" + stop.getStopName() + "</li>");
                }
            }
            out.println("    </ol>");
            out.println("  </div>");
            out.println("</div>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
