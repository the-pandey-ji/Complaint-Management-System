<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.entity.User" %>
<%@ page import="com.DB.DBConnect" %>

<%
    // ================= SESSION CHECK =================
    User user = (User) session.getAttribute("Userobj");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ================= GET COMPLAINT ID =================
    int complaintId = 0;
    try {
        complaintId = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        complaintId = 0;
    }

    // ================= COMPLAINT INFO =================
    String complaintTitle = "";
    String complaintType = "";
    String complaintDate = "";

    // ================= FEEDBACK INFO =================
    int rating = 0;
    String message = "";
    String imageFile = "";
    String createdAt = "";

    boolean complaintValid = false;
    boolean feedbackFound = false;

    if (complaintId > 0) {
        try {
            Connection conn = DBConnect.getConnection();

            // ✅ Check complaint belongs to user and is CLOSED
            String complaintSql =
                "SELECT TITLE, COMPLAINT_TYPE, TO_CHAR(COMPDATETIME,'DD-MON-YYYY HH:MI AM') CDT " +
                "FROM CTRACK.COMPLAINTDTLS " +
                "WHERE ID=? AND EMPN=? AND LOWER(STATUS)='closed'";

            PreparedStatement ps1 = conn.prepareStatement(complaintSql);
            ps1.setInt(1, complaintId);
            ps1.setLong(2, user.getEmpn());

            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                complaintValid = true;
                complaintTitle = rs1.getString("TITLE");
                complaintType = rs1.getString("COMPLAINT_TYPE");
                complaintDate = rs1.getString("CDT");
            }

            rs1.close();
            ps1.close();

            // ✅ Fetch feedback if complaint valid
            if (complaintValid) {
                String fbSql =
                    "SELECT RATING, MESSAGE, IMAGEFILE, TO_CHAR(CREATED_AT,'DD-MON-YYYY HH:MI AM') AS CRT " +
                    "FROM CTRACK.COMPLAINT_FEEDBACK " +
                    "WHERE COMPLAINT_ID=? AND EMPN=?";

                PreparedStatement ps2 = conn.prepareStatement(fbSql);
                ps2.setInt(1, complaintId);
                ps2.setLong(2, user.getEmpn());

                ResultSet rs2 = ps2.executeQuery();
                if (rs2.next()) {
                    feedbackFound = true;
                    rating = rs2.getInt("RATING");
                    message = rs2.getString("MESSAGE");
                    imageFile = rs2.getString("IMAGEFILE");
                    createdAt = rs2.getString("CRT");
                }

                rs2.close();
                ps2.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Feedback</title>

<%@include file="all_component/allCss.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* ================= VIEW FEEDBACK PAGE (RESPONSIVE + SAFE WITH NAVBAR) ================= */

.vf-page {
    background: #f4f6f9;
    padding: 20px 0;
    min-height: 100vh;
    font-family: Arial, sans-serif;
}

/* Main Card */
.vf-container {
    width: 100%;
    max-width: 900px;
    margin: 25px auto;
    background: #fff;
    padding: 30px;
    border-radius: 16px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.12);
}

/* Header */
.vf-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    margin-bottom: 18px;
    flex-wrap: wrap;
}

.vf-title {
    font-size: 22px;
    font-weight: 700;
    color: #111827;
    display: flex;
    align-items: center;
    gap: 8px;
}

/* Back Button */
.vf-back-btn {
    text-decoration: none;
    padding: 10px 14px;
    background: #111827;
    color: #fff;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 600;
    transition: 0.2s ease;
    white-space: nowrap;
}

.vf-back-btn:hover {
    background: #000;
    color: #fff;
    text-decoration: none;
}

/* Complaint Info Box */
.vf-info-box {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    padding: 14px;
    border-radius: 12px;
    margin-bottom: 16px;
    font-size: 14px;
    line-height: 1.6;
    overflow-wrap: break-word;
}

/* Errors */
.vf-alert-danger {
    background: #fee2e2;
    color: #991b1b;
    padding: 12px;
    border-radius: 10px;
    margin-bottom: 15px;
    text-align: center;
    font-weight: 600;
    border-left: 5px solid #ef4444;
}

