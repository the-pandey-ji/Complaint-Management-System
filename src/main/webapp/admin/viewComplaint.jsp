<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.entity.User" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.DAO.ComplaintDAOImpl" %>
<%@ page import="com.entity.Complaintdtls" %>

<%
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
    Complaintdtls c = dao.getComplaintById(id);

    if (c == null) {
        out.println("<h3>Complaint not found</h3>");
        return;
    }

    // ✅ Closed Date formatted
    String closedDateStr = "—";
    try {
        Connection connCD = DBConnect.getConnection();
        String sqlCD =
            "SELECT TO_CHAR(CLOSED_DATE,'DD-MON-YYYY HH:MI AM') AS CD " +
            "FROM CTRACK.COMPLAINTDTLS WHERE ID=?";
        PreparedStatement psCD = connCD.prepareStatement(sqlCD);
        psCD.setInt(1, id);
        ResultSet rsCD = psCD.executeQuery();
        if (rsCD.next()) {
            String temp = rsCD.getString("CD");
            if (temp != null && !temp.trim().isEmpty()) closedDateStr = temp;
        }
        rsCD.close();
        psCD.close();
    } catch(Exception e) {
        e.printStackTrace();
    }

    // ✅ Feedback fetch
    boolean feedbackFound = false;
    int fbRating = 0;
    String fbMessage = "";
    String fbImage = "";
    String fbCreatedAt = "";

    if (c.getStatus() != null && c.getStatus().equalsIgnoreCase("Closed")) {
        try {
            Connection connFB = DBConnect.getConnection();
            String sqlFB =
                "SELECT RATING, MESSAGE, IMAGEFILE, " +
                "TO_CHAR(CREATED_AT,'DD-MON-YYYY HH:MI AM') AS CRT " +
                "FROM CTRACK.COMPLAINT_FEEDBACK " +
                "WHERE COMPLAINT_ID=?";

            PreparedStatement psFB = connFB.prepareStatement(sqlFB);
            psFB.setInt(1, c.getid());

            ResultSet rsFB = psFB.executeQuery();
            if (rsFB.next()) {
                feedbackFound = true;
                fbRating = rsFB.getInt("RATING");
                fbMessage = rsFB.getString("MESSAGE");
                fbImage = rsFB.getString("IMAGEFILE");
                fbCreatedAt = rsFB.getString("CRT");
            }

            rsFB.close();
            psFB.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Complaint #<%= c.getid() %></title>

<%@ include file="allCss.jsp" %>

<style>
body{
    background:#f4f6f9;
    font-family: "Segoe UI", Roboto, Arial;
}

/* Sidebar */
.sidebar{
    height:100vh;
    width:240px;
    position:fixed;
    left:0;
    top:0;
    background:#1e272e;
    color:#fff;
    padding-top:30px;
    overflow-y:auto;
}
.sidebar a{
    color:#dcdde1;
    display:block;
    padding:12px 25px;
    text-decoration:none;
}
.sidebar a:hover{
    background:#485460;
    color:#fff;
}

/* Main */
.main{
    margin-left:240px;
    padding:18px;
}

/* Header */
.topbar{
    background:#ffffff;
    border-radius:14px;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
    padding:16px 20px;
    margin-bottom:18px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    flex-wrap:wrap;
    gap:10px;
}
.topbar h5{
    margin:0;
    font-weight:800;
    color:#111827;
}
.topbar small{
    color:#6b7280;
}

/* Layout grid */
.detail-grid{
    display:grid;
    grid-template-columns: 1.3fr 1fr;
    gap:18px;
}

/* Image panel */
.image-panel{
    background:#000;
    border-radius:16px;
    overflow:hidden;
    min-height:420px;
    box-shadow:0 10px 30px rgba(0,0,0,0.20);
}
.image-panel img{
    width:100%;
    height:100%;
    object-fit:contain;
    display:block;
}

/* Cards */
.card-box{
    background:#ffffff;
    border-radius:16px;
    box-shadow:0 10px 25px rgba(0,0,0,0.10);
    padding:18px;
    margin-bottom:16px;
}
.card-title{
    font-weight:800;
    font-size:15px;
    color:#111827;
    margin-bottom:12px;
    display:flex;
    align-items:center;
    gap:8px;
}

/* Key-value table */
.kv{
    display:grid;
    grid-template-columns: 120px 1fr;
    gap:10px 12px;
    font-size:14px;
}
.kv .k{
    color:#6b7280;
    font-weight:700;
    text-transform:uppercase;
    font-size:12px;
}
.kv .v{
    color:#111827;
    font-weight:600;
    white-space:pre-wrap;
    word-break:break-word;
}

/* Status badge */
.badge-status{
    display:inline-flex;
    align-items:center;
    gap:6px;
    padding:4px 10px;
    border-radius:999px;
    font-size:12px;
    font-weight:800;
    letter-spacing:.3px;
    text-transform:uppercase;
}
.badge-status.closed{
    background:#ecfdf5;
    border:1px solid #6ee7b7;
    color:#065f46;
}
.badge-status.open{
    background:#fff7ed;
    border:1px solid #fdba74;
    color:#9a3412;
}

/* Feedback stars */
.stars{
    font-size:26px;
    display:flex;
    gap:5px;
    margin-top:6px;
}
.star{ color:#cbd5e1; }
.star.active{ color:#f59e0b; }

.feedback-msg{
    background:#f8fafc;
    border:1px solid #e2e8f0;
    padding:12px;
    border-radius:12px;
    font-size:14px;
    line-height:1.6;
    margin-top:8px;
    white-space:pre-wrap;
}
.fb-img{
    width:230px;
    max-width:100%;
    border-radius:14px;
    margin-top:10px;
    border:1px solid #ddd;
    display:block;
}

/* Responsive */
@media(max-width:992px){
    .detail-grid{
        grid-template-columns: 1fr;
    }
    .image-panel{
        min-height:320px;
    }
}
@media(max-width:768px){
    .sidebar{
        position:relative;
        width:100%;
        height:auto;
    }
    .main{
        margin-left:0;
        padding:12px;
    }
    .kv{
        grid-template-columns: 1fr;
    }
}

/* Dark mode */
html.dark-mode body{ background:#1e272e; color:#f5f6fa; }
html.dark-mode .topbar,
html.dark-mode .card-box{
    background:#2f3640;
    color:#f5f6fa;
}
html.dark-mode .kv .k{ color:#b2bec3; }
html.dark-mode .kv .v{ color:#f5f6fa; }
html.dark-mode .feedback-msg{
    background:#353b48;
    border-color:#636e72;
}
</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h4 class="text-center mb-4">Admin Panel</h4>

    <a href="home.jsp"><i class="fas fa-home mr-2"></i> Dashboard</a>
    <a href="manageUsers.jsp"><i class="fas fa-users mr-2"></i> User Management</a>
    <a href="addComplaint.jsp"><i class="fas fa-plus-circle mr-2"></i> Add Complaint</a>
    <a href="pendingComplaints.jsp"><i class="fas fa-hourglass-half mr-2"></i> Pending Complaints</a>
    <a href="viewComplaints.jsp"><i class="fas fa-list mr-2"></i> View All Complaints</a>
    <a href="complaintReport.jsp"><i class="fas fa-file-alt mr-2"></i> Complaint Report</a>
    <a href="changePassword.jsp"><i class="fas fa-key mr-2"></i> Change Password</a>
    <a href="../logout"><i class="fas fa-sign-out-alt mr-2"></i> Logout</a>
</div>

<!-- MAIN -->
<div class="main">

    <!-- TOP BAR -->
    <div class="topbar">
        <div>
            <h5>Complaint #<%= c.getid() %></h5>
            <small><b>Category:</b> <%= c.getCategory() %> | <b>Type:</b> <%= c.getComplaintType() %></small>
        </div>

        <div style="display:flex;gap:10px;align-items:center;">
            <span class="badge-status <%= c.getStatus().equalsIgnoreCase("Closed") ? "closed" : "open" %>">
                <i class="<%= c.getStatus().equalsIgnoreCase("Closed") ? "fas fa-check-circle" : "fas fa-clock" %>"></i>
                <%= c.getStatus() %>
            </span>

            <button class="btn btn-sm btn-dark" onclick="toggleDarkMode()">
                <i class="fas fa-moon"></i>
            </button>
        </div>
    </div>

    <div class="detail-grid">

        <!-- LEFT IMAGE -->
        <div class="image-panel">
            <img src="../images/<%= c.getImage() %>" alt="Complaint Image">
        </div>

        <!-- RIGHT DETAILS -->
        <div>

            <!-- Complaint Details -->
            <div class="card-box">
                <div class="card-title"><i class="fas fa-info-circle"></i> Complaint Details</div>

                <div class="kv">
                    <div class="k">Title</div><div class="v"><%= c.getTitle() %></div>
                    <div class="k">Description</div><div class="v"><%= c.getDescription() %></div>
                    <div class="k">Quarter</div><div class="v"><%= c.getQtrno() %></div>
                    <div class="k">Created</div><div class="v"><%= c.getCreatedate() %></div>
                    <div class="k">Closed</div><div class="v"><%= closedDateStr %></div>
                    <div class="k">Action</div>
                    <div class="v"><%= (c.getAction()!=null && !c.getAction().trim().isEmpty()) ? c.getAction() : "—" %></div>
                </div>
            </div>

            <!-- User Details -->
            <div class="card-box">
                <div class="card-title"><i class="fas fa-user"></i> User Details</div>

                <div class="kv">
                    <div class="k">Emp No</div><div class="v"><%= c.getEmpn() %></div>
                    <div class="k">Name</div><div class="v"><%= c.getUsername() %></div>
                    <div class="k">Phone</div><div class="v"><%= c.getPhone() %></div>
                </div>
            </div>

            <!-- Feedback -->
            <% if (c.getStatus() != null && c.getStatus().equalsIgnoreCase("Closed")) { %>
                <div class="card-box">
                    <div class="card-title"><i class="fas fa-star"></i> Feedback</div>

                    <% if (!feedbackFound) { %>
                        <div style="color:#6b7280;font-weight:600;">
                            Feedback not submitted yet.
                        </div>
                    <% } else { %>

                        <div class="kv">
                            <div class="k">Rating</div>
                            <div class="v">
                                <div class="stars">
                                    <span class="star <%= (fbRating>=1?"active":"") %>">&#9733;</span>
                                    <span class="star <%= (fbRating>=2?"active":"") %>">&#9733;</span>
                                    <span class="star <%= (fbRating>=3?"active":"") %>">&#9733;</span>
                                    <span class="star <%= (fbRating>=4?"active":"") %>">&#9733;</span>
                                    <span class="star <%= (fbRating>=5?"active":"") %>">&#9733;</span>
                                </div>
                            </div>

                            <div class="k">Date</div><div class="v"><%= fbCreatedAt %></div>
                        </div>

                        <div class="feedback-msg"><%= fbMessage %></div>

                        <% if (fbImage != null && !fbImage.trim().isEmpty()) { %>
                            <img src="../feedback_images/<%= fbImage %>" class="fb-img" alt="Feedback Photo">
                        <% } %>

                    <% } %>
                </div>
            <% } %>

        </div>

    </div>
</div>

</body>
</html>
