package com.campusconnect.servlet;

import com.campusconnect.dao.HostelDAO;
import com.campusconnect.model.Hostel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/hostel")
public class HostelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private HostelDAO dao = new HostelDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Hostel> hostels = dao.getAllHostels();
        request.setAttribute("hostels", hostels);
        request.getRequestDispatcher("hostel.jsp").forward(request, response);
    }
}
