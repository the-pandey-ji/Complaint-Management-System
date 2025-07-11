
package com.UserComplaint.servlet;

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

@WebServlet("/addcomplaintuser") // Correct servlet mapping
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // Set max file size to 10MB
public class AddUserComplaint extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("Userobj") == null) {
                response.sendRedirect("home.jsp");
                return;
            }

            String category = request.getParameter("category");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String qtrno = request.getParameter("qtrno");
            String username = request.getParameter("username");
            String phone = request.getParameter("phone");
            String status = "Active";
            long empn = Long.parseLong(request.getParameter("empn"));

            Part imagePart = request.getPart("imagefile");
            String fileName = imagePart.getSubmittedFileName();
            String defaultImage = "default.png"; // Default image file name
            String imagePath = request.getServletContext().getRealPath("") + File.separator + "Complaint-Management-System" + File.separator + "images";

            // Validate file type and size
            if (fileName != null && !fileName.isEmpty()) {
                String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                if (!fileExtension.equals("jpg") && !fileExtension.equals("png") && !fileExtension.equals("jpeg")) {
                    session.setAttribute("failedMsg", "Invalid file type. Only JPG, PNG, and JPEG are allowed.");
                    response.sendRedirect("addUserComplaint.jsp");
                    return;
                }

                if (imagePart.getSize() > 10 * 1024 * 1024) { // 10MB size limit
                    session.setAttribute("failedMsg", "File size exceeds the 10MB limit.");
                    response.sendRedirect("addUserComplaint.jsp");
                    return;
                }

                // Save the uploaded file
                File imageDir = new File(imagePath);
                if (!imageDir.exists()) {
                    imageDir.mkdirs();
                }
                imagePart.write(imagePath + File.separator + fileName);
            } else {
                // Use default image if no file is uploaded
                fileName = defaultImage;
            }

            Complaintdtls cm = new Complaintdtls(fileName, category, title, description, qtrno, empn, username, phone, status, "Not yet addressed");
            ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());

            boolean f = dao.addComplaint(cm);
            if (f) {
                session.setAttribute("succMsg", "Complaint added successfully.");
                response.sendRedirect("addUserComplaint.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong. Please try again.");
                response.sendRedirect("addUserComplaint.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
