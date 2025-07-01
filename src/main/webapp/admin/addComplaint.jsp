<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin: Add Complaint</title>
<%@include file="allCss.jsp"%>
</head>
<body style="background-color: #f0f2f2;">
	<%@include file="navbar.jsp"%>
	

	<div class="caontainer" style="margin-top: 30px">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body">
						<h4 class="text-center">Add Complaint</h4>

						


						<form enctype="multipart/form-data">

							<div class="form-group">
								<label for="exampleInputEmail1">Complaint Title</label> <input
									name="bname" type="text" class="form-control">
							</div>
							
							<div class="form-group">
								<label for="text">Complaint Description</label>  
								<textarea name="description" class="form-control" id="description" rows="3"></textarea>
							</div>
							

							<div class="form-group">
								<label for="inputState">Complaint Categories</label> <select
									id="inputState" name="categories" class="form-control">
									<option selected>--select--</option>
									
									<option value = "civil">Civil</option>
									<option value = "electrical">Electrical</option>
									

								</select>
							</div>

							<div class="form-group">
								<label for="inputState">Complaint Status</label> <select
									id="inputState" name="status" class="form-control">
									<option selected>--select--</option>
									<option value="Active">Active</option>
									<option value="Inactive">Inactive</option>
								</select>
							</div>

							<div class="form-group">
								<label for="exampleFormControlFile1">Upload Photo</label> <input
									name="bimg" type="file" class="form-control-file"
									id="exampleFormControlFile1">
							</div>


							<button type="submit" class="btn btn-primary">Add</button>
						</form>

					</div>
				</div>
			</div>
		</div>

	</div>

	<div style="margin-top: 100px;">
		<%@include file="footer.jsp"%></div>
</body>
</html>