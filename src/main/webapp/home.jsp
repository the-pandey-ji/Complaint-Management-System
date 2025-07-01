

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
</head>
<body>
    <h1>Welcome to Your Dashboard</h1>

    <h2>User Details:</h2>
    Welcome <%= session.getAttribute("username") %>!<br>
</body>
</html>
