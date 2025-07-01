<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin: All Complaints</title>
<%@include file="allCss.jsp"%>
</head>
<body>
	<%@include file="navbar.jsp"%>
	
	<h3 class="text-center">Hello Admin</h3>

	
	
	<div class="container-fluid">
		<table class="table table-striped">
			<thead class="bg-primary text-white">
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Image</th>
					<th scope="col">Complaint Title</th>
					<th scope="col">Complaint Description</th>
					<th scope="col">UserID</th>
					<th scope="col">User</th>
					<th scope="col">Qtr No.</th>
					<th scope="col">Phone</th>
					<th scope="col">Category</th>
					<th scope="col">Status</th>
					<th scope="col">Action</th>
					<th scope="col">Edit</th>
					<th scope="col">Delete</th>
				</tr>
			</thead>
			<tbody>
				
				<tr>
					<td>001</td>
					<td><img src=""
						style="width: 50px; height: 50Px;"></td>
					<td>Window glass broken</td>
					<td>Window glass broken description</td>
					<td>1234</td>
					<td>test1</td>
					<td>B-21</td>
					<td>9123456789</td>
					<td>civil</td>
					<td>pending</td>
					<td>Carpenter sent</td>
					
					
					<td><a href=""
						class="btn btn-sm btn-primary"><i class="fas fa-edit"></i>
							Edit</a></td>
							<td> <a href=""
						class="btn btn-sm btn-danger"><i class="fas fa-trash-alt"></i>
							Delete</a></td>
				</tr>
			

			</tbody>
		</table>
	</div>
	<div style="margin-top: 430px;">
		<%@include file="footer.jsp"%></div>
</body>
</html>