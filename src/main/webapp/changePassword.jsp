
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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>Change Password</title>
    <%@ include file="all_component/allCss.jsp" %>
    <style>
/* =========================
   MOBILE RESPONSIVE FIX
   ========================= */
@media (max-width: 768px) {

    /* Container spacing */
    .container {
        margin-top: 20px !important;
        padding-left: 12px !important;
        padding-right: 12px !important;
    }

    /* Card full width */
    .col-md-4.offset-md-4 {
        max-width: 100% !important;
        flex: 0 0 100% !important;
        margin-left: 0 !important;
    }

    /* Card padding */
    .card-body {
        padding: 20px !important;
    }

    /* Title */
    h4.text-center {
        font-size: 1.2rem;
        margin-bottom: 16px;
    }

    /* Input fields */
    .form-control {
        height: 46px;
        font-size: 14px;
    }

    label {
        font-size: 13px;
    }

    /* Button full width */
    .btn-primary {
        width: 100%;
        padding: 10px;
        font-size: 15px;
    }

    /* Success / error messages */
    div[style*="color: green"],
    div[style*="color: red"] {
        font-size: 15px !important;
        text-align: center;
        margin-bottom: 10px;
    }

    /* Footer spacing */
    body > div:last-child {
        margin-top: 40px !important;
    }
}

/* EXTRA SMALL DEVICES */
@media (max-width: 480px) {

    h4.text-center {
        font-size: 1.1rem;
    }

    label {
        font-size: 12px;
    }

    .form-control {
        height: 44px;
    }
}
</style>
    
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
