<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.User" %>

<%
    User user = (User) session.getAttribute("Userobj");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String successMsg = null;
    String errorMsg = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String qtrno = request.getParameter("qtrno");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnect.getConnection();

            String sql =
                "UPDATE CTRACK.USERMASTER " +
                "SET QTRNO = ?, EMAIL = ?, PHONE = ? " +
                "WHERE EMPN = ?";

            ps = con.prepareStatement(sql);
            ps.setString(1, qtrno);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setLong(4, user.getEmpn());

            int i = ps.executeUpdate();

            if (i == 1) {
                successMsg = "Profile updated successfully";

                user.setQtrno(qtrno);
                user.setEmail(email);
                user.setPhone(phone);
                session.setAttribute("Userobj", user);
            } else {
                errorMsg = "Profile update failed";
            }

        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = "Something went wrong while updating profile";
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>My Profile</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<%@include file="all_component/allCss.jsp" %>

<style>
/* ================= DESKTOP (UNCHANGED) ================= */
.profile-card {
    border-radius: 16px;
    box-shadow: 0 12px 28px rgba(0,0,0,.15);
}
.profile-header {
    background: linear-gradient(135deg,#0b6b3a,#1e8f5a);
    color: white;
    border-radius: 16px 16px 0 0;
}
.form-control {
    border-radius: 10px;
}

/* ================= MOBILE ONLY FIX ================= */
@media (max-width: 768px) {

    /* Container padding fix */
    .container {
        padding-left: 12px !important;
        padding-right: 12px !important;
    }

    /* Card full width */
    .profile-card {
        border-radius: 14px;
        margin: 0;
    }

    /* Header text scale */
    .profile-header h4 {
        font-size: 1.1rem;
    }

    .profile-header small {
        font-size: 0.85rem;
    }

    /* Reduce card padding */
    .card-body {
        padding: 20px !important;
    }

    /* Inputs touch-friendly */
    .form-control {
        height: 46px;
        font-size: 14px;
    }

    /* Buttons stack vertically */
    .text-center.mt-4 {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .text-center.mt-4 .btn {
        width: 100%;
        margin: 0 !important;
    }
}

/* Extra small phones */
@media (max-width: 480px) {

    .profile-header h4 {
        font-size: 1rem;
    }

    label {
        font-size: 12px;
    }
}
</style>
</head>

<body style="background:#f4f6f8;">

<%@include file="all_component/navbar.jsp" %>

<div class="container mt-5 mb-5">
    <div class="row justify-content-center">

        <div class="col-md-6">

            <div class="card profile-card">

                <div class="card-header profile-header text-center py-4">
                    <h4 class="mb-1">
                        <i class="fas fa-user-circle mr-2"></i>
                        My Profile
                    </h4>
                    <small>View and update your contact details</small>
                </div>

                <div class="card-body p-4">

                    <% if (successMsg != null) { %>
                        <div class="alert alert-success text-center">
                            <%= successMsg %>
                        </div>
                    <% } %>

                    <% if (errorMsg != null) { %>
                        <div class="alert alert-danger text-center">
                            <%= errorMsg %>
                        </div>
                    <% } %>

                    <form method="post">

                        <div class="form-group">
                            <label>Employee ID</label>
                            <input type="text"
                                   class="form-control"
                                   value="<%= user.getEmpn() %>"
                                   readonly>
                        </div>

                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text"
                                   class="form-control"
                                   value="<%= user.getUsername() %>"
                                   readonly>
                        </div>

                        <div class="form-group">
                            <label>Quarter Number</label>
                            <input type="text"
                                   name="qtrno"
                                   class="form-control"
                                   value="<%= user.getQtrno() != null ? user.getQtrno() : "" %>">
                        </div>

                        <div class="form-group">
                            <label>Email</label>
                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   value="<%= user.getEmail() != null ? user.getEmail() : "" %>">
                        </div>

                        <div class="form-group">
                            <label>Mobile Number</label>
                            <input type="text"
                                   name="phone"
                                   class="form-control"
                                   value="<%= user.getPhone() %>"
                                   required>
                        </div>

                        <div class="form-group">
                            <label>Role</label>
                            <input type="text"
                                   class="form-control"
                                   value="<%= user.getRole() %>"
                                   readonly>
                        </div>

                        <div class="text-center mt-4">
                            <button type="submit"
                                    class="btn btn-success px-5">
                                <i class="fas fa-save mr-1"></i>
                                Update Profile
                            </button>

                            <a href="home.jsp"
                               class="btn btn-secondary ml-3 px-4">
                                Cancel
                            </a>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

<%@include file="all_component/footer.jsp" %>

</body>
</html>
