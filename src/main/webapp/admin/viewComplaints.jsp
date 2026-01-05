<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.DAO.ComplaintDAOImpl" %>
<%@ page import="com.entity.Complaintdtls" %>
<%@ page import="com.entity.User" %>

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

    // ===== PAGINATION PARAMS =====
    int pageNo = 1;
    int recordsPerPage = 20;

    if (request.getParameter("page") != null) {
        pageNo = Integer.parseInt(request.getParameter("page"));
    }
    if (request.getParameter("size") != null) {
        recordsPerPage = Integer.parseInt(request.getParameter("size"));
    }

    int startRow = (pageNo - 1) * recordsPerPage + 1;
    int endRow   = pageNo * recordsPerPage;

    // ===== SEARCH PARAM =====
    String search = request.getParameter("search");
    if (search == null) {
        search = "";
    }

    // ===== ROLE → CATEGORY =====
    String category =
        user.getRole().equals("AC") ? "Civil" : "Electrical";

    ComplaintDAOImpl dao =
        new ComplaintDAOImpl(DBConnect.getConnection());

    List<Complaintdtls> list =
        dao.getComplaintsPaginatedSearch(
            category, search, startRow, endRow);

    int totalRecords =
        dao.getComplaintCountByCategorySearch(category, search);

    int totalPages =
        (int) Math.ceil((double) totalRecords / recordsPerPage);
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
}

/* Image zoom */
.complaint-img {
    width: 45px;
    height: 45px;
    border-radius: 6px;
    object-fit: cover;
    transition: transform 0.3s;
    cursor: zoom-in;
}
.complaint-img:hover {
    transform: scale(5.8);
    transform-origin: top left;
    position: relative;
    z-index: 999;
}

/* Status */
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
.table th, .table td {
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

    <a href="viewComplaints.jsp" class="active">
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
    <div class="page-header mb-3">
        <h4><%= category %> Complaints</h4>
        <p class="text-muted mb-0">
            Logged in as <strong><%= user.getUsername() %></strong>
        </p>
    </div>

   <!-- SEARCH + PAGE SIZE BAR -->
<form method="get" class="mb-3">

    <div class="row align-items-center">

        <!-- LEFT EMPTY (for balance) -->
        <div class="col-md-3"></div>

        <!-- CENTER SEARCH -->
        <div class="col-md-6 text-center">
            <div class="input-group justify-content-center">
                <input type="text"
                       name="search"
                       value="<%= search %>"
                       class="form-control"
                       style="max-width: 360px;"
                       placeholder="Search name / emp / qtr / phone / date">

                <div class="input-group-append">
                    <button class="btn btn-primary">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- RIGHT PAGE SIZE -->
        <div class="col-md-3 text-right">
            <div class="form-inline justify-content-end">
                <label class="mr-2 font-weight-bold">Show</label>

                <select name="size"
                        class="form-control mr-2"
                        onchange="this.form.submit()">
                    <option value="20" <%=recordsPerPage==20?"selected":""%>>20</option>
                    <option value="50" <%=recordsPerPage==50?"selected":""%>>50</option>
                    <option value="100" <%=recordsPerPage==100?"selected":""%>>100</option>
                </select>

                <span>entries</span>
            </div>
        </div>

    </div>

    <!-- Reset page to 1 on search/size change -->
    <input type="hidden" name="page" value="1">

</form>



    <!-- TABLE -->
    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-bordered table-hover">

                <thead class="bg-primary text-white">
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                   
                    <th>Title</th>
                    <th>Description</th>
                    <th>Created</th>
                    <th>Closed</th>
                    <th>Qtr</th>
                    <th>Emp No</th>
                    <th>User</th>
                    <th>Phone</th>
                    <th>Status</th>
                    <th>Action</th>
                    <th>Edit</th>
                    <th>Close</th>
                </tr>
                </thead>

                <tbody>
                <%
                    if (list != null && !list.isEmpty()) {
                        for (Complaintdtls c : list) {
                %>
                <tr>
                    <td>
                        <a class="id-link"
                           href="viewComplaint.jsp?id=<%= c.getid() %>"
                           target="_blank">
                            <%= c.getid() %>
                        </a>
                    </td>

                    <td>
                        <img src="../images/<%= c.getImage() %>"
                             class="complaint-img">
                    </td>
					
                   
                    <td>
                        <a class="id-link"
                           href="viewComplaint.jsp?id=<%= c.getid() %>"
                           target="_blank">
                            <%= c.getTitle() %>
                        </a>
                    </td>
                   
                    <td><%= c.getDescription() %></td>
                    <td><%= c.getCreatedate() %></td>
                    <td><%= c.getClosedDate() != null ? c.getClosedDate() : "-" %></td>
                    <td><%= c.getQtrno() %></td>
                    <td><%= c.getEmpn() %></td>
                    <td><%= c.getUsername() %></td>
                    <td><%= c.getPhone() %></td>

                    <td>
                        <span class="<%= c.getStatus().equalsIgnoreCase("Closed")
                                ? "status-closed"
                                : "status-open" %>">
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
                           class="btn btn-sm btn-danger
                           <%= c.getStatus().equalsIgnoreCase("Closed")
                                ? "disabled"
                                : "" %>">
                            <i class="fas fa-times-circle"></i>
                        </a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="15" class="text-center text-muted">
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

    <!-- PAGINATION -->
    <nav class="mt-4">
        <ul class="pagination justify-content-center">
        <%
            for (int i = 1; i <= totalPages; i++) {
        %>
            <li class="page-item <%= pageNo==i?"active":"" %>">
                <a class="page-link"
                   href="?page=<%= i %>&size=<%= recordsPerPage %>&search=<%= search %>">
                    <%= i %>
                </a>
            </li>
        <%
            }
        %>
        </ul>
    </nav>

</div>

</body>
</html>
