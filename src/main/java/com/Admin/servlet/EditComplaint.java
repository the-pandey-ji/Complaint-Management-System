package com.Admin.servlet;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

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

@WebServlet("/complaintEdit")
@MultipartConfig(
    maxFileSize = 10 * 1024 * 1024,     // 10 MB
    maxRequestSize = 20 * 1024 * 1024   // 20 MB
)
public class EditComplaint extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        /* ================= SESSION CHECK ================= */
        if (session == null || session.getAttribute("Userobj") == null) {
            response.sendRedirect("/Complaint-Management-System/login.jsp");
            return;
        }

        try {
            /* ================= FORM DATA ================= */
            int id            = Integer.parseInt(request.getParameter("id"));
            String category   = request.getParameter("category");
            String title      = request.getParameter("title");
            String description= request.getParameter("description");
            String qtrno      = request.getParameter("qtrno");
            String username   = request.getParameter("username");
            String phone      = request.getParameter("phone");
            long empn         = Long.parseLong(request.getParameter("empn"));
            String complaintType = request.getParameter("complaintType");

            String status = "Active";

            ComplaintDAOImpl dao =
                    new ComplaintDAOImpl(DBConnect.getConnection());

            /* ================= IMAGE HANDLING ================= */
            Part imagePart = request.getPart("imagefile");

            String imageFileName;

            // Fetch existing complaint for fallback image
            Complaintdtls existingComplaint = dao.getComplaintById(id);

            if (imagePart != null && imagePart.getSize() > 0) {

                String originalName = imagePart.getSubmittedFileName();
                String extension = originalName.substring(
                        originalName.lastIndexOf(".") + 1).toLowerCase();

                /* ===== FILE TYPE VALIDATION ===== */
                if (!extension.equals("jpg") &&
                    !extension.equals("jpeg") &&
                    !extension.equals("png")) {

                    session.setAttribute("failedMsg",
                        "Invalid file type. Only JPG, JPEG & PNG allowed.");
                    response.sendRedirect("admin/addComplaint.jsp");
                    return;
                }

                /* ===== FILE SIZE VALIDATION ===== */
                if (imagePart.getSize() > 10 * 1024 * 1024) {
                    session.setAttribute("failedMsg",
                        "File size exceeds 10 MB limit.");
                    response.sendRedirect("admin/addComplaint.jsp");
                    return;
                }

                /* ===== UNIQUE FILE NAME ===== */
                imageFileName =
                        "EDIT_CMP_" + empn + "_" +
                        System.currentTimeMillis() + "_" +
                        UUID.randomUUID().toString().substring(0, 6) +
                        "." + extension;

                /* ===== SAVE FILE ===== */
                String uploadPath =
                        request.getServletContext().getRealPath("") + "images";

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                imagePart.write(uploadPath + File.separator + imageFileName);

            } else {
                // No new image → keep old image
                imageFileName = existingComplaint.getImage();
            }

            /* ================= UPDATE DB ================= */
            Complaintdtls updatedComplaint = new Complaintdtls(
                    id,
                    imageFileName,
                    category,
                    complaintType,
                    title,
                    description,
                    qtrno,
                    empn,
                    username,
                    phone,
                    status,
                    "Not yet addressed"
            );

            boolean result = dao.editComplaint(updatedComplaint);

            if (result) {
                session.setAttribute("succMsg",
                    "Complaint updated successfully.");
            } else {
                session.setAttribute("failedMsg",
                    "Something went wrong. Please try again.");
            }

            response.sendRedirect("admin/addComplaint.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg",
                "Server error occurred while updating complaint.");
            response.sendRedirect("admin/addComplaint.jsp");
        }
    }
}
