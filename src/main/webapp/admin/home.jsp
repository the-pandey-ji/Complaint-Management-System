

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                </a>
            </div>
        </div>

        <div class="col-md-3 text-center">
            <div class="card">
                <div class="card-body">
                    <i class="fas fa-sign-out-alt fa-5x text-danger"></i>
                    <br>
                    <h3 class="text-black">Logout</h3>
                    <p class="text-secondary">Logout from the admin dashboard.</p>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
