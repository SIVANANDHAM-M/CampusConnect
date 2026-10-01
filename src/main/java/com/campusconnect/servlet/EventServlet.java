package com.campusconnect.servlet;

import com.campusconnect.dao.EventDAO;
import com.campusconnect.model.Event;
import com.campusconnect.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/events")
public class EventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EventDAO dao = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Student student = (session != null) ? (Student) session.getAttribute("student") : null;
        int studentId = (student != null) ? student.getStudentId() : 0;

        List<Event> eventList = dao.getAllEvents(studentId);
        request.setAttribute("events", eventList);
        request.getRequestDispatcher("events.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Admin adding new event
        try {
            String eventName = request.getParameter("eventName");
            String eventDateStr = request.getParameter("eventDate");
            String eventTime = request.getParameter("eventTime");
            String venue = request.getParameter("venue");
            String description = request.getParameter("description");

            Event ev = new Event();
            ev.setEventName(eventName);
            ev.setEventDate(Date.valueOf(eventDateStr));
            ev.setEventTime(eventTime);
            ev.setVenue(venue);
            ev.setDescription(description);

            boolean success = dao.addEvent(ev);
            if (success) {
                response.sendRedirect("adminDashboard.jsp?msg=Event+added+successfully");
            } else {
                response.sendRedirect("adminDashboard.jsp?error=Failed+to+add+event");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=Invalid+event+input");
        }
    }
}
