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

    // ================= SESSION MESSAGES =================
    String succMsg = (String) session.getAttribute("succMsg");
    String failedMsg = (String) session.getAttribute("failedMsg");

    if (succMsg != null) session.removeAttribute("succMsg");
    if (failedMsg != null) session.removeAttribute("failedMsg");

    // ================= COMPLAINT ID =================
    int complaintId = 0;
    try {
        complaintId = Integer.parseInt(request.getParameter("id"));
    } catch(Exception e) {
        complaintId = 0;
    }

    // ================= FETCH COMPLAINT INFO =================
    String complaintTitle = "";
    String complaintType = "";
    String complaintDate = "";

    if (complaintId > 0) {
        try {
            Connection conn = DBConnect.getConnection();

            String sql =
                "SELECT TITLE, COMPLAINT_TYPE, TO_CHAR(COMPDATETIME,'DD-MON-YYYY HH:MI AM') CDT " +
                "FROM CTRACK.COMPLAINTDTLS " +
                "WHERE ID=? AND EMPN=? AND LOWER(STATUS)='closed'";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, complaintId);
            ps.setLong(2, user.getEmpn());

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                complaintTitle = rs.getString("TITLE");
                complaintType = rs.getString("COMPLAINT_TYPE");
                complaintDate = rs.getString("CDT");
            }

            rs.close();
            ps.close();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Complaint Feedback</title>

<%@include file="all_component/allCss.jsp"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* ================= FEEDBACK PAGE CSS (RESPONSIVE + SAFE WITH NAVBAR) ================= */

.fb-page {
    background: #f4f6f9;
    padding: 20px 0;
    min-height: 100vh;
    font-family: Arial, sans-serif;
}

/* Main Card */
.fb-container {
    width: 100%;
    max-width: 900px;
    margin: 25px auto;
    background: #ffffff;
    padding: 30px;
    border-radius: 16px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.12);
}

/* Header Section */
.fb-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    margin-bottom: 18px;
    flex-wrap: wrap;
}

.fb-title {
    font-size: 22px;
    font-weight: 700;
    color: #111827;
    display: flex;
    align-items: center;
    gap: 8px;
}

.fb-back-btn {
    text-decoration: none;
    padding: 10px 14px;
    background: #111827;
    color: #ffffff;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 600;
    transition: 0.2s ease;
    white-space: nowrap;
}

.fb-back-btn:hover {
    background: #000000;
    color: #ffffff;
    text-decoration: none;
}

/* Alert Messages */
.fb-alert-success {
    background: #d1fae5;
    color: #065f46;
    padding: 12px;
    border-radius: 10px;
    margin-bottom: 15px;
    text-align: center;
    font-weight: 600;
    border-left: 5px solid #10b981;
}

.fb-alert-danger {
    background: #fee2e2;
    color: #991b1b;
    padding: 12px;
    border-radius: 10px;
    margin-bottom: 15px;
    text-align: center;
    font-weight: 600;
    border-left: 5px solid #ef4444;
}

/* Complaint Info Box */
.fb-info-box {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    padding: 14px;
    border-radius: 12px;
    margin-bottom: 16px;
    font-size: 14px;
    line-height: 1.6;
    overflow-wrap: break-word;
}

/* Form */
.fb-form-group {
    margin-bottom: 14px;
}

.fb-label {
    font-weight: 700;
    color: #1f2937;
    display: block;
    margin-bottom: 6px;
    font-size: 14px;
}

.fb-textarea,
.fb-file {
    width: 100%;
    padding: 10px;
    border: 1px solid #cbd5e1;
    border-radius: 10px;
    outline: none;
    font-size: 14px;
    transition: 0.2s ease;
}

.fb-textarea {
    resize: vertical;
    min-height: 120px;
}

.fb-textarea:focus,
.fb-file:focus {
    border-color: #2563eb;
    box-shadow: 0 0 0 3px rgba(37,99,235,0.12);
}

/* Submit Button */
.fb-submit-btn {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 10px;
    background: #2563eb;
    color: white;
    font-weight: 700;
    cursor: pointer;
    font-size: 15px;
    transition: 0.2s ease;
}

.fb-submit-btn:hover {
    background: #1d4ed8;
}

/* Star Rating Responsive */
.fb-star-rating {
    display: flex;
    flex-direction: row-reverse;
    justify-content: flex-start;
    flex-wrap: wrap;
    gap: 2px;
}

