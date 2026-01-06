<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.ComplaintDAOImpl"%>
<%@page import="com.entity.Complaintdtls"%>
<%@ page import="com.entity.User" %>

<%
    // SESSION CHECK
    User user = (User) session.getAttribute("Userobj");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());

    // USER KPIs
    int totalCount = dao.getTotalComplaintCountByUser(user.getEmpn());
    int openCount  = dao.getOpenComplaintCountByUser(user.getEmpn());
    int closedCount = dao.getClosedComplaintCountByUser(user.getEmpn());
  

    List<Complaintdtls> list = dao.getActiveComplaintsOfUser(user.getEmpn());
    int[] monthlyCounts = dao.getMonthlyComplaintCountByUser(user.getEmpn());

%>

<!DOCTYPE html>
<html>
<head>
<title>User Dashboard</title>

<%@include file="/all_component/allCss.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
a { text-decoration:none; color:black; }

/* KPI CARDS */
.kpi-card{
  padding:28px;
  border-radius:16px;
  color:#fff;
  box-shadow:0 8px 20px rgba(0,0,0,.15);
  position:relative;
  overflow:hidden;
  min-height:140px;
}
.kpi-card::after{
  content:"";
  position:absolute;
  right:-30px;
  top:-30px;
  width:90px;
  height:90px;
  background:rgba(255,255,255,0.15);
  border-radius:50%;
}
.kpi-title{ font-size:15px; opacity:.9; }
.kpi-value{ font-size:38px; font-weight:700; margin-top:5px; }

.bg-blue{ background:linear-gradient(135deg,#1e90ff,#0066cc); }
.bg-orange{ background:linear-gradient(135deg,#ff9f43,#ff6f00); }
.bg-green{ background:linear-gradient(135deg,#2ecc71,#27ae60); }
.bg-purple{ background:linear-gradient(135deg,#9b59b6,#6c3483); }

/* STATUS BADGES */
.badge-open{ background:#ff9f43; }
.badge-closed{ background:#2ecc71; }

/* CHART CARD */
.chart-card{
  background:#fff;
  border-radius:16px;
  padding:22px;
  box-shadow:0 6px 16px rgba(0,0,0,.1);
}
</style>
</head>

<body>

<%@include file="/all_component/navbar.jsp" %>

<!-- HEADER -->
<div class="container mt-4">
  <div class="d-flex justify-content-between align-items-center">
    <div>
      <h4 class="mb-1">User Dashboard</h4>
      <small class="text-muted">
        Welcome back, <b><%= user.getUsername() %></b>
      </small>
    </div>
    <span class="badge bg-secondary p-2">User</span>
  </div>
</div>

<!-- KPI ROW -->
<div class="container mt-4">
  <div class="row g-4">

    <div class="col-md-3">
      <div class="kpi-card bg-blue">
        <div class="kpi-title">Total Complaints Raised</div>
        <div class="kpi-value"><%= totalCount %></div>
      </div>
    </div>

    <div class="col-md-3">
      <div class="kpi-card bg-orange">
        <div class="kpi-title">Currently Open</div>
        <div class="kpi-value"><%= openCount %></div>
      </div>
    </div>

    <div class="col-md-3">
      <div class="kpi-card bg-green">
        <div class="kpi-title">Resolved</div>
        <div class="kpi-value"><%= closedCount %></div>
      </div>
    </div>

    
  </div>
</div>

<!-- ACTIVE COMPLAINTS -->
<div class="container mt-5 mb-2">
  <h5 class="mb-0">Active Complaints</h5>
  <small class="text-muted">
    Showing all currently open complaints raised by you
  </small>
</div>

<div class="container-fluid mt-3">
<table class="table table-striped table-hover align-middle">
<thead class="bg-primary text-white">
<tr>
<th>ID</th>
<th>Image</th>
<th>Category</th>
<th>Title</th>
<th>Description</th>
<th>Date</th>
<th>Qtr No.</th>
<th>Status</th>
<th>Action Taken</th>
</tr>
</thead>

<tbody>
<%
if (list != null && !list.isEmpty()) {
  for (Complaintdtls c : list) {
%>
<tr>
<td><%= c.getid() %></td>
<td><img src="images/<%= c.getImage() %>" style="width:50px;height:50px;"></td>
<td><%= c.getCategory() %></td>
<td><%= c.getTitle() %></td>
<td><%= c.getDescription() %></td>
<td><%= c.getCreatedate() %></td>
<td><%= c.getQtrno() %></td>
<td>
<span class="badge <%= c.getStatus().equals("Active") ? "badge-open" : "badge-closed" %> px-3 py-2">
<%= c.getStatus().equals("Active") ? "Open" : "Closed" %>
</span>
</td>
<td><%= c.getAction() == null ? "-" : c.getAction() %></td>
</tr>
<%
  }
} else {
%>
<tr>
<td colspan="9" class="text-center text-muted">
You currently have no active complaints 🎉
</td>
</tr>
<%
}
%>
</tbody>
</table>
</div>





<div class="mt-5">
<%@include file="all_component/footer.jsp"%>
</div>



</body>
</html>
