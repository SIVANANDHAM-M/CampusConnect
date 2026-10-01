package com.campusconnect.servlet;

import com.campusconnect.dao.NoticeDAO;
import com.campusconnect.model.Notice;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/notices")
public class NoticeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private NoticeDAO dao = new NoticeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Notice> notices = dao.getAllNotices();
        request.setAttribute("notices", notices);
        request.getRequestDispatcher("notices.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equalsIgnoreCase(action)) {
            try {
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String category = request.getParameter("category");
                String noticeDateStr = request.getParameter("noticeDate");

                Notice notice = new Notice();
                notice.setTitle(title);
                notice.setDescription(description);
                notice.setCategory(category);
                notice.setNoticeDate(Date.valueOf(noticeDateStr));

                dao.addNotice(notice);
                response.sendRedirect("adminDashboard.jsp?msg=Notice+published+successfully");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("adminDashboard.jsp?error=Invalid+notice+data");
            }
        } else if ("delete".equalsIgnoreCase(action)) {
            try {
                int noticeId = Integer.parseInt(request.getParameter("noticeId"));
                dao.deleteNotice(noticeId);
                response.sendRedirect("adminDashboard.jsp?msg=Notice+deleted+successfully");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("adminDashboard.jsp?error=Failed+to+delete+notice");
            }
        }
    }
}
