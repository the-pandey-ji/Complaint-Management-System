<%@ page import="com.DB.DBConnect" %>
<%@ page import="java.sql.Connection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Complaint Management System | Secure Login</title>

<%@ include file="all_component/allCss.jsp" %>

<style>
/* ===== RESET ===== */
* {
    box-sizing: border-box;
}

/* ===== PAGE BASE ===== */
body {
    margin: 0;
    font-family: "Segoe UI", Roboto, Arial, sans-serif;
    background: linear-gradient(
        rgba(0,0,0,0.55),
        rgba(0,0,0,0.55)
    ),
    url('/Complaint-Management-System/img/download.jpeg') no-repeat center center fixed;
    background-size: cover;
    height: 100vh;

    display: flex;
    justify-content: center;
    align-items: center;
}

/* ===== LOGIN CARD (WIDER & PREMIUM) ===== */
.login-wrapper {
    width: 570px;              /* ⬅ MADE WIDER */
    background: rgba(255, 255, 255, 0.94);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);

    border-radius: 22px;
    padding: 44px 42px;
    text-align: center;

    border: 1px solid rgba(255, 255, 255, 0.35);

    box-shadow:
        0 30px 70px rgba(0, 0, 0, 0.35),
        inset 0 1px 0 rgba(255, 255, 255, 0.6);

    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.login-wrapper:hover {
    transform: translateY(-3px);
    box-shadow:
        0 40px 90px rgba(0, 0, 0, 0.45),
        inset 0 1px 0 rgba(255, 255, 255, 0.6);
}

/* ===== BRAND ===== */
.brand-logo img {
    height: 120px;
    margin-bottom: 14px;
    filter: drop-shadow(0 6px 10px rgba(0,0,0,0.25));
}

/* COMPANY NAME (SECONDARY) */
.brand-title {
    font-size: 18px;           /* ⬅ SMALLER */
    font-weight: 600;
    color: #2f3640;
    letter-spacing: 0.3px;
}

/* SYSTEM NAME (PRIMARY) */
.brand-subtitle {
    font-size: 25px;           /* ⬅ BIGGER */
    font-weight: 700;
    color: #1e272e;
    margin-bottom: 26px;
    line-height: 1.4;
}

/* ===== FORM ===== */
.form-group {
    text-align: left;
    margin-bottom: 16px;
}

label {
    font-size: 13px;
    font-weight: 600;
    color: #2f3640;
}

.form-control {
    height: 48px;
    border-radius: 12px;
    font-size: 14px;
    padding-left: 14px;
    border: 1px solid #dcdde1;
    background-color: #fafafa;
}

.form-control:focus {
    border-color: #0984e3;
    background-color: #ffffff;
    box-shadow: 0 0 0 2px rgba(9,132,227,0.15);
}

/* ===== BUTTONS ===== */
.btn-login {
    height: 50px;
    border-radius: 16px;
    background: linear-gradient(135deg, #0984e3, #0652dd);
    color: white;
    font-weight: 600;
    font-size: 15px;
    letter-spacing: 0.3px;
    border: none;
    box-shadow: 0 8px 20px rgba(9,132,227,0.45);
}

.btn-login:hover {
    box-shadow: 0 12px 30px rgba(9,132,227,0.6);
}

/* ===== ALERTS ===== */
.alert {
    font-size: 13px;
    padding: 10px;
    border-radius: 8px;
}

/* ===== FOOTER ===== */
.login-footer {
    font-size: 11px;
    color: #636e72;
    margin-top: 18px;
    line-height: 1.5;
}

/* ===== SECURITY BADGE ===== */
.secure-badge {
    margin-top: 14px;
    font-size: 11px;
    color: #27ae60;
    font-weight: 600;
    letter-spacing: 0.4px;
}
</style>
</head>

<body>

<div class="login-wrapper">

    <!-- SUCCESS MESSAGE -->
    <%
        String succMsg = (String) session.getAttribute("succMsg");
        if (succMsg != null) {
    %>
        <div class="alert alert-success text-center"><%= succMsg %></div>
    <%
        session.removeAttribute("succMsg");
        }
    %>

    <!-- ERROR MESSAGE -->
    <%
        String errorMsg = (String) session.getAttribute("errorMsg");
        if (errorMsg != null) {
    %>
        <div class="alert alert-danger text-center"><%= errorMsg %></div>
    <%
        session.removeAttribute("errorMsg");
        }
    %>

    <!-- BRAND -->
    <div class="brand-logo">
        <img src="/Complaint-Management-System/img/nflimage.png" alt="NFL Logo">
    </div>

    <!-- COMPANY -->
    <div class="brand-title">
        National Fertilizers Limited<br>
          Panipat Unit
    </div>

    <!-- SYSTEM NAME (PRIMARY) -->
    <div class="brand-subtitle">
      
        Complaint Management Portal
    </div>

    <!-- LOGIN FORM -->
    <form action="login" method="post">

    <div class="form-group">
        <label>Employee ID / Mobile Number</label>
        <input type="text"
               class="form-control"
               name="empn"
               placeholder="Enter your Employee ID"
               required>
    </div>

    <div class="form-group">
        <label>Password</label>
        <input type="password"
               class="form-control"
               name="password"
               placeholder="Enter your password"
               required>
    </div>

    <button type="submit" class="btn btn-login btn-block mt-3">
        <i class="fas fa-lock"></i> Secure Login
    </button>

    <button type="reset" class="btn btn-secondary btn-block mt-2">
        Cancel
    </button>

    <!-- REGISTER BUTTON -->
    <button type="button"
            class="btn btn-outline-primary btn-block mt-2"
            onclick="location.href='register.jsp'">
        <i class="fas fa-user-plus"></i> Register
    </button>

</form>


    <div class="secure-badge">
        <i class="fas fa-shield-alt"></i> Secure Government System
    </div>

    <div class="login-footer">
        For optimal performance, use the latest version of
        Google Chrome or Microsoft Edge.
    </div>

</div>

</body>
</html>
