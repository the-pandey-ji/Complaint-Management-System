
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
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
    <meta charset="ISO-8859-1">
    <title>Change Password</title>
    <%@ include file="all_component/allCss.jsp" %>
</head>
<body style="background-color: #f0f2f2;">
    <%@ include file="all_component/navbar.jsp" %>

    <div class="container" style="margin-top: 30px;">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-body">
                        <h4 class="text-center">Change Password</h4>

                        <!-- Display success message -->
                        <%
                            String succMsg = (String) session.getAttribute("succMsg");
                            if (succMsg != null) {
                        %>
                            <div style="color: green; font-size: 18px; font-weight: bold;">
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
                            <div style="color: red; font-size: 18px; font-weight: bold;">
                                <%= failedMsg %>
                            </div>
                        <%
                            session.removeAttribute("failedMsg");
                            }
                        %>

                        <form action="changePassword" method="post">
                            <div class="form-group">
                                <label for="currentPassword">Current Password</label>
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                            </div>
                            <div class="form-group">
                                <label for="newPassword">New Password</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                            </div>
                            <div class="form-group">
                                <label for="confirmPassword">Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary">Change Password</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div style="margin-top: 100px;">
        <%@ include file="all_component/footer.jsp" %>
    </div>
</body>
</html>
