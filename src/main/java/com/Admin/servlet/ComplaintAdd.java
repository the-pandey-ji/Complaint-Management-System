package com.Admin.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.DAO.ComplaintDAOImpl;
import com.DB.DBConnect;
import com.entity.Complaintdtls;

/**
 * Servlet implementation class ComplaintAdd
 */
@WebServlet("/addcomplaint")
@MultipartConfig
public class ComplaintAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplaintAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String category = request.getParameter("category");
			String title = request.getParameter("title");
			String description = request.getParameter("description");
			String qtrno = request.getParameter("qtrno");
			String username = request.getParameter("username");
			String phone = request.getParameter("phone");
			String status = "Active"; // Default status"
			
			int empn = Integer.parseInt(request.getParameter("empn"));
			
			Part imagePart = request.getPart("imagefile");
			String fileName = imagePart.getSubmittedFileName();
			
			// Save the image file to the server (optional, if you want to store it)
			// String imagePath = "path/to/save/" + fileName;
			// imagePart.write(imagePath);
			
			//HttpSession session = request.getSession();
			
			
			Complaintdtls cm = new Complaintdtls(fileName, category, title, description, qtrno, empn, username, phone, status, "Not yet actioned");
//			System.out.println(cm);
			ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
			boolean f = dao.addComplaint(cm);
			HttpSession session = request.getSession();
			
			if (f) {
				session.setAttribute("succMsg", "Complaint added successfully.");
				response.sendRedirect("admin/addComplaint.jsp");
			} else {
				session.setAttribute("failedMsg", "Something went wrong. Please try again.");
				response.sendRedirect("admin/addComplaint.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error: " + e.getMessage());
		}
		
	}

}
