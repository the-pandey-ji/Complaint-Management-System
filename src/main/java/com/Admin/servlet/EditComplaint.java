package com.Admin.servlet;

import java.io.File;
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
@WebServlet("/complaintEdit")
@MultipartConfig
public class EditComplaint extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditComplaint() {
        super();
        // TODO Auto-generated constructor stub
    }

	
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
			String category = request.getParameter("category");
			String title = request.getParameter("title");
			String description = request.getParameter("description");
			String qtrno = request.getParameter("qtrno");
			String username = request.getParameter("username");
			String phone = request.getParameter("phone");
			String status = "Active"; // Default status"
			
			long empn = Long.parseLong(request.getParameter("empn"));
			
			Part imagePart = request.getPart("imagefile");
			String fileName = null;
			
			

	        // Check if a new file is uploaded
	        if (imagePart != null && imagePart.getSize() > 0) {
	            fileName = imagePart.getSubmittedFileName();
	        } else {
	            // Retrieve the existing image from the database
	            ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
	            Complaintdtls existingComplaint = dao.getComplaintById(id);
	            fileName = existingComplaint.getImage(); // Use the existing image
	        }
			
			//HttpSession session = request.getSession();
			
			
			Complaintdtls cme = new Complaintdtls(id,fileName, category, title, description, qtrno, empn, username, phone, status, "Not yet addressed");
//			System.out.println(cm);
			ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
			
			
			
			
			
			boolean f = dao.editComplaint(cme);
			HttpSession session = request.getSession();
			
			if (f) {
				
				String imagePath = request.getServletContext().getRealPath("") + "images" ;
				File imageDir = new File(imagePath);
				if (!imageDir.exists()) {
				    imageDir.mkdirs(); // Create directory if it does not exist
				}
				imagePart.write(imagePath + File.separator + fileName);
				
//				System.out.println("Image Path: " + imagePath+ File.separator + fileName);
				
				session.setAttribute("succMsg", "Complaint Updated successfully.");
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
