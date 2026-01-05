<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.entity.User" %>
<%@ page import="com.DAO.ComplaintDAOImpl" %>
<%@ page import="com.DB.DBConnect" %>

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

    ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
    List<User> userList = dao.getAllUsers();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin | User Management</title>

<%@ include file="allCss.jsp" %>

<style>
body {
    background-color: #f4f6f9;
    font-family: "Segoe UI", Roboto, Arial;
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

.sidebar a.active,
.sidebar a:hover {
    background: #485460;
    color: #fff;
}

/* Main */
.main {
    margin-left: 240px;
    padding: 30px;
}

/* Cards */
.page-header,
.table-card {
    background: #fff;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 6px 15px rgba(0,0,0,0.08);
    margin-bottom: 20px;
}

/* Table */
.table th, .table td {
    text-align: center;
    vertical-align: middle;
    font-size: 13px;
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

    <a href="manageUsers.jsp" class="active">
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

    <a href="changePassword.jsp">
        <i class="fas fa-key mr-2"></i> Change Password
    </a>

    <a href="../logout">
        <i class="fas fa-sign-out-alt mr-2"></i> Logout
    </a>

</div>

<!-- ===== MAIN ===== -->
<div class="main">

    <!-- HEADER -->
    <div class="page-header">
        <h4>User Management</h4>
        <p class="text-muted mb-0">
            Logged in as <strong><%= user.getUsername() %> (ADMIN)</strong>
        </p>
    </div>


<!-- ===== REGISTER NEW USER ===== -->
<div class="table-card">
    <h5 class="mb-3">
        <i class="fas fa-user-plus"></i> Register New User
    </h5>

    <form action="../addUser" method="post">

        <div class="row">

            <div class="col-md-3">
                <label>Emp No</label>
                <input type="number" name="empn" class="form-control" required>
            </div>

            <div class="col-md-3">
                <label>Full Name</label>
                <input type="text" name="username" class="form-control" required>
            </div>

            <div class="col-md-3">
                <label>Quarter No</label>
                <input type="text" name="qtrno" class="form-control">
            </div>

            <div class="col-md-3">
                <label>Role</label>
                <select name="role" class="form-control" required>
                    <option value="">Select</option>
                    <option value="NU">Normal User</option>
                    <option value="AC">AC (Civil)</option>
                    <option value="AE">AE (Electrical)</option>
                </select>
            </div>

        </div>

        <div class="row mt-3">

            <div class="col-md-4">
                <label>Email</label>
                <input type="email" name="email" class="form-control">
            </div>

            <div class="col-md-4">
                <label>Phone</label>
                <input type="text" name="phone" class="form-control" required>
            </div>

            <div class="col-md-2">
                <label>Status</label>
                <select name="status" class="form-control" required>
                    <option value="A">Active</option>
                    <option value="I">Inactive</option>
                </select>
            </div>

            <div class="col-md-2">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>

        </div>

        <div class="text-right mt-3">
            <button class="btn btn-success">
                <i class="fas fa-save"></i> Create User
            </button>
        </div>

    </form>
</div>



    <!-- ===== SEARCH BAR (JS ONLY) ===== -->
    <div class="mb-3 text-center">
        <input type="text"
               id="userSearch"
               class="form-control"
               style="max-width: 360px; margin:auto;"
               placeholder="Search by Emp No / Name / Mobile"
               onkeyup="filterUsers()">
    </div>

    <!-- ===== USER TABLE ===== -->
    <div class="table-card">
        <h5 class="mb-3">All Users</h5>

        <div class="table-responsive">
            <table class="table table-bordered table-hover" id="userTable">

                <thead class="bg-primary text-white">
                <tr>
                    <th>Emp No</th>
                    <th>Name</th>
                    <th>Quarter</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Status</th>
                    <th>Role</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                </thead>

                <tbody>
                <%
                    if (userList != null && !userList.isEmpty()) {
                        for (User u : userList) {
                %>
                <tr>
                    <td><%= u.getEmpn() %></td>
                    <td><%= u.getUsername() %></td>
                    <td><%= u.getQtrno() %></td>
                    <td><%= u.getEmail() %></td>
                    <td><%= u.getPhone() %></td>
                    <td><%= "A".equals(u.getStatus()) ? "Active" : "Inactive" %></td>
                    <td><%= u.getRole() %></td>

                    <td>
                        <a href="editUser.jsp?empn=<%= u.getEmpn() %>"
                           class="btn btn-sm btn-primary">
                            <i class="fas fa-edit"></i>
                        </a>
                    </td>

                    <td>
                        <a href="../deleteUser?empn=<%= u.getEmpn() %>"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Delete this user?')">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="9" class="text-center text-muted">
                        No users found
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

<!-- ===== JAVASCRIPT SEARCH ===== -->
<script>
function filterUsers() {
    const input = document.getElementById("userSearch");
    const filter = input.value.toLowerCase();
    const table = document.getElementById("userTable");
    const rows = table.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) {
        let showRow = false;
        const cells = rows[i].getElementsByTagName("td");

        for (let j = 0; j < cells.length - 2; j++) {
            if (cells[j]) {
                const text = cells[j].innerText.toLowerCase();
                if (text.includes(filter)) {
                    showRow = true;
                    break;
                }
            }
        }
        rows[i].style.display = showRow ? "" : "none";
    }
}
</script>

</body>
</html>
