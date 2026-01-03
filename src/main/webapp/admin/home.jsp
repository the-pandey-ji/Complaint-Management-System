<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entity.User" %>

<%
    User user = (User) session.getAttribute("Userobj");
    if (user == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
    if (!user.getRole().equals("AC") && !user.getRole().equals("AE")) {
        response.sendRedirect("../home.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>

<%@ include file="allCss.jsp" %>

<style>
/* ===== BASE (LIGHT MODE) ===== */

body {
    font-family: "Segoe UI", Roboto, Arial;
    background-color: #f5f6fa;
}

/* Sidebar */
.sidebar {
    height: 100vh;
    background: #1e272e;
    color: white;
    position: fixed;
    width: 240px;
    padding-top: 30px;
}

.sidebar h4 {
    text-align: center;
    margin-bottom: 30px;
}

.sidebar a {
    color: #dcdde1;
    display: block;
    padding: 12px 25px;
    text-decoration: none;
}

.sidebar a:hover {
    background: #485460;
    color: white;
}

/* Main content */
.main {
    margin-left: 240px;
    padding: 30px;
}

/* Cards */
.stat-card {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 6px 15px rgba(0,0,0,0.08);
}

.stat-card h6 {
    color: #6c757d;
}

.stat-card h2 {
    font-weight: 700;
}

/* Action cards */
.action-card {
    background: white;
    border-radius: 12px;
    padding: 30px;
    text-align: center;
    box-shadow: 0 8px 18px rgba(0,0,0,0.10);
    transition: 0.3s;
}

.action-card:hover {
    transform: translateY(-6px);
}

.action-card i {
    font-size: 40px;
    color: #0984e3;
}

/* Table card */
.table-card {
    background: white;
    border-radius: 12px;
    padding: 25px;
    box-shadow: 0 6px 15px rgba(0,0,0,0.08);
}
</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h4>Admin Panel</h4>
    <a href="home.jsp"><i class="fas fa-home"></i> Dashboard</a>
    <a href="addComplaint.jsp"><i class="fas fa-plus-circle"></i> Add Complaint</a>
    <a href="viewComplaints.jsp"><i class="fas fa-list"></i> View Complaints</a>
    <a href="changePassword.jsp"><i class="fas fa-key"></i> Change Password</a>
    <a data-toggle="modal" data-target="#logoutModal">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>
</div>

<!-- MAIN -->
<div class="main">

    <!-- Header -->
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <div>
            <h3>Welcome, <%= user.getUsername() %></h3>
            <p class="text-muted mb-0">
                Enterprise Complaint Management Dashboard
            </p>
        </div>

        <!-- GLOBAL DARK MODE BUTTON -->
        <button class="btn btn-sm btn-dark" onclick="toggleDarkMode()">
            <i class="fas fa-moon"></i> Dark Mode
        </button>
    </div>

    <!-- KPI Cards -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="stat-card">
                <h6>Total Complaints</h6>
                <h2>--</h2>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <h6>Open Complaints</h6>
                <h2>--</h2>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <h6>Closed Complaints</h6>
                <h2>--</h2>
            </div>
        </div>
    </div>

    <!-- Actions -->
    <div class="row mb-4">
        <div class="col-md-4">
            <a href="addComplaint.jsp">
                <div class="action-card">
                    <i class="fas fa-plus-circle"></i>
                    <h5>Add Complaint</h5>
                    <p>Create a new complaint</p>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="viewComplaints.jsp">
                <div class="action-card">
                    <i class="fas fa-folder-open"></i>
                    <h5>Manage Complaints</h5>
                    <p>Edit & close complaints</p>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <div class="action-card">
                <i class="fas fa-chart-pie"></i>
                <h5>Status Analytics</h5>
                <p>Visual complaint distribution</p>
            </div>
        </div>
    </div>

    <!-- Recent Complaints -->
    <div class="table-card">
        <h5>Recent Complaints</h5>
        <table class="table table-hover mt-3">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>Category</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>#101</td>
                    <td>User A</td>
                    <td>Civil</td>
                    <td>Open</td>
                </tr>
                <tr>
                    <td>#102</td>
                    <td>User B</td>
                    <td>Electrical</td>
                    <td>Closed</td>
                </tr>
            </tbody>
        </table>
    </div>

</div>

<!-- LOGOUT MODAL -->
<div class="modal fade" id="logoutModal">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5>Confirm Logout</h5>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body text-center">
                <p>Are you sure you want to logout?</p>
                <a href="../logout" class="btn btn-danger">Logout</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
