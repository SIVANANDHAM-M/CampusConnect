package com.campusconnect.servlet;

import com.campusconnect.dao.*;
import com.campusconnect.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ServiceRequestDAO serviceDAO = new ServiceRequestDAO();
    private LostFoundDAO lostFoundDAO = new LostFoundDAO();
    private MarketplaceDAO marketplaceDAO = new MarketplaceDAO();
    private HostelDAO hostelDAO = new HostelDAO();
    private ComplaintDAO complaintDAO = new ComplaintDAO();
    private EventDAO eventDAO = new EventDAO();
    private SportsDAO sportsDAO = new SportsDAO();
    private StudentDAO studentDAO = new StudentDAO();
    private NoticeDAO noticeDAO = new NoticeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch data for all admin management tabs
        request.setAttribute("serviceRequests", serviceDAO.getAllServiceRequests());
        request.setAttribute("lostItems", lostFoundDAO.getAllLostItems());
        request.setAttribute("foundItems", lostFoundDAO.getAllFoundItems());
        request.setAttribute("marketplaceItems", marketplaceDAO.getAllItems());
        request.setAttribute("hostelComplaints", hostelDAO.getAllHostelComplaints());
        request.setAttribute("complaints", complaintDAO.getAllComplaints());
        request.setAttribute("eventRegistrations", eventDAO.getAllRegistrations());
        request.setAttribute("sportsRegistrations", sportsDAO.getAllRegistrations());
        request.setAttribute("students", studentDAO.getAllStudents());
        request.setAttribute("notices", noticeDAO.getAllNotices());

        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("updateServiceStatus".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("requestId"));
                String status = request.getParameter("status");
                serviceDAO.updateStatus(id, status);
            } else if ("updateLostStatus".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("lostId"));
                String status = request.getParameter("status");
                lostFoundDAO.updateLostStatus(id, status);
            } else if ("updateFoundStatus".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("foundId"));
                String status = request.getParameter("status");
                lostFoundDAO.updateFoundStatus(id, status);
            } else if ("updateMarketStatus".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("itemId"));
                String status = request.getParameter("status");
                marketplaceDAO.updateItemStatus(id, status);
            } else if ("updateHostelStatus".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("complaintId"));
                String status = request.getParameter("status");
                hostelDAO.updateComplaintStatus(id, status);
            } else if ("updateComplaintStatus".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("complaintId"));
                String status = request.getParameter("status");
                complaintDAO.updateStatus(id, status);
            }
            response.sendRedirect("adminDashboard.jsp?msg=Status+updated+successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=Failed+to+update+status");
        }
    }
}
