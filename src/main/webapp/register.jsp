<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="all_component/allCss.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Registration</title>

<style type="text/css">
.paint-card {
	box-shadow: 0 0 6px 0 rgba(0, 0, 0, 0.3);
}

.error {
	color: red;
}

.card {
width: 200%;
	
}
</style>
</head>
<body>


<div class="container-fluid"
	style="height: 5px; background-color: #303f9f"></div>
	
	
	

<div class="container-fluid p-3 bg-light">

	<div class="row">
		<div class="col-md-3 text-success">
			<h3>
				<i class="fas fa-book"></i> Complaint Management System</h3>
			
			
		</div>
		
		
		
		
		
		<div class="col-md-2 ml-auto">
		 
				<a href="index.jsp" class="btn btn-success "><i
					class="fas fa-sign-in-alt"></i> Login</a> 
					<a href="register.jsp"
					class="btn btn-primary text-white ml-2"><i class="fas fa-user-plus"></i>
					Register</a>
			</div>
		

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
			<li class="nav-item active"><a class="nav-link" href="index.jsp">Home
					<span class="sr-only">(current)</span>
			</a></li>
	
<!-- 
			<li class="nav-item dropdown"><a
				class="nav-link active dropdown-toggle" href="#" id="navbarDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> Categories </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item"
						href="all_recent_book.jsp">All</a>
					

					<a class="dropdown-item"
						href="catogory_book.jsp"></a>
				

				</div></li> -->

		<!-- 	<li class="nav-item active"><a class="nav-link disabled"
				href="all_old_book.jsp"><i class="fas fa-book-open"></i> Old
					Complaint</a></li> -->
		</ul>
		
		<div class="form-inline my-2 my-lg-0">
			<!-- <a href="setting.jsp" class="btn btn-light my-2 my-sm-0"
				type="submit"> <i class="fas fa-cog"></i> Setting
			</a> --> 
			<a href="helpline.jsp" class="btn btn-light my-2 my-sm-0 ml-1 mr-2"> <i class="fas fa-phone-square-alt"></i> Contact
				Us
			</a>
		</div>
	
			<!-- <form class="form-inline my-2 my-lg-0" action="search_Complaint.jsp"
				method="post">
				<input class="form-control mr-sm-2 " type="search" name="ch"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-primary my-2 my-sm-0 " type="submit">Search</button>
			</form> -->
		
		
	</div>
</nav>

<%--  <%@include file="all_component/navbar.jsp" %> --%>

<div class="container p-2">
		<div class="row">
			<div class="col-md-4 offset-md-2">
				<div class="card paint-card">
					<div class="card-body">
						<h3 class="text-center mb-5">Register User</h3>
						<%
				            String failedMsg = (String) session.getAttribute("failedMsg");
				            if (failedMsg != null) {
				        %>
				            <div style="color: 
												red;">
				                <%= failedMsg %>
				            </div>
				        <%
				            session.removeAttribute("failedMsg");
				            }
				        %>

					
						<form id="registerForm" action="register" method="post">

							<div class="form-group">
								<label for="exampleInputEmail1">Enter Emp.ID / Mobile No.</label> 
								<input
									type="number" class="form-control" required="required" name="empn">
							</div>
							
							<div class="form-group">
								<label for="exampleInputEmail1">Enter Full Name</label> 
								<input
									type="text" class="form-control" required="required" name="username">
							</div>
							
							
							
							<!-- <div class="form-group">
								<label for="exampleInputEmail1">Enter Qtr No</label> 
								<input
									type="text" class="form-control" required="required" name="qtrno">
							</div> -->
							<div class="form-row align-items-end">
							  <div class="col-md-3">
							    <label for="qtrnoSelect">Select Qtr Type</label>
							    <select id="qtrnoSelect" class="form-control" required>
							      <option value="">Select</option>
							      <option value="A">A</option>
							      <option value="B">B</option>
							      <option value="C">C</option>
							      <option value="C">D</option>
							      <option value="C">Misc</option>
							    </select>
							  </div>
							
							  <div class="col-md-3">
							    <label for="qtrnoBlock1">Enter Qtr No.</label>
							    <input type="text" id="qtrnoBlock1" class="form-control" required>
							  </div>
							
							  <div class="col-md-3">
							    <label for="qtrnoBlock2">Enter Qtr Ext</label>
							    <input type="text" id="qtrnoBlock2" class="form-control" placeholder="IF No ext enter 0" required>
							  </div>
							</div>

								
								<!-- Hidden input to store the combined qtrno value -->
								<input type="hidden" id="qtrno" name="qtrno">
								
								
							
							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									type="email" class="form-control" required="required" name="email">

							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Phone No</label> <input
									type="text" class="form-control" required="required" name="phone">
							</div>

							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									type="password" class="form-control" id="exampleInputPassword1"
									required="required" name="password">
							</div>
							<!-- <div class="form-check">
								<input type="checkbox" class="form-check-input" name="check"
									id="exampleCheck1" required="required"> <label class="form-check-label" 
									for="exampleCheck1">Agree terms and Condition</label>
							</div> -->
							<div class="text-center p-2">
								<button type="submit" class="btn btn-primary btn-block btn-sm">Register</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

<%@include file="all_component/footer.jsp"%>


<script>
  document.addEventListener('DOMContentLoaded', function () {
    console.log("Script loaded."); // ← Add this to confirm it's running

    const form = document.getElementById('registerForm');
    if (form) {
      console.log("Form found");
      form.addEventListener('submit', function (event) {
    	  console.log("Submit event triggered");
        const prefix = document.getElementById('qtrnoSelect').value;
        const block1 = document.getElementById('qtrnoBlock1').value;
        const block2 = document.getElementById('qtrnoBlock2').value;

        
        console.log("prefix:", prefix);
        console.log("block1:", block1);
        console.log("block2:", block2);

        if (!prefix || !block1 || !block2) {
          alert("Please fill all Quarter Number fields.");
          event.preventDefault();
          return;
        }

        const qtrnoField = document.getElementById('qtrno');
        qtrnoField.value = `${prefix}-${block1}/${block2}`;
        console.log('qtrno:', qtrnoField.value);
      });
    } else {
      console.warn('Form not found in DOM.');
    }
  });
</script>
</body>
</html>