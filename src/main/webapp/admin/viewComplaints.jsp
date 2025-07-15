<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.ComplaintDAOImpl"%>
<%@page import="com.DAO.ComplaintDAO"%>
<%@page import="com.entity.Complaintdtls"%>
	<%@ page import="com.entity.User" %>
<%
// Check if the user is logged in
User user = (User) session.getAttribute("Userobj");

if (user == null) {
    // Redirect to login page if not logged in
    response.sendRedirect("../index.jsp");
    return;
}

else if (!user.getRole().equals("AC") && !user.getRole().equals("AE")) {
    // Redirect to home page if the user is not Admin
    response.sendRedirect("../home.jsp");
    return;

}
    

%>


<%-- <%
    String backgroundImage = "";
    if (user.getRole().equals("AC")) {
        backgroundImage = "url('../img/ac_background4.jpg')";
    } else if (user.getRole().equals("AE")) {
        backgroundImage = "url('../img/ae_background.jpg')";
    }
%> --%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin: All Complaints</title>
<%@include file="allCss.jsp"%>
<%--  <style>
        body {
            
            background-image: <%= backgroundImage %>;
           
               background-attachment: fixed;	
            background-size: 100%;
            background-repeat: no-repeat;
           
            
        }
        td{
       font-weight: bold;
        }
    </style> --%>
</head>
<body>
	<%@include file="navbar.jsp"%>
	
	<h3 class="text-center">View All Complaint</h3>

	
	
	<div class="container-fluid">
		<table class="table table-striped">
			<thead class="bg-primary text-white">
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Image</th>
					<th scope="col">Category</th>
					<th scope="col">Complaint Title</th>
					<th scope="col">Complaint Description</th>
					<th scope="col">Complaint Date</th>
					<th scope="col">Qtr No.</th>
					<th scope="col">UserID</th>
					<th scope="col">User</th>
					<th scope="col">Phone</th>
					<th scope="col">Status</th>
					<th scope="col">Action Taken</th>
					<th scope="col">Edit</th>
					<th scope="col">Close Complaint</th>
				</tr>
			</thead>
			<tbody>
			
			<%
						ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
			                List<Complaintdtls> list = null;
							if(user.getRole().equals("AC")) {
								 list = dao.getCivilComplaints();
							} else if(user.getRole().equals("AE")) {
								 list = dao.getElectricalComplaints();
							}
							else {
							
							 list = dao.getAllComplaints();
							}
							if (list != null && !list.isEmpty()) {
								for (Complaintdtls complaint : list) {
						%>
			
			<tr>
					<td><%= complaint.getid() %></td>
					<td><img src="../images/<%= complaint.getImage() %>"
						style="width: 50px; height: 50px;"></td>
					<td><%= complaint.getCategory() %></td>
					<td><%= complaint.getTitle() %></td>
					<td><%= complaint.getDescription() %></td>
					<td><%= complaint.getCreatedate() %></td>
					<td><%= complaint.getQtrno() %></td>
					<td><%= complaint.getEmpn() %></td>
					<td><%= complaint.getUsername() %></td>
					<td><%= complaint.getPhone() %></td>
					<td><%= complaint.getStatus() %></td>
					<td><%= complaint.getAction() %></td>

					<td><a href="editComplaint.jsp?id=<%= complaint.getid() %>"
						class="btn btn-sm btn-primary"><i class="fas fa-edit"></i>
							Edit</a></td>
							
					<td>
					  <a href="closeComplaint.jsp?id=<%= complaint.getid() %>"
					     class="btn btn-sm btn-danger <%= complaint.getStatus().equals("Closed") ? "disabled" : "" %>">
					    <i class="fas fa-trash-alt"></i> Close
					  </a>
					</td>
					<%-- <td><a href="closeComplaint.jsp?id=<%= complaint.getid() %>"
						class="btn btn-sm btn-danger"><i class="fas fa-trash-alt"></i>
							Close</a></td> --%>

					<%
					}
			}
					else {
					%>
                 <tr>
              		<td colspan="14" class="text-center">No complaints found</td>
               	 </tr>
            <%
                	                                
                }
			%>
				 

			</tbody>
		</table>
	</div>
	<div style="margin-top: 40px;">
		<%@include file="footer.jsp"%></div>
</body>
</html>