.fb-star-rating input {
    position: absolute;
    left: -9999px;
    opacity: 0;
}

.fb-star-rating label {
    font-size: 40px;
    color: #cbd5e1;
    cursor: pointer;
    padding: 0 2px;
    transition: 0.2s ease;
    line-height: 1;
}

.fb-star-rating input:checked ~ label,
.fb-star-rating label:hover,
.fb-star-rating label:hover ~ label {
    color: #f59e0b;
}

/* ✅ RESPONSIVE (Mobile Perfect) */
@media (max-width: 768px) {

    .fb-page {
        padding: 10px 0;
    }

    .fb-container {
        margin: 12px;
        padding: 18px;
        border-radius: 14px;
    }

    .fb-title {
        font-size: 18px;
    }

    .fb-header {
        flex-direction: column;
        align-items: stretch;
    }

    .fb-back-btn {
        width: 100%;
        text-align: center;
        padding: 10px;
    }

    .fb-info-box {
        font-size: 13px;
    }

    /* ✅ Stars center on mobile */
    .fb-star-rating {
        justify-content: center;
    }

    .fb-star-rating label {
        font-size: 36px;
    }

    .fb-submit-btn {
        font-size: 15px;
    }
}

/* ✅ EXTRA SMALL (like 320px) */
@media (max-width: 420px) {

    .fb-container {
        padding: 14px;
    }

    .fb-title {
        font-size: 16px;
    }

    .fb-star-rating label {
        font-size: 32px;
    }
}
</style>

</head>

<body>

<%@include file="all_component/navbar.jsp"%>

<div class="fb-page">
    <div class="fb-container">

        <div class="fb-header">
            <div class="fb-title">
                <i class="fa-solid fa-star"></i> Complaint Feedback
            </div>

            <a class="fb-back-btn" href="closedComplaints.jsp">
                <i class="fa-solid fa-arrow-left"></i> Back
            </a>
        </div>

        <% if (succMsg != null) { %>
            <div class="fb-alert-success"><%= succMsg %></div>
        <% } %>

        <% if (failedMsg != null) { %>
            <div class="fb-alert-danger"><%= failedMsg %></div>
        <% } %>

        <% if (complaintId <= 0 || complaintTitle.trim().isEmpty()) { %>
            <div class="fb-alert-danger">
                Complaint ID not found / Complaint is not closed. Please go back and click Feedback button.
            </div>
        <% } else { %>

            <div class="fb-info-box">
                <b>Complaint ID:</b> <%= complaintId %><br>
                <b>Complaint Type:</b> <%= complaintType %><br>
                <b>Title:</b> <%= complaintTitle %><br>
                <b>Closed Date:</b> <%= complaintDate %>
            </div>

            <!-- ✅ Submit to Servlet -->
            <form action="submitFeedback" method="post" enctype="multipart/form-data">

                <input type="hidden" name="complaint_id" value="<%= complaintId %>">

                <div class="fb-form-group">
                    <label class="fb-label">Rating (1 to 5) *</label>

                    <div class="fb-star-rating">
                        <input type="radio" id="star5" name="rating" value="5" required>
                        <label for="star5">&#9733;</label>

                        <input type="radio" id="star4" name="rating" value="4">
                        <label for="star4">&#9733;</label>

                        <input type="radio" id="star3" name="rating" value="3">
                        <label for="star3">&#9733;</label>

                        <input type="radio" id="star2" name="rating" value="2">
                        <label for="star2">&#9733;</label>

                        <input type="radio" id="star1" name="rating" value="1">
                        <label for="star1">&#9733;</label>
                    </div>
                </div>

                <div class="fb-form-group">
                    <label class="fb-label">Feedback Message *</label>
                    <textarea class="fb-textarea" name="message" required placeholder="Write your feedback..."></textarea>
                </div>

                <div class="fb-form-group">
                    <label class="fb-label">Upload Photo (Optional)</label>
                    <input class="fb-file" type="file" name="photo" accept="image/jpeg,image/jpg,image/png">
                </div>

                <button type="submit" class="fb-submit-btn">
                    <i class="fa-solid fa-paper-plane"></i> Submit Feedback
                </button>

            </form>

        <% } %>

    </div>
</div>

</body>
</html>
