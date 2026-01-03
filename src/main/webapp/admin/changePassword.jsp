<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="com.entity.User" %>

<%
    // ===== SESSION CHECK =====
    User user = (User) session.getAttribute("Userobj");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin | Change Password</title>

<%@ include file="allCss.jsp" %>

<style>
/* ===== BASE ===== */
body {
    font-family: "Segoe UI", Roboto, Arial;
    background-color: #f4f6f9;
}

/* ===== SIDEBAR ===== */
.admin-sidebar {
    position: fixed;
    top: 0;
    left: 0;
    height: 100vh;
    width: 240px;
    background: #111827;
    color: #ffffff;
    padding-top: 20px;
}

.admin-sidebar h4 {
    text-align: center;
    margin-bottom: 25px;
    font-weight: 600;
}

.admin-sidebar a {
    display: block;
    padding: 12px 25px;
    color: #d1d5db;
    text-decoration: none;
    font-size: 15px;
}

.admin-sidebar a:hover,
.admin-sidebar a.active {
    background: #1f2937;
    color: #ffffff;
}

/* ===== MAIN ===== */
.admin-main {
    margin-left: 240px;
    padding: 25px;
}

/* ===== HEADER ===== */
.admin-header {
    background: #ffffff;
    padding: 20px 26px;
    border-radius: 14px;
    box-shadow: 0 6px 16px rgba(0,0,0,0.08);
    margin-bottom: 28px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.admin-title {
    font-size: 20px;
    font-weight: 600;
}

.admin-breadcrumb {
    font-size: 13px;
    color: #6c757d;
    margin-top: 2px;
}

/* ===== FORM CARD ===== */
.form-wrapper {
    max-width: 500px;
    margin: auto;
    background: #ffffff;
    border-radius: 16px;
    box-shadow: 0 12px 30px rgba(0,0,0,0.12);
    padding: 30px;
}

/* ===== DARK MODE ===== */
html.dark-mode body {
    background-color: #1e272e;
    color: #f5f6fa;
}

html.dark-mode .admin-header,
html.dark-mode .form-wrapper {
    background-color: #2f3640;
    color: #f5f6fa;
}

html.dark-mode label {
    color: #f5f6fa;
}

html.dark-mode input {
    background-color: #353b48;
    color: #f5f6fa;
    border: 1px solid #636e72;
}

html.dark-mode .admin-sidebar {
    background-color: #020617;
}
</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="admin-sidebar">
    <h4>Admin Panel</h4>

    <a href="home.jsp">
        <i class="fas fa-home"></i> Dashboard
    </a>

    <a href="addComplaint.jsp">
        <i class="fas fa-plus-circle"></i> Add Complaint
    </a>

    <a href="viewComplaints.jsp">
        <i class="fas fa-list"></i> View Complaints
    </a>

    <a href="changePassword.jsp" class="active">
        <i class="fas fa-key"></i> Change Password
    </a>

    <a href="../logout">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>
</div>

<!-- ===== MAIN CONTENT ===== -->
<div class="admin-main">

    <!-- HEADER -->
    <div class="admin-header">
        <div>
            <div class="admin-title">Change Password</div>
            <div class="admin-breadcrumb">
                Admin Panel / Security / Change Password
            </div>
        </div>

        <button class="btn btn-sm btn-dark" onclick="toggleDarkMode()">
            <i class="fas fa-moon"></i> Dark Mode
        </button>
    </div>

    <!-- FORM -->
    <div class="form-wrapper">

        <!-- SUCCESS MESSAGE -->
        <%
            String succMsg = (String) session.getAttribute("succMsg");
            if (succMsg != null) {
        %>
            <div class="alert alert-success text-center"><%= succMsg %></div>
        <%
            session.removeAttribute("succMsg");
            }
        %>

        <!-- FAILED MESSAGE -->
        <%
            String failedMsg = (String) session.getAttribute("failedMsg");
            if (failedMsg != null) {
        %>
            <div class="alert alert-danger text-center"><%= failedMsg %></div>
        <%
            session.removeAttribute("failedMsg");
            }
        %>

        <form action="../changePassword" method="post">

            <div class="form-group">
                <label>Current Password</label>
                <input type="password" name="currentPassword"
                       class="form-control" required>
            </div>

            <div class="form-group">
                <label>New Password</label>
                <input type="password" name="newPassword"
                       class="form-control" required>
            </div>

            <div class="form-group">
                <label>Confirm New Password</label>
                <input type="password" name="confirmPassword"
                       class="form-control" required>
            </div>

            <button type="submit"
                    class="btn btn-primary btn-block">
                <i class="fas fa-save"></i> Update Password
            </button>

        </form>
    </div>

</div>

</body>
</html>
