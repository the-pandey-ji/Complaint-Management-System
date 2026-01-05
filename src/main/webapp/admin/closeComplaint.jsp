<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.entity.User" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.DAO.ComplaintDAOImpl" %>
<%@ page import="com.entity.Complaintdtls" %>

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

    int id = Integer.parseInt(request.getParameter("id"));
    ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
    Complaintdtls complaint = dao.getComplaintById(id);

    if (complaint == null) {
        out.println("<h3 class='text-danger text-center'>Complaint not found</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin | Close Complaint</title>

<%@ include file="allCss.jsp" %>

<style>
/* ===== BASE ===== */
body {
    font-family: "Segoe UI", Roboto, Arial;
    background-color: #f4f6f9;
}

/* ===== SIDEBAR ===== */
.sidebar {
    height: 100vh;
    background: #1e272e;
    color: #fff;
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

.sidebar a:hover,
.sidebar a.active {
    background: #485460;
    color: #fff;
}

/* ===== MAIN ===== */
.admin-main {
    margin-left: 240px;
    padding: 25px;
}

/* ===== HEADER ===== */
.admin-header {
    background: #fff;
    padding: 20px 26px;
    border-radius: 14px;
    box-shadow: 0 6px 16px rgba(0,0,0,0.08);
    margin-bottom: 25px;
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
}

/* ===== FORM CARD ===== */
.form-wrapper {
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 12px 30px rgba(0,0,0,0.12);
    padding: 30px;
}

.section-title {
    font-size: 15px;
    font-weight: 600;
    margin-bottom: 18px;
    border-bottom: 1px solid #dee2e6;
    padding-bottom: 6px;
}

/* ===== SMALL IMAGE ===== */
.small-img {
    width: 130px;
    height: 130px;
    border-radius: 12px;
    object-fit: cover;
    border: 1px solid #ccc;
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

html.dark-mode input,
html.dark-mode textarea {
    background-color: #353b48;
    color: #f5f6fa;
    border: 1px solid #636e72;
}
</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h4>Admin Panel</h4>

    <a href="home.jsp"><i class="fas fa-home mr-2"></i> Dashboard</a>
    <a href="manageUsers.jsp"><i class="fas fa-users mr-2"></i> User Management</a>
    <a href="addComplaint.jsp"><i class="fas fa-plus-circle mr-2"></i> Add Complaint</a>
    <a href="pendingComplaints.jsp" class="active">
        <i class="fas fa-hourglass-half mr-2"></i> Pending Complaints
    </a>
    <a href="viewComplaints.jsp"><i class="fas fa-list mr-2"></i> View All Complaints</a>
    <a href="changePassword.jsp"><i class="fas fa-key mr-2"></i> Change Password</a>
    <a href="../logout"><i class="fas fa-sign-out-alt mr-2"></i> Logout</a>
</div>

<!-- ===== MAIN ===== -->
<div class="admin-main">

    <!-- HEADER -->
    <div class="admin-header">
        <div>
            <div class="admin-title">Close Complaint</div>
            <div class="admin-breadcrumb">
                Admin Panel / Complaints / Close Complaint
            </div>
        </div>

        <button class="btn btn-sm btn-dark" onclick="toggleDarkMode()">
            <i class="fas fa-moon"></i> Dark Mode
        </button>
    </div>

    <!-- FORM -->
    <div class="form-wrapper">

        <!-- MESSAGES -->
        <%
            String succMsg = (String) session.getAttribute("succMsg");
            if (succMsg != null) {
        %>
            <div class="alert alert-success text-center"><%= succMsg %></div>
        <%
            session.removeAttribute("succMsg");
            }
        %>

        <%
            String failedMsg = (String) session.getAttribute("failedMsg");
            if (failedMsg != null) {
        %>
            <div class="alert alert-danger text-center"><%= failedMsg %></div>
        <%
            session.removeAttribute("failedMsg");
            }
        %>

        <form action="../ComplaintClose" method="post">
            <input type="hidden" name="id" value="<%= complaint.getid() %>">

            <div class="row">

                <!-- LEFT: SUMMARY -->
                <div class="col-md-6">
                    <div class="section-title">Complaint Summary</div>

                    <div class="text-center mb-3">
                        <img src="../images/<%= complaint.getImage() %>"
                             class="small-img">
                    </div>

                    <div class="form-group">
                        <label>Title</label>
                        <input class="form-control" readonly
                               value="<%= complaint.getTitle() %>">
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea class="form-control" rows="4" readonly>
<%= complaint.getDescription() %></textarea>
                    </div>

                    <div class="form-group">
                        <label>Quarter No</label>
                        <input class="form-control" readonly
                               value="<%= complaint.getQtrno() %>">
                    </div>
                </div>

                <!-- RIGHT: CLOSE ACTION -->
                <div class="col-md-6">
                    <div class="section-title">Close Complaint</div>

                    <div class="form-group">
                        <label>Complaint ID</label>
                        <input class="form-control" readonly
                               value="<%= complaint.getid() %>">
                    </div>

                    <div class="form-group">
                        <label>Current Status</label>
                        <input class="form-control" readonly
                               value="<%= complaint.getStatus() %>">
                    </div>

                    <div class="form-group">
                        <label>Action Taken</label>
                        <textarea name="actionTaken"
                                  rows="6"
                                  class="form-control"
                                  required
                                  placeholder="Describe the action taken to resolve this complaint"></textarea>
                    </div>
                </div>

            </div>

            <hr>

            <button type="submit" class="btn btn-success btn-block">
                <i class="fas fa-check-circle"></i> Close Complaint
            </button>

        </form>
    </div>

</div>

</body>
</html>
