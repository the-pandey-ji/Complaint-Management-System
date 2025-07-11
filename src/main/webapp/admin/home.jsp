

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.entity.User" %>
<%
// Check if the user is logged in
User user = (User) session.getAttribute("Userobj");

if (user == null) {
    // Redirect to login page if not logged in
    response.sendRedirect("../index.jsp");
    return;
}

if (!user.getUsername().equals("Admin")) {
    // Redirect to home page if the user is not Admin
    response.sendRedirect("../home.jsp");
    return;
}
%>


<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

<%@include file="allCss.jsp" %>

<style type="text/css">
a {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>

<%@include file="navbar.jsp" %>
    <h1 >Welcome to Admin Dashboard</h1>
    
<div class="container">
    <div class="row align-items-center justify-content-center">
        <div class="col-md-3 text-center">
            <a href="addComplaint.jsp">
                <div class="card">
                    <div class="card-body">
                        <i class="fas fa-plus-square fa-5x text-black"></i>
                        <br>
                        <h3 class="text-black">Add Complaint</h3>
                        <p class="text-secondary">Add a new complaint to the system.</p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-3 text-center">
          <a href="viewComplaints.jsp">
            <div class="card">
                <div class="card-body">
                    <i class="fas fa-box-open fa-5x text-warning"></i>
                    <br>
                    <h3 class="text-black">All Complaints</h3>
                    <p class="text-secondary">View all complaints registered in the system.</p>
                </div>        
            </div>
             </a>
        </div>

        <div class="col-md-3 text-center">
            <a data-toggle="modal" data-target="#exampleModalCenter">
            <div class="card">
                <div class="card-body">
                    <i class="fas fa-sign-out-alt fa-5x text-danger"></i>
                    <br>
                    <h3 class="text-black">Logout</h3>
                    <p class="text-secondary">Logout from the admin dashboard.</p>
                </div>
            </div>
            </a>
        </div>
    </div>
</div>

<!-- Logout Modal -->

<!-- Button trigger modal 
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
  Launch demo modal
</button>
-->
<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
       <!--  <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5> -->
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      <div class="text-center">
      <h4>Are you sure you want to logout?</h4>
      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <a href = "../logout" type="button" class="btn btn-danger ml-4 text-white">Logout!</a>
        </div>
      </div>
      <div class="modal-footer">
        
      </div>
    </div>
  </div>
</div>

<!-- Logout Modal  end-->

		<div style="margin-top: 430px;">
		<%@include file="footer.jsp"%></div>
</body>
</html>
