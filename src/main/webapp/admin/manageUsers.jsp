<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.entity.User" %>
<%@ page import="com.DB.DBConnect" %>

<%
/* ================= SESSION & ROLE CHECK ================= */
User user = (User) session.getAttribute("Userobj");

if (user == null) {
    response.sendRedirect("../index.jsp");
    return;
}
if (!user.getRole().equals("AC") && !user.getRole().equals("AE")) {
    response.sendRedirect("../home.jsp");
    return;
}

/* ================= DB ================= */
Connection con = DBConnect.getConnection();
String action = request.getParameter("action");

/* ================= REGISTER ================= */
if ("register".equals(action)) {
    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO USERMASTER " +
        "(EMPN, USERNAME, QTRNO, EMAIL, PHONE, PASSWORD, USERCREATIONDATE, STATUS, ROLE) " +
        "VALUES (?, ?, ?, ?, ?, ?, SYSDATE, ?, ?)"
    );
    ps.setLong(1, Long.parseLong(request.getParameter("empn")));
    ps.setString(2, request.getParameter("username"));
    ps.setString(3, request.getParameter("qtrno"));
    ps.setString(4, request.getParameter("email"));
    ps.setString(5, request.getParameter("phone"));
    ps.setString(6, request.getParameter("password"));
    ps.setString(7, request.getParameter("status"));
    ps.setString(8, request.getParameter("role"));
    ps.executeUpdate();

    response.sendRedirect("manageUsers.jsp");
    return;
}

/* ================= UPDATE ================= */
if ("update".equals(action)) {
    PreparedStatement ps = con.prepareStatement(
        "UPDATE USERMASTER SET USERNAME=?, QTRNO=?, EMAIL=?, PHONE=?, STATUS=?, ROLE=? WHERE EMPN=?"
    );
    ps.setString(1, request.getParameter("username"));
    ps.setString(2, request.getParameter("qtrno"));
    ps.setString(3, request.getParameter("email"));
    ps.setString(4, request.getParameter("phone"));
    ps.setString(5, request.getParameter("status"));
    ps.setString(6, request.getParameter("role"));
    ps.setLong(7, Long.parseLong(request.getParameter("empn")));
    ps.executeUpdate();

    response.sendRedirect("manageUsers.jsp");
    return;
}

/* ================= SOFT DELETE ================= */
if ("delete".equals(action)) {
    PreparedStatement ps = con.prepareStatement(
        "UPDATE USERMASTER SET STATUS='D' WHERE EMPN=?"
    );
    ps.setLong(1, Long.parseLong(request.getParameter("empn")));
    ps.executeUpdate();

    response.sendRedirect("manageUsers.jsp");
    return;
}

/* ================= FETCH USERS ================= */
PreparedStatement psUsers =
    con.prepareStatement("SELECT * FROM USERMASTER WHERE STATUS <> 'D' ORDER BY EMPN");
ResultSet rs = psUsers.executeQuery();

String editEmpn = request.getParameter("editEmpn");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin | User Management</title>
<%@ include file="allCss.jsp" %>

