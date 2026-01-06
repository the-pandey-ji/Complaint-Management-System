<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.entity.User" %>

<%
    // SESSION CHECK
    User user = (User) session.getAttribute("Userobj");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String successMsg = null;
    String errorMsg = null;

    // HANDLE UPDATE (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String qtrno = request.getParameter("qtrno");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnect.getConnection();

            // 🔒 USERNAME NOT UPDATED
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

                // UPDATE SESSION OBJECT
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

<%@include file="all_component/allCss.jsp" %>

<style>
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
</style>
</head>

<body style="background:#f4f6f8;">

<%@include file="all_component/navbar.jsp" %>

<div class="container mt-5 mb-5">
    <div class="row justify-content-center">

        <div class="col-md-6">

            <div class="card profile-card">

                <!-- HEADER -->
                <div class="card-header profile-header text-center py-4">
                    <h4 class="mb-1">
                        <i class="fas fa-user-circle mr-2"></i>
                        My Profile
                    </h4>
                    <small>View and update your contact details</small>
                </div>

                <div class="card-body p-4">

                    <!-- MESSAGES -->
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

                    <!-- PROFILE FORM -->
                    <form method="post">

                        <!-- EMPN -->
                        <div class="form-group">
                            <label>Employee ID</label>
                            <input type="text"
                                   class="form-control"
                                   value="<%= user.getEmpn() %>"
                                   readonly>
                        </div>

                        <!-- USERNAME (READ ONLY) -->
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text"
                                   class="form-control"
                                   value="<%= user.getUsername() %>"
                                   readonly>
                        </div>

                        <!-- QTR -->
                        <div class="form-group">
                            <label>Quarter Number</label>
                            <input type="text"
                                   name="qtrno"
                                   class="form-control"
                                   value="<%= user.getQtrno() != null ? user.getQtrno() : "" %>">
                        </div>

                        <!-- EMAIL -->
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   value="<%= user.getEmail() != null ? user.getEmail() : "" %>">
                        </div>

                        <!-- PHONE -->
                        <div class="form-group">
                            <label>Mobile Number</label>
                            <input type="text"
                                   name="phone"
                                   class="form-control"
                                   value="<%= user.getPhone() %>"
                                   required>
                        </div>

                        <!-- ROLE -->
                        <div class="form-group">
                            <label>Role</label>
                            <input type="text"
                                   class="form-control"
                                   value="<%= user.getRole() %>"
                                   readonly>
                        </div>

                        <!-- BUTTONS -->
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
