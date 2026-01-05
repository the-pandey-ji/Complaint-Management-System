<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.entity.User" %>
<%@ page import="com.DAO.ComplaintDAOImpl" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="java.sql.Connection" %>

<%
    // ===== SESSION & ROLE CHECK =====
    User user = (User) session.getAttribute("Userobj");

    if (user == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
    if (!user.getRole().equals("AC") && !user.getRole().equals("AE")) {
        response.sendRedirect("../home.jsp");
        return;
    }

    // ===== ROLE → CATEGORY MAPPING =====
    String category = "";
    if (user.getRole().equals("AC")) {
        category = "Civil";
    } else if (user.getRole().equals("AE")) {
        category = "Electrical";
    }

    // ===== REAL-TIME DATA =====
    Connection con = DBConnect.getConnection();
    ComplaintDAOImpl dao = new ComplaintDAOImpl(con);

    int totalCount  = dao.getTotalComplaintCountByCategory(category);
    int openCount   = dao.getOpenComplaintCountByCategory(category);
    int closedCount = dao.getClosedComplaintCountByCategory(category);
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>

<%@ include file="allCss.jsp" %>

<style>
/* ===== BASE ===== */
body {
    font-family: "Segoe UI", Roboto, Arial;
    background-color: #f5f6fa;
}

/* ===== SIDEBAR ===== */
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

/* ===== MAIN ===== */
.main {
    margin-left: 240px;
    padding: 30px;
}

/* ===== KPI CARDS ===== */
.stat-card {
    border-radius: 18px;
    padding: 30px;
    color: white;
    box-shadow: 0 12px 28px rgba(0,0,0,0.18);
}

.stat-total {
    background: linear-gradient(135deg, #0984e3, #74b9ff);
}

.stat-open {
    background: linear-gradient(135deg, #fdcb6e, #e17055);
}

.stat-closed {
    background: linear-gradient(135deg, #00b894, #55efc4);
}

.stat-card h6 {
    font-size: 14px;
    font-weight: 600;
    opacity: 0.9;
}

.stat-card h2 {
    font-size: 38px;
    font-weight: 700;
    margin: 0;
}

/* ===== ACTION CARDS ===== */
.action-card {
    background: white;
    border-radius: 14px;
    padding: 30px;
    text-align: center;
    box-shadow: 0 10px 25px rgba(0,0,0,0.12);
    transition: 0.3s;
}

.action-card:hover {
    transform: translateY(-6px);
}

.action-card i {
    font-size: 42px;
    color: #0984e3;
}

/* ===== TABLE CARD ===== */
.table-card {
    background: white;
    border-radius: 14px;
    padding: 25px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.12);
}
</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h4>Admin Panel</h4>
    <a href="home.jsp"><i class="fas fa-home"></i> Dashboard</a>
    <a href="addComplaint.jsp"><i class="fas fa-plus-circle"></i> Add Complaint</a>
     <a href="pendingComplaints.jsp" >
        <i class="fas fa-hourglass-half"></i> Pending Complaints
    </a>
    <a href="viewComplaints.jsp"><i class="fas fa-list"></i> View All Complaints</a>
    <a href="changePassword.jsp"><i class="fas fa-key"></i> Change Password</a>
    <a href="../logout">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>
</div>

<!-- ===== MAIN ===== -->
<div class="main">

    <!-- HEADER -->
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <div>
            <h3>Welcome, <%= user.getUsername() %></h3>
            <p class="text-muted mb-0">
                <%= category %> Complaint Management Dashboard
            </p>
        </div>
        <button class="btn btn-sm btn-outline-dark" onclick="toggleDarkMode()">
    <i class="fas fa-moon"></i> Dark Mode
</button>
    </div>

    <!-- ===== KPI CARDS ===== -->
    <div class="row mb-4">

        <div class="col-md-4">
            <div class="stat-card stat-total">
                <h6>Total <%= category %> Complaints</h6>
                <h2><%= totalCount %></h2>
            </div>
        </div>

        <div class="col-md-4">
            <a href="viewComplaints.jsp?filter=open" style="text-decoration:none;">
                <div class="stat-card stat-open">
                    <h6>Open <%= category %> Complaints</h6>
                    <h2><%= openCount %></h2>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <div class="stat-card stat-closed">
                <h6>Closed <%= category %> Complaints</h6>
                <h2><%= closedCount %></h2>
            </div>
        </div>

    </div>

    <!-- ===== ACTIONS ===== -->
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
            <a href="../logout">
                <div class="action-card">
                    <i class="fas fa-sign-out-alt"></i>
                    <h5>Logout</h5>
                    <p>Exit admin portal</p>
                </div>
            </a>
        </div>

    </div>

</div>

</body>
</html>
