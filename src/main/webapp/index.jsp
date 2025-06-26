<%@ page import="java.sql.Connection" %>
<%@ page import="com.DB.DBConnect" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Complaint Management System</title>
<%@include file="all_component/allCss.jsp"%>
<style type="text/css">
.back-img {
	background-image: url('<%= request.getContextPath() %>/img/download.jpeg');
	background-size: cover;
	background-position: center;
	height: 80vh;
	display: flex;
	align-items: center;
	justify-content: center;
	background-repeat: no-repeat;
}
</style>


</head>
<body style="background-color: #f7f7f7;">

	
	<%@include file="all_component/navbar.jsp"%>
	
	<div class="container-fluid back-img">

		<h1 class="text-center text-white">Complaint Management System</h1>
	</div>

<%
Connection conn = DBConnect.getConnection();
out.println(conn);
%>


	<%@include file="all_component/footer.jsp"%>

</body>
</html>