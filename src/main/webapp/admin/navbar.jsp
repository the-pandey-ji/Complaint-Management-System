
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.entity.User" %>
<div class="container-fluid"
	style="height: 5px; background-color: #303f9f"></div>

<div class="container-fluid p-3 bg-light">

	<div class="row">
		<div class="col-md-3 text-success">
			<h3>
				<i class="fas fa-book"></i> Complaint Management System
			</h3>
		</div>
		
		
		<div class="col-md-2 ml-auto">
		 <%
		   
	        User user = (User) session.getAttribute("user");
	        if (user != null && "Admin".equals(user.getUsername())) {
	    %>
	        <span class="text-white">Welcome, <%= user.getUsername() %>!</span>
	        <a href="../logout.jsp" class="btn btn-danger ml-2"><i class="fas fa-sign-out-alt"></i> Logout</a>
	    <%
	        } else {
	    %>
				<a href="../login.jsp" class="btn btn-success "><i
					class="fas fa-sign-in-alt"></i> Login</a> 
					<a href="../register.jsp"
					class="btn btn-primary text-white ml-2"><i class="fas fa-user-plus"></i>
					Register</a>
			</div>
		<%
		}
		%>

	</div>
</div>


<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
	<a class="navbar-brand" href="#"><i class="fas fa-home"></i></a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="home.jsp">Home
					<span class="sr-only">(current)</span>
			</a></li>
	
	<li class="nav-item active"><a class="nav-link" href="addComplaint.jsp">Add complaint
					<span class="sr-only">(current)</span>
			</a></li>
			
			
			<li class="nav-item active"><a class="nav-link"
				href="viewComplaints.jsp">View complaints <span class="sr-only">(current)</span>
				</a></li>
		</ul>
		
		
		
		
	</div>
</nav>