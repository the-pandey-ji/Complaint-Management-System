<%@ page import="java.sql.Connection" %>
<%@ page import="com.DB.DBConnect" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Complaint Management System</title>
<%@include file="all_component/allCss.jsp"%>
<style type="text/css">


body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	 background: url('/Complaint-Management-System/img/download.jpeg') no-repeat center center fixed;
            background-size: cover;
	background-size: cover;
	margin: 0;
	justify-content: center;
	align-items: center;
	color: #333;
}

.login {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 80vh;
}

.container1 {
	background-color: rgba(255, 255, 255, 0.9);
	padding: 10px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
	max-width: 650px;
	width: 100%;
}

.flash {
	animation: flash 0.9s linear infinite alternate;
}

@keyframes flash {
from { color:black;}

to {color: green;}

}
h1, h2 {
	margin: 10px 0;
}

.form-group {
	margin: 15px 0;
	text-align: left;
}

label {
	display: inline-block;
	width: 100px;
	text-align: right;
	margin-right: 10px;
	font-weight: bold;
}

input[type="text"], input[type="password"] {
	width: calc(100% - 120px);
	padding: 10px;
	margin: 5px 0;
	border: 1px solid #ccc;
	border-radius: 4px;
}

input[type="submit"], input[type="reset"] {
	padding: 10px 20px;
	margin: 10px 5px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	background-color: #4CAF50;
	color: white;
	transition: background-color 0.3s ease;
}

input[type="reset"] {
	background-color: #f44336;
}

input[type="submit"]:hover {
	background-color: #45a049;
}

input[type="reset"]:hover {
	background-color: #e53935;
}

.notice {
	font-size: 0.7em;
	color: #555;
	margin-top: 15px;
}

.error-message {
	font-size: 0.8em;
	color: red;
	margin-top: 5px;
}

img {
	margin-bottom: 10px;
}

.table-container {
	display: flex;
	justify-content: center;
	width: 100%;
}

table {
	border-collapse: collapse;
	width: 100%;
}

td {
	padding: 5px;
}

.form-group-buttons {
	display: flex;
	justify-content: right;
	gap: 5px;
	margin-top: 5px;
}
</style>


</head>
<body style="background-color: #f7f7f7;">

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

	
	<%-- <%@include file="all_component/navbar.jsp"%> --%>
	
	<div class="login">
	
	<div class="container1">
	<%
          String succMsg = (String) session.getAttribute("succMsg");
          if (succMsg != null) {
      %>
          <h4 class="success text-center text-success" style="font-size:30px; font-weight: bold;"><%= succMsg %></h4>
          <%
              session.removeAttribute("succMsg"); // Clear the message after displaying
          }
      %>

			 <%
            String failedMsg = (String) session.getAttribute("errorMsg");
            if (failedMsg != null) {
        %>
            <div style="color: red;font-size:25px; font-weight: bold;">
                <%= failedMsg %>
            </div>
        <%
            session.removeAttribute("errorMsg");
            }
        %>
      
      	
        <form action="login" method="post">
            <img src="/Complaint-Management-System/img/nflimage.png" alt="NFL Logo" height="200" width="230">
            <h1 class="flash">National Fertilizers Limited, Panipat</h1>
            <h2>Complaint Tracker</h2>
            <div class="table-container">
                <table>
                    <tbody><tr>
                        <td align="right">
                           <label for="exampleInputEmail1">Enter Emp.ID / Mobile No.</label>
                        </td>
                        <td align="left">
                            <input
									type="text" class="form-control" required="required" name="empn">                
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <label for="password">Password</label>
                        </td>
                        <td align="left">
                            <input
									type="password" class="form-control" id="exampleInputPassword1"
									required="required" name="password">              
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                                              
                    </td></tr><tr align="justify">
                        <td align="right">
                            <input type="submit" value="Login">
                        </td>
                        <td align="center">
                            <!-- <input type="submit" value="Login"> -->
                            <input type="reset" value="Cancel">          
                        </td>
                    </tr>
                </tbody></table>
            </div>
            <div class="notice">
              <!--  For better view & JavaScript functionality, please open the application in Microsoft Internet Explorer (IE-9 or IE-11). -->
              For better view/JavaScript functionality, please use latest version of Google Chrome/Microsoft Edge.
            </div>
        </form>



</div>
 
    </div>
	
	
	
	
<!-- 	<div class="container-fluid back-img">

		<div class="container p-5" style="margin-top: 50px; margin-bottom: 300px;">
		<div class="row">
			<div class="col-md-6 offset-md-3 ">
				<div class="card paint-card">
					<div class="card-body">
					
						<h3 class="text-center mb-5">Login</h3>
					
					
	
					
						<form action="login" method="post">

							<div class="form-group">
								<label for="exampleInputEmail1">Enter Emp.ID / Aadhar ID</label> 
								<input
									type="number" class="form-control" required="required" name="empn">
							</div>
							
							

							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									type="password" class="form-control" id="exampleInputPassword1"
									required="required" name="password">
							</div>
							
							<div class="text-center p-2">
								<button type="submit" class="btn btn-primary btn-block btn-sm">Login</button>
								
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	</div> -->

<%-- <%
Connection conn = DBConnect.getConnection();
out.println(conn);
%>
			--%>


	<%@include file="all_component/footer.jsp"%>

</body>
</html>