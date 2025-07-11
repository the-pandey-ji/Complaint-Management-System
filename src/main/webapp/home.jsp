

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.entity.User" %>
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
    <title>User Dashboard</title>

<%@include file="/all_component/allCss.jsp" %>

<style type="text/css">
a {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>

<%@include file="/all_component/navbar.jsp" %>
 <h1 class="text-center mt-5">Welcome, <%= user1.getUsername() %>!</h1>
 
    



		<div style="margin-top: 430px;">
		<%@include file="/all_component/footer.jsp"%></div>
</body>
</html>
