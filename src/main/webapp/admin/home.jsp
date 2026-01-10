<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.entity.User" %>
<%@ page import="com.DAO.ComplaintDAOImpl" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="java.sql.Connection" %>

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

    // ===== ROLE → CATEGORY MAPPING =====
    String category = "";
    if (user.getRole().equals("AC")) {
        category = "Civil";
    } else if (user.getRole().equals("AE")) {
        category = "Electrical";
    }

    // ===== REAL-TIME DATA =====
    Connection con = DBConnect.getConnection();
    ComplaintDAOImpl dao = new ComplaintDAOImpl(con);

    int totalCount  = dao.getTotalComplaintCountByCategory(category);
    int openCount   = dao.getOpenComplaintCountByCategory(category);
    int closedCount = dao.getClosedComplaintCountByCategory(category);
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>

<%@ include file="allCss.jsp" %>

<style>
/* ===== BASE ===== */
body {
    font-family: "Segoe UI", Roboto, Arial;
    background-color: #f5f6fa;
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
.main {
    margin-left: 240px;
    padding: 30px;
}

/* ===== KPI CARDS ===== */
.stat-card {
    border-radius: 18px;
    padding: 30px;
    color: white;
    box-shadow: 0 12px 28px rgba(0,0,0,0.18);
}

.stat-total {
    background: linear-gradient(135deg, #0984e3, #74b9ff);
}

.stat-open {
    background: linear-gradient(135deg, #fdcb6e, #e17055);
}

.stat-closed {
    background: linear-gradient(135deg, #00b894, #55efc4);
}

.stat-card h6 {
    font-size: 14px;
    font-weight: 600;
    opacity: 0.9;
}

.stat-card h2 {
    font-size: 38px;
    font-weight: 700;
    margin: 0;
}

/* ===== ACTION CARDS ===== */
.action-card {
    background: white;
    border-radius: 14px;
    padding: 30px;
    text-align: center;
    box-shadow: 0 10px 25px rgba(0,0,0,0.12);
    transition: 0.3s;
}

.action-card:hover {
    transform: translateY(-6px);
}

.action-card i {
    font-size: 42px;
    color: #0984e3;
}

/* ===== TABLE CARD ===== */
.table-card {
    background: white;
    border-radius: 14px;
    padding: 25px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.12);
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

<!-- ===== MAIN ===== -->
<div class="main">

    <!-- HEADER -->
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <div>
            <h3>Welcome, <%= user.getUsername() %></h3>
            <p class="text-muted mb-0">
                <%= category %> Complaint Management Dashboard
            </p>
        </div>
        <button class="btn btn-sm btn-outline-dark" onclick="toggleDarkMode()">
    <i class="fas fa-moon"></i> Dark Mode
</button>
    </div>

    <!-- ===== KPI CARDS ===== -->
    <div class="row mb-4">

        <div class="col-md-4">
            <div class="stat-card stat-total">
                <h6>Total <%= category %> Complaints</h6>
                <h2><%= totalCount %></h2>
            </div>
        </div>

        <div class="col-md-4">
            <a href="viewComplaints.jsp?filter=open" style="text-decoration:none;">
                <div class="stat-card stat-open">
                    <h6>Open <%= category %> Complaints</h6>
                    <h2><%= openCount %></h2>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <div class="stat-card stat-closed">
                <h6>Closed <%= category %> Complaints</h6>
                <h2><%= closedCount %></h2>
            </div>
        </div>

    </div>
    
    <!-- ===== EXTRA KPI CARDS ===== -->
    
    <%
int pendingCount = openCount;   // already calculated via status
int resolvedToday = dao.getClosedComplaintCountByCategorytoday(category); // placeholder

/* double avgResolution = dao.getAvgResolutionDaysByCategory(category); */
int avgResolution = 1;
%>
    
<div class="row mb-4">

    <div class="col-md-3">
        <div class="stat-card" style="background:linear-gradient(135deg,#6c5ce7,#a29bfe)">
            <h6>Pending Complaints</h6>
            <h2><%= pendingCount %></h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stat-card" style="background:linear-gradient(135deg,#00cec9,#81ecec)">
            <h6>Resolved Today</h6>
            <h2><%= resolvedToday %></h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stat-card" style="background:linear-gradient(135deg,#e17055,#fab1a0)">
            <h6>Avg Resolution (Days)</h6>
            <h2><%= avgResolution %></h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stat-card" style="background:linear-gradient(135deg,#d63031,#ff7675)">
            <h6>Needs Attention</h6>
            <h2><%= pendingCount > 10 ? pendingCount : 0 %></h2>
        </div>
    </div>

</div>
    
    
    
      <!-- ===== ACTIONS ===== -->
    <div class="row mb-4">

        <div class="col-md-6">
            <a href="addComplaint.jsp">
                <div class="action-card">
                    <i class="fas fa-plus-circle"></i>
                    <h5>Add Complaint</h5>
                    <p>Create a new complaint</p>
                </div>
            </a>
        </div>

        <div class="col-md-6">
            <a href="viewComplaints.jsp">
                <div class="action-card">
                    <i class="fas fa-folder-open"></i>
                    <h5>Manage Complaints</h5>
                    <p>Edit & close complaints</p>
                </div>
            </a>
        </div>

        <!-- <div class="col-md-4">
            <a href="../logout">
                <div class="action-card">
                    <i class="fas fa-sign-out-alt"></i>
                    <h5>Logout</h5>
                    <p>Exit admin portal</p>
                </div>
            </a>
        </div> -->

    </div>
    <!-- ===== QUICK ACTIONS ===== -->
<div class="row mb-4">

    

    <div class="col-md-4">
        <a href="pendingComplaints.jsp">
            <div class="action-card">
                <i class="fas fa-hourglass-half"></i>
                <h5>Pending Complaints</h5>
                <p>View unresolved issues</p>
            </div>
        </a>
    </div>

   

    <div class="col-md-4">
        <a href="manageUsers.jsp">
            <div class="action-card">
                <i class="fas fa-users-cog"></i>
                <h5>User Management</h5>
                <p>Admin user controls</p>
            </div>
        </a>
    </div>
    
    <div class="col-md-4">
        <a href="../logout">
                <div class="action-card">
                    <i class="fas fa-sign-out-alt"></i>
                    <h5>Logout</h5>
                    <p>Exit admin portal</p>
                </div>
            </a>
    </div>

</div>
    
    
    
    <!-- ===== GRAPHS ===== -->
<div class="row mb-4">

    <!-- LARGE BAR CHART -->
    <div class="col-md-7">
        <div class="table-card">
            <h5 class="mb-3 text-center">
                <%= category %> Complaints Overview
            </h5>
            <canvas id="summaryBar" style="height:340px;"></canvas>
        </div>
    </div>

    <!-- SMALL PIE CHART -->
    <div class="col-md-4 ml-auto">
        <div class="table-card">
            <h6 class="mb-3 text-center">
                Status Distribution
            </h6>
            <canvas id="statusPie" style="height:220px;"></canvas>
        </div>
    </div>

</div>

  

</div>


<script>
/* ===== PIE CHART ===== */
const pieCtx = document.getElementById('statusPie').getContext('2d');
new Chart(pieCtx, {
    type: 'pie',
    data: {
        labels: ['Open', 'Closed'],
        datasets: [{
            data: [<%= openCount %>, <%= closedCount %>],
            backgroundColor: ['#f39c12', '#2ecc71'],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: 'bottom'
            }
        }
    }
});

/* ===== BAR CHART ===== */
const barCtx = document.getElementById('summaryBar').getContext('2d');
new Chart(barCtx, {
    type: 'bar',
    data: {
        labels: ['Total', 'Open', 'Closed'],
        datasets: [{
            label: 'Complaints',
            data: [<%= totalCount %>, <%= openCount %>, <%= closedCount %>],
            backgroundColor: ['#0984e3', '#fdcb6e', '#00b894']
        }]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    precision: 0
                }
            }
        }
    }
});
</script>

</body>
</html>
