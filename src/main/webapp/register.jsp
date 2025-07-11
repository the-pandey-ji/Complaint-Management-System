<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration</title>
<%@ include file="all_component/allCss.jsp" %>
<style type="text/css">
.paint-card {
	box-shadow: 0 0 6px 0 rgba(0, 0, 0, 0.3);
}

.error {
	color: red;
}
</style>
</head>
<body>

<%@include file="all_component/navbar.jsp" %>

<div class="container p-2">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card paint-card">
					<div class="card-body">
						<h3 class="text-center mb-5">Register User</h3>

					
						<form action="register" method="post">

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
							
							
							
							<div class="form-group">
								<label for="exampleInputEmail1">Enter Qtr No</label> 
								<input
									type="text" class="form-control" required="required" name="qtrno">
							</div>
							
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

</body>
</html>