<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entity.User" %>

<%
    // ===== SESSION & ROLE CHECK =====
    User user = (User) session.getAttribute("Userobj");

    if (user == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
    if (!user.getRole().equals("AC") && !user.getRole().equals("AE")) {
        response.sendRedirect("../home.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin | Add Complaint</title>

<%@ include file="allCss.jsp" %>

<style>
/* ===== BASE ===== */
body {
    font-family: "Segoe UI", Roboto, Arial;
    background-color: #f4f6f9;
}

/* ===== SIDEBAR ===== */
/* Sidebar */
.sidebar {
    height: 100vh;
    background: #1e272e;
    color: #fff;
    position: fixed;
    width: 240px;
    padding-top: 30px;
}

.sidebar a {
    color: #dcdde1;
    display: block;
    padding: 12px 25px;
    text-decoration: none;
}

.sidebar a.active,
.sidebar a:hover {
    background: #485460;
    color: #fff;
}

/* ===== MAIN AREA ===== */
.admin-main {
    margin-left: 240px;
    padding: 25px;
}

/* ===== HEADER ===== */
.admin-header {
    background: #ffffff;
    padding: 20px 26px;
    border-radius: 14px;
    box-shadow: 0 6px 16px rgba(0,0,0,0.08);
    margin-bottom: 28px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.admin-title {
    font-size: 20px;
    font-weight: 600;
}

.admin-breadcrumb {
    font-size: 13px;
    color: #6c757d;
    margin-top: 2px;
}

/* ===== FORM CARD ===== */
.form-wrapper {
    background: #ffffff;
    border-radius: 16px;
    box-shadow: 0 12px 30px rgba(0,0,0,0.12);
    padding: 30px;
}

.section-title {
    font-size: 15px;
    font-weight: 600;
    margin-bottom: 18px;
    border-bottom: 1px solid #dee2e6;
    padding-bottom: 6px;
}

.form-control,
.form-control-file {
    border-radius: 8px;
}

/* Submit */
.submit-btn {
    padding: 12px;
    font-weight: 600;
    font-size: 15px;
}

/* ===== DARK MODE ===== */
html.dark-mode body {
    background-color: #1e272e;
    color: #f5f6fa;
}

html.dark-mode .admin-header,
html.dark-mode .form-wrapper {
    background-color: #2f3640;
    color: #f5f6fa;
}

html.dark-mode .admin-breadcrumb {
    color: #b2bec3;
}

html.dark-mode label {
    color: #f5f6fa;
}

html.dark-mode input,
html.dark-mode textarea,
html.dark-mode select {
    background-color: #353b48;
    color: #f5f6fa;
    border: 1px solid #636e72;
}

html.dark-mode .sidebar {
    background-color: #020617;
}
</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<!-- ===== SIDEBAR ===== -->
<div class="sidebar">

    <h4 class="text-center mb-4">Admin Panel</h4>

    <a href="home.jsp">
        <i class="fas fa-home mr-2"></i> Dashboard
    </a>

    <a href="manageUsers.jsp">
        <i class="fas fa-users mr-2"></i> User Management
    </a>

    <a href="addComplaint.jsp" class="active">
        <i class="fas fa-plus-circle mr-2"></i> Add Complaint
    </a>

    <a href="pendingComplaints.jsp">
        <i class="fas fa-hourglass-half mr-2"></i> Pending Complaints
    </a>

    <a href="viewComplaints.jsp">
        <i class="fas fa-list mr-2"></i> View All Complaints
    </a>
    <a href="complaintReport.jsp" ><i class="fas fa-file-alt mr-2"></i> Complaint Report</a>

    <a href="changePassword.jsp">
        <i class="fas fa-key mr-2"></i> Change Password
    </a>

    <a href="../logout">
        <i class="fas fa-sign-out-alt mr-2"></i> Logout
    </a>

</div>


<!-- ===== MAIN CONTENT ===== -->
<div class="admin-main">

    <!-- HEADER -->
    <div class="admin-header">
        <div>
            <div class="admin-title">Add Complaint</div>
            <div class="admin-breadcrumb">
                Admin Panel / Complaints / Add Complaint
            </div>
        </div>

        <button class="btn btn-sm btn-dark" onclick="toggleDarkMode()">
            <i class="fas fa-moon"></i> Dark Mode
        </button>
    </div>

    <!-- FORM -->
    <div class="form-wrapper">

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

        <!-- FAILED MESSAGE -->
        <%
            String failedMsg = (String) session.getAttribute("failedMsg");
            if (failedMsg != null) {
        %>
            <div class="alert alert-danger text-center"><%= failedMsg %></div>
        <%
            session.removeAttribute("failedMsg");
            }
        %>

        <form id="addcomp" action="../addcomplaint" method="post" enctype="multipart/form-data">

            <div class="row">

                <!-- LEFT -->
                <div class="col-md-6">
                    <div class="section-title">Complaint Details</div>

                    <%
    String complaintCategory = "";
    if ("AC".equals(user.getRole())) {
        complaintCategory = "Civil";
    } else if ("AE".equals(user.getRole())) {
        complaintCategory = "Electrical";
    }
%>

<div class="form-group">
    <label>Complaint Category</label>

    <!-- Read-only visible field -->
    <input type="text"
           class="form-control"
           value="<%= complaintCategory %>"
           readonly>

    <!-- Hidden field actually submitted -->
    <input type="hidden"
           name="category"
           value="<%= complaintCategory %>">
</div>
<div class="form-group">
    <label>Complaint Type</label>
    <select name="complaintType" id="complaintType"
            class="form-control" required>
        <option value="">-- Select Complaint Type --</option>
    </select>
</div>



                    <div class="form-group">
                        <label>Complaint Title</label>
                        <input name="title" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label>Complaint Description</label>
                        <textarea name="description" rows="3"
                                  class="form-control" required></textarea>
                    </div>

                    <div class="form-row">
                        <div class="col-md-4">
                            <label>Qtr Type</label>
                            <select id="qtrnoSelect" class="form-control" required>
                                <option value="">Select</option>
                                <option>A</option>
                                <option>B</option>
                                <option>C</option>
                                <option>D</option>
                                <option>Misc</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label>Qtr No</label>
                            <input id="qtrnoBlock1" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label>Ext</label>
                            <input id="qtrnoBlock2" class="form-control"
                                   placeholder="0 if none" required>
                        </div>
                    </div>

                    <input type="hidden" id="qtrno" name="qtrno">
                </div>

                <!-- RIGHT -->
                <div class="col-md-6">
                    <div class="section-title">User & Contact Information</div>

                    <div class="form-group">
                        <label>Employee No / Mobile No</label>
                        <input name="empn" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label>User Name</label>
                        <input name="username" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label>Contact Number</label>
                        <input name="phone" type="number"
                               class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label>Upload Photo (Optional)</label>
                        <input name="imagefile" type="file"
                               class="form-control-file" >
                    </div>
                </div>

            </div>

            <hr>

            <button type="submit"
                    class="btn btn-primary btn-block submit-btn">
                <i class="fas fa-paper-plane"></i> Submit Complaint
            </button>

        </form>
    </div>

</div>

<!-- ===== QUARTER SCRIPT ===== -->
<script>
document.getElementById('addcomp').addEventListener('submit', function (e) {
    const p = qtrnoSelect.value,
          b1 = qtrnoBlock1.value,
          b2 = qtrnoBlock2.value;

    if (!p || !b1 || !b2) {
        alert("Please fill all Quarter Number fields.");
        e.preventDefault();
        return;
    }

    qtrno.value = p + "-" + b1 + "/" + b2;
});
</script>
<script>
document.addEventListener("DOMContentLoaded", function () {

    const complaintType = document.getElementById("complaintType");

    // Category is role-based & fixed
    const category = "<%= complaintCategory %>";

    // Reset
    complaintType.innerHTML =
        '<option value="">-- Select Complaint Type --</option>';

    if (category === "Civil") {
        ["Mason", "Carpenter", "Plumber", "Other"].forEach(type => {
            const opt = document.createElement("option");
            opt.value = type;
            opt.textContent = type;
            complaintType.appendChild(opt);
        });
    }

    if (category === "Electrical") {
        const opt = document.createElement("option");
        opt.value = "Electrical";
        opt.textContent = "Electrical";
        complaintType.appendChild(opt);
    }
});
</script>

</body>
</html>
