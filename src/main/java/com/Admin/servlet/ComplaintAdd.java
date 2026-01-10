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

@WebServlet("/addcomplaint")
@MultipartConfig(
    maxFileSize = 10 * 1024 * 1024,     // 10 MB
    maxRequestSize = 20 * 1024 * 1024   // 20 MB
)
public class ComplaintAdd extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        try {
            /* ================= SESSION CHECK ================= */
            if (session == null || session.getAttribute("Userobj") == null) {
                response.sendRedirect("home.jsp");
                return;
            }

            /* ================= FORM DATA ================= */
            String category    = request.getParameter("category");
            String title       = request.getParameter("title");
            String description = request.getParameter("description");
            String qtrno       = request.getParameter("qtrno");
            String username    = request.getParameter("username");
            String phone       = request.getParameter("phone");
            String complaintType = request.getParameter("complaintType");
            long empn          = Long.parseLong(request.getParameter("empn"));

            String status = "Active";

            /* ================= IMAGE HANDLING ================= */
            Part imagePart = request.getPart("imagefile");

            String imageFileName = "default.png"; // fallback image
            String uploadPath =
                    request.getServletContext().getRealPath("") + "images";

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
                        "ADMIN_CMP_" + empn + "_" +
                        System.currentTimeMillis() + "_" +
                        UUID.randomUUID().toString().substring(0, 6) +
                        "." + extension;

                /* ===== CREATE DIRECTORY ===== */
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                /* ===== SAVE FILE ===== */
                imagePart.write(uploadPath + File.separator + imageFileName);
            }

            /* ================= SAVE TO DB ================= */
            Complaintdtls complaint = new Complaintdtls(
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

            ComplaintDAOImpl dao =
                    new ComplaintDAOImpl(DBConnect.getConnection());

            boolean result = dao.addComplaint(complaint);

            if (result) {
                session.setAttribute("succMsg",
                    "Complaint added successfully.");
            } else {
                session.setAttribute("failedMsg",
                    "Something went wrong. Please try again.");
            }

            response.sendRedirect("admin/addComplaint.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg",
                "Server error occurred. Please contact admin.");
            response.sendRedirect("admin/addComplaint.jsp");
        }
    }
}