/* Stars */
.vf-stars {
    font-size: 34px;
    margin: 10px 0 18px;
    display: flex;
    gap: 6px;
    flex-wrap: wrap;
}

.vf-star {
    color: #cbd5e1;
}

.vf-star.active {
    color: #f59e0b;
}

/* Message box */
.vf-message-box {
    border: 1px solid #cbd5e1;
    border-radius: 12px;
    padding: 12px;
    background: #fff;
    font-size: 14px;
    line-height: 1.6;
    white-space: pre-wrap;
    word-wrap: break-word;
    overflow-wrap: break-word;
}

/* Image */
.vf-image {
    width: 250px;
    max-width: 100%;
    height: auto;
    aspect-ratio: 1 / 1;
    object-fit: cover;
    border-radius: 14px;
    border: 1px solid #ddd;
    margin-top: 10px;
    display: block;
}

/* ================= MOBILE RESPONSIVE ================= */
@media (max-width: 768px) {

    .vf-page {
        padding: 12px 0;
    }

    .vf-container {
        margin: 12px;
        padding: 18px;
        border-radius: 14px;
    }

    .vf-header {
        flex-direction: column;
        align-items: stretch;
    }

    .vf-title {
        font-size: 18px;
    }

    .vf-back-btn {
        width: 100%;
        text-align: center;
    }

    .vf-stars {
        justify-content: center;
        font-size: 32px;
    }

    .vf-message-box {
        font-size: 13px;
    }

    .vf-image {
        width: 100%;
        max-width: 320px;
        margin-left: auto;
        margin-right: auto;
    }
}

/* EXTRA SMALL SCREEN (320px) */
@media (max-width: 420px) {

    .vf-container {
        padding: 14px;
    }

    .vf-title {
        font-size: 16px;
    }

    .vf-stars {
        font-size: 28px;
        gap: 4px;
    }
}
</style>

</head>

<body>

<%@include file="all_component/navbar.jsp"%>

<div class="vf-page">
    <div class="vf-container">

        <div class="vf-header">
            <div class="vf-title">
                <i class="fa-solid fa-eye"></i> View Feedback
            </div>

            <a class="vf-back-btn" href="closedComplaints.jsp">
                <i class="fa-solid fa-arrow-left"></i> Back
            </a>
        </div>

        <% if (complaintId <= 0 || !complaintValid) { %>
            <div class="vf-alert-danger">
                Invalid complaint ID OR complaint not closed / not belongs to you.
            </div>

        <% } else if (!feedbackFound) { %>
            <div class="vf-alert-danger">
                Feedback not found for this complaint.
            </div>

        <% } else { %>

            <div class="vf-info-box">
                <b>Complaint ID:</b> <%= complaintId %><br>
                <b>Complaint Type:</b> <%= complaintType %><br>
                <b>Title:</b> <%= complaintTitle %><br>
                <b>Closed Date:</b> <%= complaintDate %><br>
                <b>Feedback Date:</b> <%= createdAt %>
            </div>

            <h5><i class="fa-solid fa-star"></i> Rating</h5>
            <div class="vf-stars">
                <span class="vf-star <%= (rating >= 1 ? "active" : "") %>">&#9733;</span>
                <span class="vf-star <%= (rating >= 2 ? "active" : "") %>">&#9733;</span>
                <span class="vf-star <%= (rating >= 3 ? "active" : "") %>">&#9733;</span>
                <span class="vf-star <%= (rating >= 4 ? "active" : "") %>">&#9733;</span>
                <span class="vf-star <%= (rating >= 5 ? "active" : "") %>">&#9733;</span>
            </div>

            <h5><i class="fa-solid fa-comment"></i> Feedback Message</h5>
            <div class="vf-message-box">
                <%= message %>
            </div>

            <% if (imageFile != null && !imageFile.trim().isEmpty()) { %>
                <h5 class="mt-3"><i class="fa-solid fa-image"></i> Uploaded Photo</h5>
                <img src="feedback_images/<%= imageFile %>" class="vf-image" alt="Feedback Photo">
            <% } %>

        <% } %>

    </div>
</div>

</body>
</html>
