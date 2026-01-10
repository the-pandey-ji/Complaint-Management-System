<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.entity.User" %>
<%@ page import="com.DB.DBConnect" %>

<%
    // ===== SESSION CHECK =====
    User user = (User) session.getAttribute("Userobj");
    if (user == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    // ===== DATE RANGE PARAMS =====
    String fromDateStr = request.getParameter("fromDate");
    String toDateStr = request.getParameter("toDate");

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar cal = Calendar.getInstance();
    if (fromDateStr == null || fromDateStr.isEmpty()) {
        fromDateStr = sdf.format(cal.getTime());
    }
    if (toDateStr == null || toDateStr.isEmpty()) {
        toDateStr = sdf.format(cal.getTime());
    }

    java.sql.Timestamp fromTimestamp = java.sql.Timestamp.valueOf(fromDateStr + " 00:00:00");
    java.sql.Timestamp toTimestamp = java.sql.Timestamp.valueOf(toDateStr + " 23:59:59");

    String category = user.getRole().equals("AC") ? "Civil" : "Electrical";

    // ===== STATUS PARAM (Open/Closed) =====
    String statusFilter = request.getParameter("status");
    if (statusFilter == null || statusFilter.isEmpty()) {
        statusFilter = "Active"; // default Open complaints
    }

    // ===== FETCH COMPLAINTS ONLY IF BUTTON CLICKED =====
    List<Map<String, Object>> complaints = new ArrayList<>();
    boolean generateReport = request.getParameter("fromDate") != null || request.getParameter("toDate") != null;

    if (generateReport) {
        try {
            Connection con = DBConnect.getConnection();

            String sql = "SELECT ID, TITLE, DESCRIPTION, COMPDATETIME, USERNAME, QTRNO, EMPN, COMPLAINT_TYPE, STATUS " +
                         "FROM COMPLAINTDTLS WHERE CATEGORY = ? AND STATUS = ? AND COMPDATETIME BETWEEN ? AND ? " +
                         "ORDER BY COMPDATETIME DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, category);
            ps.setString(2, statusFilter);
            ps.setTimestamp(3, fromTimestamp);
            ps.setTimestamp(4, toTimestamp);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getInt("ID"));
                row.put("title", rs.getString("TITLE"));
                row.put("description", rs.getString("DESCRIPTION"));
                row.put("created", rs.getTimestamp("COMPDATETIME"));
                row.put("user", rs.getString("USERNAME"));
                row.put("qtr", rs.getString("QTRNO"));
                row.put("empn", rs.getString("EMPN"));
                row.put("type", rs.getString("COMPLAINT_TYPE"));
                row.put("status", rs.getString("STATUS"));
                complaints.add(row);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= category %> Complaints Report</title>

<!-- INCLUDE CSS FILES -->
<%@ include file="allCss.jsp" %>

<style>
/* ===== PAGE LAYOUT ===== */
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f1f1f1;
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

/* ===== Print Specific ===== */
@media print {
    .sidebar, .page-header, .filters, .print-btn { display: none !important; }


.main {
        margin-left: 0 !important;  /* remove sidebar space */
        padding: 0 !important;      /* optional: reduce padding for print */
    }
}

/* Table Styling */
table { width: 100%; border-collapse: collapse; margin-top: 20px; background: #fff; }
th, td { border: 1px solid #333; padding: 8px; text-align: left; font-size: 14px; }
th { background-color: #f4f4f4; }
.print-btn { display: block; margin: 10px auto; padding: 8px 16px; }
.filters { margin-bottom: 15px; }
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

    <a href="pendingComplaints.jsp" >
        <i class="fas fa-hourglass-half mr-2"></i> Pending Complaints
    </a>

    <a href="viewComplaints.jsp">
        <i class="fas fa-list mr-2"></i> View All Complaints
    </a>
    <a href="complaintReport.jsp" class="active"><i class="fas fa-file-alt mr-2"></i> Complaint Report</a>

    <a href="changePassword.jsp">
        <i class="fas fa-key mr-2"></i> Change Password
    </a>

    <a href="../logout">
        <i class="fas fa-sign-out-alt mr-2"></i> Logout
    </a>

</div>
<!-- ===== MAIN CONTENT ===== -->
<div class="main">

    <!-- HEADER -->
    <div class="page-header">
        <h4><%= category %> Complaints Report</h4>
        <p class="text-muted">Logged in as <strong><%= user.getUsername() %></strong></p>
        
    </div>
<br>
    <!-- ===== FILTER FORM ===== -->
    <form method="get" class="filters" style="text-align:center; margin-bottom:15px;">
        From: <input type="date" name="fromDate" value="<%= fromDateStr %>">
        To: <input type="date" name="toDate" value="<%= toDateStr %>">
        Status: 
        <select name="status">
            <option value="Active" <%= "Active".equals(statusFilter) ? "selected" : "" %>>Open</option>
            <option value="Closed" <%= "Closed".equals(statusFilter) ? "selected" : "" %>>Closed</option>
        </select>
        <button type="submit">Generate Report</button>
    </form>

    <% if (generateReport) { %>
        <button class="print-btn" onclick="window.print()">Print Report</button>

        <table>
        <h4 style="text-align:center; margin-bottom:15px;"><%= category %> Complaints Report</h4>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Created On</th>
                    <th>User</th>
                    <th>Qtr</th>
                    <th>Emp No</th>
                    <th>Type</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (complaints.isEmpty()) {
                %>
                    <tr>
                        <td colspan="9" style="text-align:center; color:#888;">No complaints found for selected filters</td>
                    </tr>
                <%
                    } else {
                        for (Map<String, Object> c : complaints) {
                %>
                    <tr>
                        <td><%= c.get("id") %></td>
                        <td><%= c.get("title") %></td>
                        <td><%= c.get("description") %></td>
                        <td><%= sdf.format(c.get("created")) %></td>
                        <td><%= c.get("user") %></td>
                        <td><%= c.get("qtr") %></td>
                        <td><%= c.get("empn") %></td>
                        <td><%= c.get("type") %></td>
                        <td><%= c.get("status") %></td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    <% } %>

</div>
</body>
</html>
