
<%@ page import="com.entity.User" %>
<%
    // Check if the user is logged in
    User usernav = (User) session.getAttribute("Userobj");
    if (usernav == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("../login.jsp");
        return;
    }
%>
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
		   
	        User user1 = (User) session.getAttribute("Userobj");
	        if (user1 != null && "Admin".equals(user1.getUsername())) {
	    %>
	        <span class="text-white btn btn-success ml-2">Welcome, <%= user1.getUsername() %>!</span>
	        <a data-toggle="modal" data-target="#exampleModalCenter" class="btn btn-danger ml-2 text-white"><i class="fas fa-sign-out-alt"></i> Logout</a>
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