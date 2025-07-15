<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
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

else if (!user.getRole().equals("AC") && !user.getRole().equals("AE")) {
    // Redirect to home page if the user is not Admin
    response.sendRedirect("../home.jsp");
    return;

}
    

%>
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

						
						<div>
        <!-- Display success message -->
        <%
            String succMsg = (String) session.getAttribute("succMsg");
            if (succMsg != null) {
        %>
            <div style="color: green; ;font-size:25px; font-weight: bold;">
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
red;font-size:25px; font-weight: bold;">
                <%= failedMsg %>
            </div>
        <%
            session.removeAttribute("failedMsg");
            }
        %>
    </div>

						<form id="addcomp" action="../addcomplaint" method="post"
						enctype="multipart/form-data">
						<div class="form-group">
								<label for="inputState">Complaint Categories</label> <select
									id="inputState" name="category" class="form-control">
									<option selected>--select--</option>
									
									<option value = "Civil">Civil</option>
									<option value = "Electrical">Electrical</option>
									

								</select>
							</div>
						

							<div class="form-group">
								<label for="exampleInputEmail1">Complaint Title</label> <input
									name="title" type="text" class="form-control">
							</div>
							
							<div class="form-group">
								<label for="text">Complaint Description</label>  
								<textarea name="description" class="form-control" id="description" rows="3"></textarea>
							</div>
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
								<label for="exampleInputEmail1">Employee no / Mobile No.</label> <input
									name="empn" type="text" class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">User name</label> <input
									name="username" type="text" class="form-control">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Contact number</label> <input
									name="phone" type="number" class="form-control">
							</div>
							

							

							<div class="form-group">
								<label for="exampleFormControlFile1">Upload Photo</label> <input
									name="imagefile" type="file" class="form-control-file"
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
		
<script>
  document.addEventListener('DOMContentLoaded', function () {
    console.log("Script loaded."); // ← Add this to confirm it's running

    const form = document.getElementById('addcomp');
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