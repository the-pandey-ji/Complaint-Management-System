<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.DAO.ComplaintDAOImpl" %>
<%@ page import="com.entity.Complaintdtls" %>
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
<meta charset="UTF-8">
<title>Admin | View Complaints</title>

<%@ include file="allCss.jsp" %>

<style>
    body {
        background-color: #f4f6f9;
        font-family: "Segoe UI", Roboto, Arial;
        transition: background 0.3s, color 0.3s;
    }

    /* Dark Mode */
    body.dark-mode {
        background-color: #1e272e;
        color: #f5f6fa;
    }

    body.dark-mode .table-card,
    body.dark-mode .page-header {
        background: #2f3640;
        color: #f5f6fa;
    }

    body.dark-mode table {
        color: #f5f6fa;
    }

    /* Sidebar */
    .sidebar {
        height: 100vh;
        background: #1e272e;
        color: #fff;
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

    .sidebar a:hover,
    .sidebar a.active {
        background: #485460;
        color: #fff;
    }

    /* Main content */
    .main {
        margin-left: 240px;
        padding: 30px;
    }

    .page-header {
        background: white;
        padding: 18px 25px;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        margin-bottom: 20px;
    }

    .table-card {
        background: white;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 6px 15px rgba(0,0,0,0.08);
    }

    /* Image zoom */
    .complaint-img {
        width: 45px;
        height: 45px;
        border-radius: 6px;
        object-fit: cover;
        transition: transform 0.3s ease;
        cursor: zoom-in;
    }

    .complaint-img:hover {
        transform: scale(5.2);
        z-index: 999;
        position: relative;
    }

    /* Status badges */
    .status-open {
        background: #f1c40f;
        color: #000;
        padding: 4px 10px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: 600;
    }

    .status-closed {
        background: #2ecc71;
        color: #fff;
        padding: 4px 10px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: 600;
    }

    /* Table */
    .table thead th,
    .table tbody td {
        text-align: center;
        vertical-align: middle;
        font-size: 13px;
    }

    /* ID link */
    .id-link {
        font-weight: 600;
        color: #0984e3;
        text-decoration: none;
    }

    .id-link:hover {
        text-decoration: underline;
    }
</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h4 class="text-center mb-4">Admin Panel</h4>
    <a href="home.jsp"><i class="fas fa-home"></i> Dashboard</a>
    <a href="addComplaint.jsp"><i class="fas fa-plus-circle"></i> Add Complaint</a>
    <a href="viewComplaints.jsp" class="active"><i class="fas fa-list"></i> View Complaints</a>
    <a href="changePassword.jsp"><i class="fas fa-key"></i> Change Password</a>
    <a href="../logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN -->
<div class="main">

    <!-- Header -->
    <div class="page-header d-flex justify-content-between align-items-center">
        <div>
            <h4>View Complaints</h4>
            <p class="text-muted mb-0">
                Logged in as <strong><%= user.getUsername() %></strong> |
                Role: <strong><%= user.getRole() %></strong>
            </p>
        </div>

        <!-- Dark mode toggle -->
        <button class="btn btn-sm btn-dark" onclick="toggleDarkMode()">
            <i class="fas fa-moon"></i> Dark Mode
        </button>
    </div>

    <!-- Table -->
    <div class="table-card">

        <h5 class="mb-3">All Complaints</h5>

        <div class="table-responsive">
            <table class="table table-bordered table-hover">

                <thead class="bg-primary text-white">
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Category</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Date</th>
                        <th>Qtr</th>
                        <th>Emp No</th>
                        <th>User</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <th>Action Taken</th>
                        <th>Edit</th>
                        <th>Close</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
                    List<Complaintdtls> list = null;

                    if (user.getRole().equals("AC")) {
                        list = dao.getCivilComplaints();
                    } else if (user.getRole().equals("AE")) {
                        list = dao.getElectricalComplaints();
                    }

                    if (list != null && !list.isEmpty()) {
                        for (Complaintdtls c : list) {
                %>
                    <tr>
                        <!-- ID opens in new tab -->
                        <td>
                            <a class="id-link"
                               href="viewComplaint.jsp?id=<%= c.getid() %>"
                               target="_blank"
                               title="Open complaint in new tab">
                               <%= c.getid() %>
                            </a>
                        </td>

                        <td>
                            <img src="../images/<%= c.getImage() %>" class="complaint-img">
                        </td>

                        <td><%= c.getCategory() %></td>
                        <td><%= c.getTitle() %></td>
                        <td><%= c.getDescription() %></td>
                        <td><%= c.getCreatedate() %></td>
                        <td><%= c.getQtrno() %></td>
                        <td><%= c.getEmpn() %></td>
                        <td><%= c.getUsername() %></td>
                        <td><%= c.getPhone() %></td>

                        <td>
                            <span class="<%= c.getStatus().equalsIgnoreCase("Closed") ? "status-closed" : "status-open" %>">
                                <%= c.getStatus() %>
                            </span>
                        </td>

                        <td><%= c.getAction() %></td>

                        <td>
                            <a href="editComplaint.jsp?id=<%= c.getid() %>"
                               class="btn btn-sm btn-primary">
                                <i class="fas fa-edit"></i>
                            </a>
                        </td>

                        <td>
                            <a href="closeComplaint.jsp?id=<%= c.getid() %>"
                               class="btn btn-sm btn-danger <%= c.getStatus().equalsIgnoreCase("Closed") ? "disabled" : "" %>">
                                <i class="fas fa-times-circle"></i>
                            </a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="14" class="text-center text-muted">
                            No complaints found
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>

            </table>
        </div>
    </div>
</div>

<script>
function toggleDarkMode() {
    document.body.classList.toggle("dark-mode");
}
</script>

</body>
</html>
