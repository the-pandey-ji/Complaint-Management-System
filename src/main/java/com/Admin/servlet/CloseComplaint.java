package com.Admin.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.ComplaintDAOImpl;
import com.DB.DBConnect;

@WebServlet("/ComplaintClose")
public class CloseComplaint extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	 // Check if the user session exists
        HttpSession sessionback = request.getSession(false); // Get the current session, do not create a new one
//        System.out.println("Session back: " + sessionback);
        
        if (sessionback == null || sessionback.getAttribute("Userobj") == null) {
            // Redirect to login page if session is invalid or user is logged out
            response.sendRedirect("/Complaint-Management-System/login.jsp");
            return;
        }
    	
		try {
		
        int id = Integer.parseInt(request.getParameter("id"));
        String actionTaken = request.getParameter("actionTaken");
        System.out.println("Complaint ID: " + id);

        ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
        boolean result = dao.closeComplaint(id, actionTaken);

		HttpSession session = request.getSession();

		if (result) {
			session.setAttribute("successMsg", "Complaint closed successfully");
			response.sendRedirect("admin/viewComplaints.jsp");
		} else {
			session.setAttribute("errorMsg", "Failed to close the complaint");
			response.sendRedirect("admin/closeComplaint.jsp");
		}
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("admin/closeComplaint.jsp?error=An error occurred while closing the complaint");
	}
}
}