package com.Admin.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.entity.Complaintdtls;

/**
 * Servlet implementation class ComplaintAdd
 */
@WebServlet("/addcomplaint")
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
			String image = request.getParameter("image");
			String category = request.getParameter("category");
			String title = request.getParameter("title");
			String description = request.getParameter("description");
			
			int empn = Integer.parseInt(request.getParameter("empn"));
			
			Part imagePart = request.getPart("imagefile");
			String fileName = imagePart.getSubmittedFileName();
			
			// Save the image file to the server (optional, if you want to store it)
			 String imagePath = "path/to/save/" + fileName;
			 imagePart.write(imagePath);
			
			HttpSession session = request.getSession();
			
			
			Complaintdtls cm = new Complaintdtls(fileName, category, title, description, null, null, empn, null, null, "Pending", "Not yet actioned");
			com.DAO.ComplaintDAO cmdao = new com.DAO.ComplaintDAOImpl(com.DB.DBConnect.getConnection());

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error: " + e.getMessage());
		}
		
	}

}
