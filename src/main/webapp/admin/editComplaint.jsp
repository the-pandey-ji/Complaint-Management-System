<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.ComplaintDAOImpl"%>
<%@page import="com.entity.Complaintdtls"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
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
<meta charset="ISO-8859-1">
<title>Admin: Edit Complaint</title>
<%@include file="allCss.jsp"%>
</head>
<body style="background-color: #f0f2f2;">
	<%@include file="navbar.jsp"%>
	

	<div class="caontainer" style="margin-top: 30px">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body">
						<h4 class="text-center">Edit Complaint</h4>

						
						<div>
        <!-- Display success message -->
        <%
            String succMsg = (String) session.getAttribute("succMsg");
            if (succMsg != null) {
        %>
            <div style="color: 
green;">
                <%= succMsg %>
            </div>
        <%
            session.removeAttribute("succMsg");
            }
        %>

        <!-- Display failed message -->
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
    </div>

						<%
						int id = Integer.parseInt(request.getParameter("id"));
						ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
						Complaintdtls complaint = dao.getComplaintById(id);
						
						%>
					
						<form action="../complaintEdit" method="post"
						enctype="multipart/form-data">
							<input type="hidden" name="id" value="<%=complaint.getid()%>">

							
							<div class="form-group">
							    <label for="inputState">Complaint Categories</label>
							    <select id="inputState" name="category" class="form-control">
							        <option selected value="<%= complaint.getCategory() != null ? complaint.getCategory() : "" %>">
							            <%= complaint.getCategory() != null ? complaint.getCategory() : "Select Category" %>
							        </option>
							        <%
							            if ("Civil".equalsIgnoreCase(complaint.getCategory())) {
							        %>
							            <option value="Electrical">Electrical</option>
							        <%
							            } else if ("Electrical".equalsIgnoreCase(complaint.getCategory())) {
							        %>
							            <option value="Civil">Civil</option>
							        <%
							            } else {
							        %>
							            <option value="Civil">Civil</option>
							            <option value="Electrical">Electrical</option>
							        <%
							            }
							        %>
							    </select>
							</div>
						

							<div class="form-group">
							    <label for="exampleInputEmail1">Complaint Title</label> 
							    <input name="title" type="text" class="form-control" value="<%= complaint.getTitle() %>">
							</div>
							
							<div class="form-group">
								<label for="text">Complaint Description</label>  
								<textarea name="description" class="form-control" id="description" rows="3"><%=complaint.getDescription()%></textarea>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Qtr No</label> <input
									name="qtrno" type="text" class="form-control" value="<%= complaint.getQtrno() %>">
							</div>
							
							<div class="form-group">
								<label for="exampleInputEmail1">Employee no / Aadhar id</label> <input
									name="empn" type="text" class="form-control" value="<%= complaint.getEmpn() %>">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">User name</label> <input
									name="username" type="text" class="form-control" 	value="<%= complaint.getUsername() %>">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Contact number</label> <input
									name="phone" type="number" class="form-control" value="<%= complaint.getPhone() %>">
							</div>
							

							<div class="form-group">
								<label for="inputState">Complaint Date</label> <input
									name="createdate" type="text" class="form-control"
									value="<%=complaint.getCreatedate()%>" readonly>
							</div>

							<div class="form-group">
							<div class="form-group">
							<img src="../images/<%= complaint.getImage() %>"
						style="width: 100px; height: 100px;">
							</div>
								<label for="exampleFormControlFile1">Upload Photo</label> <input
									name="imagefile" type="file" class="form-control-file"
									id="exampleFormControlFile1">
							</div>


							<button type="submit" class="btn btn-primary">Update</button>
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