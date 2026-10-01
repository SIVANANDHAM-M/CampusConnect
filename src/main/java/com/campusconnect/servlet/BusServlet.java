package com.campusconnect.servlet;

import com.campusconnect.dao.BusDAO;
import com.campusconnect.model.Bus;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/bus")
public class BusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private BusDAO dao = new BusDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Bus> buses = dao.getAllBuses();
        request.setAttribute("buses", buses);
        request.getRequestDispatcher("bus.jsp").forward(request, response);
    }
}