<style>
body { background:#f4f6f9; font-family:"Segoe UI",Roboto,Arial; }
.sidebar {
    height:100vh; background:#1e272e; color:#fff;
    position:fixed; width:240px; padding-top:30px;
}
.sidebar a {
    color:#dcdde1; display:block; padding:12px 25px; text-decoration:none;
}
.sidebar a.active,.sidebar a:hover { background:#485460; color:#fff; }
.main { margin-left:240px; padding:30px; }
.page-header,.table-card {
    background:#fff; border-radius:12px; padding:20px;
    box-shadow:0 6px 15px rgba(0,0,0,.08); margin-bottom:20px;
}
.table th,.table td {
    text-align:center; vertical-align:middle; font-size:13px;
}
</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">

    <h4 class="text-center mb-4">Admin Panel</h4>

    <a href="home.jsp">
        <i class="fas fa-home mr-2"></i> Dashboard
    </a>

    <a href="manageUsers.jsp">
        <i class="fas fa-users mr-2"></i> User Management
    </a>

    <a href="addComplaint.jsp" >
        <i class="fas fa-plus-circle mr-2"></i> Add Complaint
    </a>

    <a href="pendingComplaints.jsp">
        <i class="fas fa-hourglass-half mr-2"></i> Pending Complaints
    </a>

    <a href="viewComplaints.jsp">
        <i class="fas fa-list mr-2"></i> View All Complaints
    </a>
<a href="complaintReport.jsp" ><i class="fas fa-file-alt mr-2"></i> Complaint Report</a>
    <a href="changePassword.jsp">
        <i class="fas fa-key mr-2"></i> Change Password
    </a>

    <a href="../logout">
        <i class="fas fa-sign-out-alt mr-2"></i> Logout
    </a>

</div>

<div class="main">

<!-- ===== HEADER ===== -->
<div class="page-header">
    <h4>User Management</h4>
    <p class="text-muted mb-0">
        Logged in as <strong><%= user.getUsername() %></strong>
    </p>
</div>

<!-- ===== REGISTER USER ===== -->
<div class="table-card">
<h5>Register New User</h5>

<form method="post">
<input type="hidden" name="action" value="register">

<div class="row">
    <div class="col-md-3"><input name="empn" class="form-control" placeholder="Emp No" required></div>
    <div class="col-md-3"><input name="username" class="form-control" placeholder="Name" required></div>
    <div class="col-md-3"><input name="qtrno" class="form-control" placeholder="Quarter"></div>
    <div class="col-md-3">
        <select name="role" class="form-control" required>
            <option value="">Role</option>
            <option value="NU">User</option>
            <option value="AC">AC</option>
            <option value="AE">AE</option>
        </select>
    </div>
</div>

<div class="row mt-2">
    <div class="col-md-4"><input name="email" class="form-control" placeholder="Email"></div>
    <div class="col-md-4"><input name="phone" class="form-control" placeholder="Phone" required></div>
    <div class="col-md-2">
        <select name="status" class="form-control">
            <option value="A">Active</option>
            <option value="I">Inactive</option>
        </select>
    </div>
    <div class="col-md-2"><input name="password" class="form-control" placeholder="Password" required></div>
</div>

<div class="text-right mt-3">
    <button class="btn btn-success">Create User</button>
</div>
</form>
</div>

<!-- ===== SEARCH ===== -->
<div class="mb-3 text-center">
<input id="userSearch" class="form-control"
       style="max-width:360px;margin:auto"
       placeholder="Search user"
       onkeyup="filterUsers()">
</div>

<!-- ===== USER TABLE ===== -->
<div class="table-card">
<table class="table table-bordered" id="userTable">
<thead class="bg-primary text-white">
<tr>
<th>Emp</th><th>Name</th><th>Qtr</th><th>Email</th>
<th>Phone</th><th>Status</th><th>Role</th><th>Edit</th><th>Delete</th>
</tr>
</thead>
<tbody>

<%
while (rs.next()) {
boolean edit = editEmpn != null && editEmpn.equals(rs.getString("EMPN"));
%>

<tr>
<% if (edit) { %>
<form method="post">
<input type="hidden" name="action" value="update">
<input type="hidden" name="empn" value="<%=rs.getString("EMPN")%>">
<% } %>

<td><%=rs.getString("EMPN")%></td>

<td>
<% if (edit) { %>
<input name="username" value="<%=rs.getString("USERNAME")%>" class="form-control">
<% } else { %><%=rs.getString("USERNAME")%><% } %>
</td>

<td>
<% if (edit) { %>
<input name="qtrno" value="<%=rs.getString("QTRNO")%>" class="form-control">
<% } else { %><%=rs.getString("QTRNO")%><% } %>
</td>

<td>
<% if (edit) { %>
<input name="email" value="<%=rs.getString("EMAIL")%>" class="form-control">
<% } else { %><%=rs.getString("EMAIL")%><% } %>
</td>

<td>
<% if (edit) { %>
<input name="phone" value="<%=rs.getString("PHONE")%>" class="form-control">
<% } else { %><%=rs.getString("PHONE")%><% } %>
</td>

<td>
<% if (edit) { %>
<select name="status" class="form-control">
<option value="A">Active</option>
<option value="I">Inactive</option>
</select>
<% } else { %><%=rs.getString("STATUS")%><% } %>
</td>

<td>
<% if (edit) { %>
<select name="role" class="form-control">
<option value="NU">NU</option>
<option value="AC">AC</option>
<option value="AE">AE</option>
</select>
<% } else { %><%=rs.getString("ROLE")%><% } %>
</td>

<td>
<% if (edit) { %>
<button class="btn btn-sm btn-success">Save</button>
</form>
<% } else { %>
<a href="manageUsers.jsp?editEmpn=<%=rs.getString("EMPN")%>"
   class="btn btn-sm btn-primary">Edit</a>
<% } %>
</td>

<td>
<a href="manageUsers.jsp?action=delete&empn=<%=rs.getString("EMPN")%>"
   onclick="return confirm('Deactivate user?')"
   class="btn btn-sm btn-danger">Delete</a>
</td>

</tr>

<% } %>

</tbody>
</table>
</div>

</div>

<script>
function filterUsers() {
  let f=document.getElementById("userSearch").value.toLowerCase();
  document.querySelectorAll("#userTable tbody tr").forEach(r=>{
    r.style.display=r.innerText.toLowerCase().includes(f)?"":"none";
  });
}
</script>

</body>
</html>
