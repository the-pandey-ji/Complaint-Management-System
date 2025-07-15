<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.UserDAOImpl"%>
<%@page import="com.entity.User"%>
<%@page import="com.UserComplaint.servlet.AddUserComplaint" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%
// Check if the user is logged in
User user = (User) session.getAttribute("Userobj");
if (user == null) {
    // Redirect to login page if not logged in
    response.sendRedirect("index.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Add Complaint</title>
<%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #f0f2f2;">
	<%@include file="all_component/navbar.jsp"%>
	





<div class="container" style="margin-top: 30px;">
  <div class="row">
    <div class="col-md-6 offset-md-3">
      <div class="card">
        <div class="card-body">
          <h4 class="text-center">Add Complaint</h4>
          
          						<div>
       <!-- Display success message -->
                        <%
                            String succMsg = (String) session.getAttribute("succMsg");
                            if (succMsg != null) {
                        %>
                            <div style="color: green; font-size:25px; font-weight: bold;">
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
                            <div style="color: red;font-size:25px; font-weight: bold;">
                                <%= failedMsg %>
                            </div>
                        <%
                            session.removeAttribute("failedMsg");
                            }
                        %>
    </div>

          <form action="addcomplaintuser" method="post" enctype="multipart/form-data">
            <div class="form-group">
              <label for="inputState">Complaint Categories</label>
              <select id="inputState" name="category" class="form-control">
                <option selected>--select--</option>
                <option value="Civil">Civil</option>
                <option value="Electrical">Electrical</option>
              </select>
            </div>

            <div class="form-group">
              <label for="exampleInputEmail1">Complaint Title</label>
              <input name="title" type="text" class="form-control">
            </div>

            <div class="form-group">
              <label for="text">Complaint Description</label>
              <textarea name="description" class="form-control" id="description" rows="3"></textarea>
            </div>

         <!--    <div class="form-group">
              <label for="exampleInputEmail1">Quarter Number</label>
              <input name="qtrno" type="text" class="form-control">
            </div> -->
          <%--   <div class="form-group">
               <label for="qtrno">Quarter Number</label>
              <input name="qtrno" type="text" class="form-control" value="<%= user.getQtrno() %>">
            </div> --%>
            
              <div class="form-group">
                                <label for="qtrno">Quarter Number</label>
                                <input name="qtrno" type="text" class="form-control" value="<%= user.getQtrno() != null ? user.getQtrno() : "" %>">
                            </div>

            <!-- Pre-fill user details -->
            <div class="form-group">
              <label for="empn">Employee Number</label>
              <input name="empn" type="text" class="form-control" value="<%= user.getEmpn() %>" readonly>
            </div>

            <div class="form-group">
              <label for="username">User Name</label>
              <input name="username" type="text" class="form-control" value="<%= user.getUsername() %>" readonly>
            </div>

            <div class="form-group">
              <label for="email">Email</label>
              <input name="email" type="email" class="form-control" value="<%= user.getEmail() %>" readonly>
            </div>

            <div class="form-group">
              <label for="phone">Contact Number</label>
              <input name="phone" type="text" class="form-control" value="<%= user.getPhone() %>" readonly>
            </div>

            <div class="form-group">
              <label for="exampleFormControlFile1">Upload Photo</label>
              <input name="imagefile" type="file" class="form-control-file" id="exampleFormControlFile1">
            </div>

            <button type="submit" class="btn btn-primary">Add</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>























	<div style="margin-top: 100px;">
		<%@include file="all_component/footer.jsp"%></div>
</body>
</html>