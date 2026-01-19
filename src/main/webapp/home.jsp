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
<meta name="viewport" content="width=device-width, initial-scale=1">

<%@include file="/all_component/allCss.jsp" %>

<style>
a{text-decoration:none}

/* ================= KPI CARDS ================= */
.kpi-card{
  padding:32px;
  border-radius:18px;
  color:#fff;
  box-shadow:0 10px 25px rgba(0,0,0,.18);
  position:relative;
  overflow:hidden;
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
.kpi-title{font-size:16px}
.kpi-value{font-size:42px;font-weight:700}

.bg-blue{background:linear-gradient(135deg,#1e90ff,#0066cc)}
.bg-orange{background:linear-gradient(135deg,#ff9f43,#ff6f00)}
.bg-green{background:linear-gradient(135deg,#2ecc71,#27ae60)}

.badge-open{background:#ff9f43}
.badge-closed{background:#2ecc71}

/* ================= QUICK ACTIONS ================= */
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
}
.action-icon{font-size:32px;margin-bottom:10px}
.action-title{font-weight:600}

/* ================= MOBILE CARD VIEW ================= */
.mobile-card{
  display:none;
  background:#fff;
  border-radius:14px;
  padding:14px;
  box-shadow:0 4px 12px rgba(0,0,0,.12);
  margin-bottom:12px;
  font-size:13px;
}
.mobile-card h6{
  font-size:14px;
  font-weight:600;
  margin-bottom:6px;
}
.mobile-card small{
  display:block;
  margin-bottom:4px;
}

/* ================= RESPONSIVE ================= */
@media(max-width:768px){
  table{display:none}
  .mobile-card{display:block}

  .kpi-card{
    text-align:center;
    padding:24px;
  }
  .kpi-value{font-size:32px}

  .action-card{
    display:flex;
    align-items:center;
    gap:14px;
    text-align:left;
  }
  .action-icon{font-size:26px}
}

@media(max-width:576px){
  .kpi-value{font-size:26px}
}
</style>
</head>

<body>

<%@include file="/all_component/navbar.jsp" %>

<!-- HEADER -->
<div class="container-fluid mt-5 text-center">
  <h2 class="text-primary font-weight-bold">User Dashboard</h2>
  <h4 class="text-success">Welcome, <%=user.getUsername()%></h4>
</div>

<!-- KPI -->
<div class="container-fluid mt-4">
  <div class="row g-4">
    <div class="col-md-4">
      <div class="kpi-card bg-blue">
        <div class="kpi-title"><h4>Total Complaints</h4></div>
        <div class="kpi-value"><%=totalCount%></div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="kpi-card bg-orange">
        <div class="kpi-title"><h4>Open Complaints</h4></div>
        <div class="kpi-value"><%=openCount%></div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="kpi-card bg-green">
        <div class="kpi-title"><h4>Resolved</h4></div>
        <div class="kpi-value"><%=closedCount%></div>
      </div>
    </div>
  </div>
</div>

<!-- QUICK ACTIONS -->
<div class="container-fluid mt-5">
  <h5>Quick Actions</h5>
  <div class="row g-4 mt-2">
    <div class="col-md-4">
      <div class="action-card" onclick="location.href='addUserComplaint.jsp'">
        <div class="action-icon text-primary"><i class="fas fa-plus-circle"></i></div>
        <div>
          <div class="action-title"><h4>Raise Complaint</h4></div>
          <h6 class="text-muted">Submit new issue</h6>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="action-card" onclick="location.href='closedComplaints.jsp'">
        <div class="action-icon text-success"><i class="fas fa-list-alt"></i></div>
        <div>
          <div class="action-title"><h4>Closed Complaints</h4></div>
          <h6 class="text-muted">Give Feedback</h6>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="action-card" onclick="location.href='userProfile.jsp'">
        <div class="action-icon text-warning"><i class="fas fa-user-cog"></i></div>
        <div>
          <div class="action-title"><h4>My Profile</h4></div>
          <h6 class="text-muted">Account settings</h6>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- ACTIVE COMPLAINTS -->
<div class="container-fluid mt-5">
  <h5>Active Complaints</h5>

  <!-- DESKTOP TABLE -->
  <div class="table-responsive mt-3">
    <table class="table table-striped align-middle">
      <thead class="bg-primary text-white">
        <tr>
          <th>ID</th>
          <th>Photo</th>
          <th>Category</th>
          <th>Title</th>
          <th>Date</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
      <%
        if(list!=null && !list.isEmpty()){
          for(Complaintdtls c:list){
      %>
        <tr>
          <td><%=c.getid()%></td>
          <td>
            <img src="images/<%=c.getImage()%>"
                 width="45" height="45"
                 style="border-radius:6px;object-fit:cover"
                 loading="lazy">
          </td>
          <td><%=c.getCategory()%></td>
          <td><%=c.getTitle()%></td>
          <td><%=c.getCreatedate()%></td>
          <td>
            <span class="badge <%=c.getStatus().equals("Active")?"badge-open":"badge-closed"%>">
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
          <td colspan="7" class="text-center text-muted">
            No active complaints 🎉
          </td>
        </tr>
      <% } %>
      </tbody>
    </table>
  </div>

  <!-- MOBILE CARD VIEW -->
  <div class="d-md-none mt-3">
  <%
    if(list!=null && !list.isEmpty()){
      for(Complaintdtls c:list){
  %>
    <div class="mobile-card">
      <div class="d-flex align-items-center mb-2">
        <img src="images/<%=c.getImage()%>"
             width="50" height="50"
             style="border-radius:8px;object-fit:cover"
             loading="lazy">
        <div class="ml-2">
          <h6 class="mb-1"><%=c.getTitle()%></h6>
          <small class="text-muted"><%=c.getCategory()%></small>
        </div>
      </div>

      <small><b>Date:</b> <%=c.getCreatedate()%></small>
      <small><b>Quarter:</b> <%=c.getQtrno()%></small>

      <small>
        <b>Status:</b>
        <span class="badge <%=c.getStatus().equals("Active")?"badge-open":"badge-closed"%>">
          <%=c.getStatus()%>
        </span>
      </small>

      <small><b>Action:</b> <%=c.getAction()==null?"-":c.getAction()%></small>
    </div>
  <% } } %>
  </div>
</div>

<%@include file="/all_component/footer.jsp"%>

</body>
</html>
