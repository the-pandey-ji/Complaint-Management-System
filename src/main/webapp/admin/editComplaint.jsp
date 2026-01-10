<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.ComplaintDAOImpl"%>
<%@page import="com.entity.Complaintdtls"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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

    int id = Integer.parseInt(request.getParameter("id"));
    ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
    Complaintdtls complaint = dao.getComplaintById(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin | Edit Complaint</title>

<%@ include file="allCss.jsp" %>

<style>
/* ===== BASE ===== */
body {
    font-family: "Segoe UI", Roboto, Arial;
    background-color: #f4f6f9;
}

/* ===== SIDEBAR ===== */
.sidebar {
    height: 100vh;
    background: #1e272e;
    color: white;
    position: fixed;
    width: 240px;
    padding-top: 30px;
}

.sidebar h4 {
    text-align: center;
    margin-bottom: 30px;
}

.sidebar a {
    color: #dcdde1;
    display: block;
    padding: 12px 25px;
    text-decoration: none;
}

.sidebar a:hover {
    background: #485460;
    color: white;
}


/* ===== MAIN ===== */
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

/* ===== IMAGE PREVIEW ===== */
.image-preview {
    width: 120px;
    height: 120px;
    border-radius: 10px;
    object-fit: cover;
    border: 1px solid #ccc;
    margin-bottom: 10px;
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

html.dark-mode .admin-sidebar {
    background-color: #020617;
}
</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">

    <h4 class="text-center mb-4">Admin Panel</h4>

    <a href="home.jsp">
        <i class="fas fa-home mr-2"></i> Dashboard
    </a>

    <a href="manageUsers.jsp">
        <i class="fas fa-users mr-2"></i> User Management
    </a>

    <a href="addComplaint.jsp" >
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
            <div class="admin-title">Edit Complaint</div>
            <div class="admin-breadcrumb">
                Admin Panel / Complaints / Edit Complaint
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

        <form action="../complaintEdit" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= complaint.getid() %>">

            <div class="row">

                <!-- LEFT -->
                <div class="col-md-6">
                    <div class="section-title">Complaint Details</div>

                    <div class="form-group">
                        <label>Complaint Category</label>
                        <select name="category" class="form-control">
                            <option value="<%= complaint.getCategory() %>" selected>
                                <%= complaint.getCategory() %>
                            </option>
                            
                        </select>
                    </div>
                    <!-- COMPLAINT TYPE -->
					<div class="form-group">
					    <label>Complaint Type</label>
					    <select name="complaintType" id="complaintType" class="form-control" required>
					        <option value="<%= complaint.getComplaintType() %>" selected>
					            <%= complaint.getComplaintType() %>
					        </option>
					    </select>
					</div>

				

                    <div class="form-group">
                        <label>Complaint Title</label>
                        <input name="title" class="form-control"
                               value="<%= complaint.getTitle() %>" disabled>
                    </div>

                    <div class="form-group">
                        <label>Complaint Description</label>
                        <textarea name="description" rows="3"
                                  class="form-control"><%= complaint.getDescription() %></textarea>
                    </div>

                    <div class="form-group">
                        <label>Quarter No</label>
                        <input name="qtrno" class="form-control"
                               value="<%= complaint.getQtrno() %>">
                    </div>
                </div>

                <!-- RIGHT -->
                <div class="col-md-6">
                    <div class="section-title">User & Status</div>

                    <div class="form-group">
                        <label>Employee No</label>
                        <input name="empn" class="form-control"
                               value="<%= complaint.getEmpn() %>">
                    </div>

                    <div class="form-group">
                        <label>User Name</label>
                        <input name="username" class="form-control"
                               value="<%= complaint.getUsername() %>">
                    </div>

                    <div class="form-group">
                        <label>Contact Number</label>
                        <input name="phone" type="number"
                               class="form-control"
                               value="<%= complaint.getPhone() %>">
                    </div>

                    <div class="form-group">
                        <label>Complaint Date</label>
                        <input class="form-control" readonly
                               value="<%= complaint.getCreatedate() %>">
                    </div>

                    <div class="form-group">
                        <label>Current Image</label><br>
                        <img src="../images/<%= complaint.getImage() %>"
                             class="image-preview">
                    </div>

                    <div class="form-group">
                        <label>Upload New Image</label>
                        <input name="imagefile" type="file"
                               class="form-control-file">
                    </div>
                </div>

            </div>

            <hr>

            <button type="submit"
                    class="btn btn-primary btn-block">
                <i class="fas fa-save"></i> Update Complaint
            </button>

        </form>
    </div>

</div>
<script>
document.getElementById("category").addEventListener("change", function () {
    const typeSelect = document.getElementById("complaintType");
    const category = this.value;

    // Reset
    typeSelect.innerHTML = '<option value="">-- Select Complaint Type --</option>';

    if (category === "Civil") {
        ["Mason", "Carpenter", "Plumber", "Other"].forEach(type => {
            const opt = document.createElement("option");
            opt.value = type;
            opt.textContent = type;
            typeSelect.appendChild(opt);
        });
    }

    if (category === "Electrical") {
        const opt = document.createElement("option");
        opt.value = "Electrical";
        opt.textContent = "Electrical";
        typeSelect.appendChild(opt);
    }
});
</script>
</body>
</html>
