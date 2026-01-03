<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.entity.User" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.DAO.ComplaintDAOImpl" %>
<%@ page import="com.entity.Complaintdtls" %>

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

    int id = Integer.parseInt(request.getParameter("id"));
    ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
    Complaintdtls c = dao.getComplaintById(id);

    if (c == null) {
        out.println("<h3>Complaint not found</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Complaint #<%= c.getid() %></title>

<%@ include file="allCss.jsp" %>

<style>
/* ===== LIGHT MODE (BASE) ===== */

body {
    background-color: #f4f6f9;
    font-family: "Segoe UI", Roboto, Arial;
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

/* Main */
.main {
    margin-left: 240px;
    padding: 20px;
}

/* Header */
.page-header {
    background: white;
    padding: 15px 20px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    margin-bottom: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* Image section */
.image-card {
    background: #000;
    border-radius: 14px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.25);
    height: 70vh;
}

.image-card img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    cursor: zoom-in;
}

/* Info panel */
.info-card {
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 6px 15px rgba(0,0,0,0.08);
}

.label {
    font-size: 12px;
    color: #6c757d;
    font-weight: 600;
    text-transform: uppercase;
}

.value {
    font-size: 15px;
    font-weight: 600;
    margin-bottom: 12px;
}

/* Status badge */
.status-open {
    background: #f1c40f;
    padding: 5px 12px;
    border-radius: 20px;
    font-weight: 600;
    color: #000;
}

.status-closed {
    background: #2ecc71;
    padding: 5px 12px;
    border-radius: 20px;
    color: white;
    font-weight: 600;
}

/* ===== DARK MODE (GLOBAL) ===== */

html.dark-mode body {
    background-color: #1e272e;
    color: #f5f6fa;
}

html.dark-mode .page-header,
html.dark-mode .info-card {
    background-color: #2f3640;
    color: #f5f6fa;
}

html.dark-mode .label {
    color: #b2bec3;
}
</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h5 class="text-center mb-4">Admin Panel</h5>
    <a href="home.jsp"><i class="fas fa-home"></i> Dashboard</a>
    <a href="viewComplaints.jsp"><i class="fas fa-list"></i> Back to Complaints</a>
    <a href="../logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN -->
<div class="main">

    <!-- Header -->
    <div class="page-header">
        <strong>Complaint #<%= c.getid() %></strong>
        <button class="btn btn-sm btn-dark" onclick="toggleDarkMode()">
            <i class="fas fa-moon"></i> Dark Mode
        </button>
    </div>

    <div class="row">

        <!-- IMAGE -->
        <div class="col-md-8 mb-3">
            <div class="image-card">
                <img src="../images/<%= c.getImage() %>" alt="Complaint Image">
            </div>
        </div>

        <!-- DETAILS -->
        <div class="col-md-4">
            <div class="info-card">

                <div class="label">Category</div>
                <div class="value"><%= c.getCategory() %></div>

                <div class="label">Title</div>
                <div class="value"><%= c.getTitle() %></div>

                <div class="label">Description</div>
                <div class="value"><%= c.getDescription() %></div>

                <div class="label">Quarter No</div>
                <div class="value"><%= c.getQtrno() %></div>

                <div class="label">User</div>
                <div class="value"><%= c.getUsername() %> (<%= c.getPhone() %>)</div>

                <div class="label">Status</div>
                <div class="value">
                    <span class="<%= c.getStatus().equalsIgnoreCase("Closed") ? "status-closed" : "status-open" %>">
                        <%= c.getStatus() %>
                    </span>
                </div>

                <div class="label">Action Taken</div>
                <div class="value"><%= c.getAction() %></div>

            </div>
        </div>

    </div>
</div>

</body>
</html>
