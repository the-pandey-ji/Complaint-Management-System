<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
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

<div class="container p-5" style="margin-top: 50px; margin-bottom: 300px;">
		<div class="row">
			<div class="col-md-6 offset-md-3 ">
				<div class="card paint-card">
					<div class="card-body">
						<h3 class="text-center mb-5">Login</h3>

					
						<form >

							<div class="form-group">
								<label for="exampleInputEmail1">Enter Emp.ID / Aadhar ID</label> 
								<input
									type="number" class="form-control" required="required" name="eid">
							</div>
							
							

							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									type="password" class="form-control" id="exampleInputPassword1"
									required="required" name="password">
							</div>
							<div class="form-check">
								<input type="checkbox" class="form-check-input" name="check"
									id="exampleCheck1"> <label class="form-check-label"
									for="exampleCheck1">Agree terms and Condition</label>
							</div>
							<div class="text-center p-2">
								<button type="submit" class="btn btn-primary btn-block btn-sm">Login</button>
								<h6 class="text-center">OR</h6>
								<a href="register.jsp" class="btn btn-success btn-block btn-sm">Register</a>
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