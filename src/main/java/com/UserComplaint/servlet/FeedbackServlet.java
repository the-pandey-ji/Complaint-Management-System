package com.UserComplaint.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.DB.DBConnect;
import com.entity.User;

@WebServlet("/submitFeedback")
@MultipartConfig(
    maxFileSize = 5 * 1024 * 1024,       // 5 MB
    maxRequestSize = 10 * 1024 * 1024    // 10 MB
)
public class FeedbackServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ✅ Session check
        if (session == null || session.getAttribute("Userobj") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("Userobj");

        int complaintId = 0;
        int rating = 0;
        String message = "";

        try {
            // ✅ Read values from form
            complaintId = Integer.parseInt(request.getParameter("complaint_id"));
            rating = Integer.parseInt(request.getParameter("rating"));
            message = request.getParameter("message");

            if (message == null) message = "";
            message = message.trim();

            // ✅ validations
            if (complaintId <= 0) {
                session.setAttribute("failedMsg", "Invalid complaint id!");
                response.sendRedirect("feedback.jsp?id=" + complaintId);
                return;
            }

            if (rating < 1 || rating > 5) {
                session.setAttribute("failedMsg", "Please select rating between 1 to 5!");
                response.sendRedirect("feedback.jsp?id=" + complaintId);
                return;
            }

            if (message.isEmpty()) {
                session.setAttribute("failedMsg", "Feedback message is required!");
                response.sendRedirect("feedback.jsp?id=" + complaintId);
                return;
            }

            Connection conn = DBConnect.getConnection();

            // ✅ Check complaint belongs to user & is closed
            String checkSql =
                "SELECT COUNT(*) FROM CTRACK.COMPLAINTDTLS " +
                "WHERE ID=? AND EMPN=? AND LOWER(STATUS)='closed'";

            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, complaintId);
            checkPs.setLong(2, user.getEmpn());

            ResultSet checkRs = checkPs.executeQuery();
            int valid = 0;
            if (checkRs.next()) valid = checkRs.getInt(1);

            checkRs.close();
            checkPs.close();

            if (valid == 0) {
                session.setAttribute("failedMsg", "This complaint is not closed or not belongs to you!");
                response.sendRedirect("feedback.jsp?id=" + complaintId);
                return;
            }

            // ✅ Prevent duplicate feedback
            String dupSql =
                "SELECT COUNT(*) FROM CTRACK.COMPLAINT_FEEDBACK WHERE COMPLAINT_ID=? AND EMPN=?";
            PreparedStatement dupPs = conn.prepareStatement(dupSql);
            dupPs.setInt(1, complaintId);
            dupPs.setLong(2, user.getEmpn());

            ResultSet dupRs = dupPs.executeQuery();
            int dup = 0;
            if (dupRs.next()) dup = dupRs.getInt(1);

            dupRs.close();
            dupPs.close();

            if (dup > 0) {
                session.setAttribute("failedMsg", "You already submitted feedback for this complaint!");
                response.sendRedirect("feedback.jsp?id=" + complaintId);
                return;
            }

            // ✅ Image handling (optional)
            Part imagePart = request.getPart("photo");
            String imageFileName = null;

            if (imagePart != null && imagePart.getSize() > 0) {

                String originalName = imagePart.getSubmittedFileName();
                String extension = "";

                if (originalName != null && originalName.contains(".")) {
                    extension = originalName.substring(originalName.lastIndexOf(".") + 1).toLowerCase();
                }

                if (!(extension.equals("jpg") || extension.equals("jpeg") || extension.equals("png"))) {
                    session.setAttribute("failedMsg", "Invalid file type. Only JPG, JPEG, PNG allowed.");
                    response.sendRedirect("feedback.jsp?id=" + complaintId);
                    return;
                }

                if (imagePart.getSize() > 5 * 1024 * 1024) {
                    session.setAttribute("failedMsg", "Image size must be less than 5MB.");
                    response.sendRedirect("feedback.jsp?id=" + complaintId);
                    return;
                }

                imageFileName =
                    "FB_CMP_" + complaintId + "_" + user.getEmpn() + "_" + System.currentTimeMillis() +
                    "." + extension;

                String uploadPath = request.getServletContext().getRealPath("") + "feedback_images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                imagePart.write(uploadPath + File.separator + imageFileName);
            }

            // ✅ Insert feedback
            String insertSql =
                "INSERT INTO CTRACK.COMPLAINT_FEEDBACK " +
                "(COMPLAINT_ID, EMPN, USERNAME, RATING, MESSAGE, IMAGEFILE) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(insertSql);
            ps.setInt(1, complaintId);
            ps.setLong(2, user.getEmpn());
            ps.setString(3, user.getUsername());
            ps.setInt(4, rating);
            ps.setString(5, message);
            ps.setString(6, imageFileName);

            int i = ps.executeUpdate();
            ps.close();

            if (i == 1) {
                session.setAttribute("succMsg", "Thank you! Your feedback has been submitted successfully.");
            } else {
                session.setAttribute("failedMsg", "Something went wrong while saving feedback.");
            }

            response.sendRedirect("feedback.jsp?id=" + complaintId);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "Server error: " + e.getMessage());
            response.sendRedirect("feedback.jsp?id=" + complaintId);
        }
    }
}
