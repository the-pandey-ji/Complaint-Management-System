<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="all_component/allCss.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Register | Complaint Management System</title>

<style>
/* CARD */
.register-card {
    max-width: 650px;
    margin: auto;
    border-radius: 16px;
    box-shadow: 0 12px 30px rgba(0,0,0,0.15);
    border: none;
}

/* HEADINGS */
.register-title {
    font-weight: 700;
    color: #0b6b3a;
}
.register-subtitle {
    font-size: 13px;
    color: #6c757d;
}

/* FORM */
.form-control {
    border-radius: 10px;
    font-size: 14px;
}

label {
    font-size: 13px;
    font-weight: 600;
    color: #333;
}

/* SECTION DIVIDER */
.section-title {
    font-size: 14px;
    font-weight: 600;
    color: #1e8f5a;
    margin-top: 20px;
    margin-bottom: 10px;
}

/* BUTTON */
.btn-register {
    border-radius: 12px;
    font-weight: 600;
    padding: 8px;
}
</style>
</head>

<body>

<!-- ===== HEADER (UNCHANGED – YOUR APPROVED VERSION) ===== -->


<!-- TOP ACCENT BAR -->
<div class="container-fluid p-0">
    <div style="height:4px;background:#0b6b3a;"></div>
</div>

<!-- HEADER -->
<div class="container-fluid bg-white shadow-sm py-2">
    <div class="row align-items-center">

        <!-- LEFT: LOGO + BRAND NAME INLINE -->
        <div class="col-md-4 d-flex align-items-center">
            <img src="/Complaint-Management-System/nflimage.png"
                 alt="NFL Logo"
                 style="height:70px;"
                 class="mr-3">

            <h4 class="mb-0 text-primary">
                <i class="fas fa-tools mr-2"></i>
                Complaint Management System
            </h4>
        </div>

        <!-- CENTER: COMPANY NAME -->
        <div class="col-md-4 text-center">
            <div style="line-height:1.3;">
                <h3 class="mb-0 font-weight-bold text-success text-uppercase">
                    National Fertilizers Limited
                </h3>
                <h5 class="mb-0 font-weight-bold text-danger text-uppercase">
                    Panipat Unit
                </h5>
            </div>
        </div>



    </div>
</div>

<!-- SECOND ACCENT BAR -->
<div class="container-fluid p-0">
    <div style="height:4px;background:linear-gradient(90deg,#0b6b3a,#1e8f5a);"></div>
</div>


<!-- ===== REGISTER CARD ===== -->
<div class="container py-5">

    <div class="card register-card">
        <div class="card-body p-4">

            <h4 class="text-center register-title">
                User Registration
            </h4>
            <p class="text-center register-subtitle mb-4">
                National Fertilizers Limited – Panipat Unit
            </p>

            <!-- ERROR MESSAGE -->
            <%
                String failedMsg = (String) session.getAttribute("failedMsg");
                if (failedMsg != null) {
            %>
                <div class="alert alert-danger text-center">
                    <%= failedMsg %>
                </div>
            <%
                session.removeAttribute("failedMsg");
                }
            %>

            <form id="registerForm" action="register" method="post">

                <!-- BASIC INFO -->
                <div class="form-group">
                    <label>Employee ID / Mobile No.</label>
                    <input type="number" class="form-control"
                           name="empn" required>
                </div>

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" class="form-control"
                           name="username" required>
                </div>

                <!-- QUARTER SECTION -->
                <div class="section-title">
                    Quarter Details
                </div>

                <div class="form-row">
                    <div class="col-md-4">
                        <label>Qtr Type</label>
                        <select id="qtrnoSelect" class="form-control" required>
                            <option value="">Select</option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="C">C</option>
                            <option value="D">D</option>
                            <option value="Misc">Misc</option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label>Qtr No</label>
                        <input type="text" id="qtrnoBlock1"
                               class="form-control" required>
                    </div>

                    <div class="col-md-4">
                        <label>Extension</label>
                        <input type="text" id="qtrnoBlock2"
                               class="form-control"
                               placeholder="0 if none"
                               required>
                    </div>
                </div>

                <!-- HIDDEN COMBINED VALUE -->
                <input type="hidden" id="qtrno" name="qtrno">

                <!-- CONTACT -->
                <div class="section-title">
                    Contact Details
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" class="form-control"
                           name="email" required>
                </div>

                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" class="form-control"
                           name="phone" required>
                </div>

                <!-- SECURITY -->
                <div class="section-title">
                    Security
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" class="form-control"
                           name="password" required>
                </div>

                <!-- ACTION -->
                <div class="text-center mt-4">
                    <button type="submit"
                            class="btn btn-success btn-register btn-block">
                        <i class="fas fa-user-plus mr-1"></i>
                        Register
                    </button>
                     </div>
                    
                    <div class="text-center mt-2">
    <a href="index.jsp" class="btn btn-outline-secondary btn-block">
        <i class="fas fa-arrow-left mr-1"></i>
        Back to Login
    </a>
</div>
               

            </form>
        </div>
    </div>
</div>

<%@ include file="all_component/footer.jsp" %>

<!-- ===== QUARTER CONCAT JS (UNCHANGED LOGIC) ===== -->
<script>
document.addEventListener('DOMContentLoaded', function () {
  const form = document.getElementById('registerForm');
  form.addEventListener('submit', function (event) {

    const prefix = document.getElementById('qtrnoSelect').value;
    const block1 = document.getElementById('qtrnoBlock1').value;
    const block2 = document.getElementById('qtrnoBlock2').value;

    if (!prefix || !block1 || !block2) {
      alert("Please fill all Quarter Number fields.");
      event.preventDefault();
      return;
    }

    document.getElementById('qtrno').value =
        prefix + "-" + block1 + "/" + block2;
  });
});
</script>

</body>
</html>
