<%@ page import="com.entity.User" %>


<div class="container-fluid"
	style="height: 5px; background-color: #303f9f"></div>
	
	
	

<div class="container-fluid p-3 bg-light">

	<div class="row">
		<div class="col-md-3 text-success">
			<h3>
				<i class="fas fa-book"></i> Complaint Management System</h3>
			
			
		</div>
		
		
		
		
		
		<div class="col-md-3 ml-auto">
		 <%
		   
	        User user1 = (User) session.getAttribute("Userobj");
	        if (user1 != null) {
	    %>
	        <span class="text-white btn btn-success ml-2">Welcome, <%= user1.getUsername() %>!</span>
	        <a data-toggle="modal" data-target="#exampleModalCenter" class="btn btn-danger ml-2 text-white"><i class="fas fa-sign-out-alt"></i> Logout</a>
	    <%
	        } else {
	    %>
				<a href="index.jsp" class="btn btn-success "><i
					class="fas fa-sign-in-alt"></i> Login</a> 
					<a href="register.jsp"
					class="btn btn-primary text-white ml-auto text-right"><i class="fas fa-user-plus"></i>
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
        <a href = "logout" type="button" class="btn btn-danger ml-4 text-white">Logout!</a>
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
			<li class="nav-item active"><a class="nav-link" href="addUserComplaint.jsp">Add Complaint</a></li>
			
	

			<li class="nav-item dropdown"><a
				class="nav-link active dropdown-toggle" href="#" id="navbarDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> View Complaints </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
				
				<a class="dropdown-item nav-item active"
						href="allComplaints.jsp">All Complaints</a>
					<a class="dropdown-item nav-item active"
						href="civilComplaints.jsp">Civil Complaints</a>
					

					<a class="dropdown-item nav-item active"
						href="eComplaints.jsp">Electrical Complaints</a>
				

				</div></li>
				

		<!-- 	<li class="nav-item active"><a class="nav-link disabled"
				href="all_old_book.jsp"><i class="fas fa-book-open"></i> Old
					Complaint</a></li> -->
		</ul>
		
		<form class="form-inline my-2 my-lg-0">
			<!-- <a href="setting.jsp" class="btn btn-light my-2 my-sm-0"
				type="submit"> <i class="fas fa-cog"></i> Setting
			</a> --> 
			<a href="helpline.jsp" class="btn btn-light my-2 my-sm-0 ml-1 mr-2"
				type="submit"> <i class="fas fa-phone-square-alt"></i> Contact
				Us
			</a>
		</form>
	
			<!-- <form class="form-inline my-2 my-lg-0" action="search_Complaint.jsp"
				method="post">
				<input class="form-control mr-sm-2 " type="search" name="ch"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-primary my-2 my-sm-0 " type="submit">Search</button>
			</form> -->
		
		
	</div>
</nav>