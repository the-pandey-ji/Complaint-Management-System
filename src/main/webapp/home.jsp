<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.ComplaintDAOImpl"%>
<%@page import="com.entity.Complaintdtls"%>
<%@ page import="com.entity.User" %>

<%
    User user = (User) session.getAttribute("Userobj");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());

    int totalCount  = dao.getTotalComplaintCountByUser(user.getEmpn());
    int openCount   = dao.getOpenComplaintCountByUser(user.getEmpn());
    int closedCount = dao.getClosedComplaintCountByUser(user.getEmpn());

    List<Complaintdtls> list = dao.getActiveComplaintsOfUser(user.getEmpn());
%>

<!DOCTYPE html>
<html>
<head>
<title>User Dashboard</title>

<%@include file="/all_component/allCss.jsp" %>

<style>
a{text-decoration:none}

/* KPI CARDS */
.kpi-card{
  padding:32px;
  border-radius:18px;
  color:#fff;
  box-shadow:0 10px 25px rgba(0,0,0,.18);
  position:relative;
  overflow:hidden;
  min-height:160px;
}
.kpi-card::after{
  content:"";
  position:absolute;
  right:-35px;
  top:-35px;
  width:100px;
  height:100px;
  background:rgba(255,255,255,.18);
  border-radius:50%;
}
.kpi-title{font-size:16px;opacity:.95}
.kpi-value{font-size:42px;font-weight:700;margin-top:8px}

.bg-blue{background:linear-gradient(135deg,#1e90ff,#0066cc)}
.bg-orange{background:linear-gradient(135deg,#ff9f43,#ff6f00)}
.bg-green{background:linear-gradient(135deg,#2ecc71,#27ae60)}

.badge-open{background:#ff9f43}
.badge-closed{background:#2ecc71}

/* QUICK ACTIONS */
.action-card{
  background:#fff;
  border-radius:16px;
  padding:24px;
  box-shadow:0 6px 18px rgba(0,0,0,.12);
  transition:.3s;
  cursor:pointer;
}
.action-card:hover{
  transform:translateY(-4px);
  box-shadow:0 10px 25px rgba(0,0,0,.18);
}
.action-icon{font-size:32px;margin-bottom:10px}
.action-title{font-weight:600}
</style>
</head>

<body>

<%@include file="/all_component/navbar.jsp" %>
<!-- PAGE HEADER -->
<div class="container-fluid mt-5">
  <div class="d-flex flex-column align-items-center text-center">

    <h2 class="font-weight-bold mb-2 text-primary">
      User Dashboard
    </h2>

    <h5 class="text-muted">
      Welcome back,
      <span class="font-weight-bold text-dark">
        <%= user.getUsername() %>
      </span>
    </h5>

    <div class="mt-3"
         style="width:120px;height:4px;
                background:linear-gradient(90deg,#0b6b3a,#1e8f5a);
                border-radius:4px;">
    </div>

  </div>
</div>


<!-- KPI ROW -->
<div class="container-fluid mt-4">
  <div class="row g-4">

    <div class="col-md-4">
      <div class="kpi-card bg-blue">
        <div class="kpi-title">Total Complaints Raised</div>
        <div class="kpi-value"><%= totalCount %></div>
      </div>
    </div>

    <div class="col-md-4">
      <div class="kpi-card bg-orange">
        <div class="kpi-title">Open Complaints</div>
        <div class="kpi-value"><%= openCount %></div>
      </div>
    </div>

    <div class="col-md-4">
      <div class="kpi-card bg-green">
        <div class="kpi-title">Resolved Complaints</div>
        <div class="kpi-value"><%= closedCount %></div>
      </div>
    </div>

  </div>
</div>

<!-- QUICK ACTIONS -->
<div class="container-fluid mt-5">
  <h5 class="mb-3">Quick Actions</h5>

  <div class="row g-4">

    <div class="col-md-4">
      <div class="action-card text-center" onclick="location.href='addUserComplaint.jsp'">
        <div class="action-icon text-primary">
          <i class="fas fa-plus-circle"></i>
        </div>
        <div class="action-title">Raise New Complaint</div>
        <small class="text-muted">Submit a new issue</small>
      </div>
    </div>

    <div class="col-md-4">
      <div class="action-card text-center" onclick="location.href='allComplaints.jsp'">
        <div class="action-icon text-success">
          <i class="fas fa-list-alt"></i>
        </div>
        <div class="action-title">View Complaints</div>
        <small class="text-muted">Track complaint status</small>
      </div>
    </div>

    <div class="col-md-4">
      <div class="action-card text-center" onclick="location.href='userProfile.jsp'">
        <div class="action-icon text-warning">
          <i class="fas fa-user-cog"></i>
        </div>
        <div class="action-title">My Profile</div>
        <small class="text-muted">Update account settings</small>
      </div>
    </div>

  </div>
</div>

<!-- ACTIVE COMPLAINTS -->
<div class="container-fluid mt-5">
  <h5>Active Complaints</h5>
  <small class="text-muted">Complaints currently in progress</small>

  <div class="table-responsive mt-3">
    <table class="table table-striped table-hover align-middle">
      <thead class="bg-primary text-white">
        <tr>
          <th>ID</th>
          <th>Image</th>
          <th>Category</th>
          <th>Title</th>
          <th>Description</th>
          <th>Date</th>
          <th>Quarter</th>
          <th>Status</th>
          <th>Action Taken</th>
        </tr>
      </thead>

      <tbody>
      <%
        if(list!=null && !list.isEmpty()){
          for(Complaintdtls c:list){
      %>
        <tr>
          <td><%=c.getid()%></td>
          <td><img src="images/<%=c.getImage()%>" width="50"></td>
          <td><%=c.getCategory()%></td>
          <td><%=c.getTitle()%></td>
          <td><%=c.getDescription()%></td>
          <td><%=c.getCreatedate()%></td>
          <td><%=c.getQtrno()%></td>
          <td>
            <span class="badge px-3 py-2 <%=c.getStatus().equals("Active")?"badge-open":"badge-closed"%>">
              <%=c.getStatus()%>
            </span>
          </td>
          <td><%=c.getAction()==null?"-":c.getAction()%></td>
        </tr>
      <%
          }
        } else {
      %>
        <tr>
          <td colspan="9" class="text-center text-muted">
            No active complaints 🎉
          </td>
        </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>
</div>

<div class="mt-5">
  <%@include file="/all_component/footer.jsp"%>
</div>

</body>
</html>
