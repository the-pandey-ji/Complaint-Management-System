<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.ComplaintDAOImpl"%>
<%@page import="com.entity.Complaintdtls"%>
<%@ page import="com.entity.User" %>
<%@ page import="java.sql.*" %>

<%
    User user = (User) session.getAttribute("Userobj");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Closed Complaints</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<%@include file="all_component/allCss.jsp"%>

<style>
/* ============ FOOTER ALWAYS BOTTOM ============ */
html, body {
    height: 100%;
}
.page-wrapper {
    min-height: 100%;
    display: flex;
    flex-direction: column;
}
.page-content {
    flex: 1;
}

/* ============ IMAGE SIZE (DOUBLE) ============ */
.complaint-img {
    width: 100px;
    height: 100px;
    border-radius: 8px;
    object-fit: cover;
}

/* ============ MOBILE CARD VIEW ============ */
.mobile-card {
    display: none;
    background: #fff;
    border-radius: 14px;
    padding: 16px;
    box-shadow: 0 4px 14px rgba(0,0,0,.15);
    margin-bottom: 14px;
    font-size: 14px;
}

.mobile-card h6 {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 8px;
}

.mobile-card small {
    display: block;
    margin-bottom: 6px;
}

/* ============ RESPONSIVE ============ */
@media (max-width: 768px) {
    table {
        display: none;
    }
    .mobile-card {
        display: block;
    }
}
</style>
</head>

<body>

<div class="page-wrapper">

    <%@include file="all_component/navbar.jsp"%>

    <div class="page-content">

        <h3 class="text-center mt-3">Closed Complaints</h3>

        <div class="container-fluid mt-3">

            <!-- ============ DESKTOP TABLE ============ -->
            <div class="table-responsive">
                <table class="table table-striped align-middle">
                    <thead class="bg-primary text-white">
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Category</th>
                            <th>Complaint Type</th>
                            <th>Complaint Title</th>
                            <th>Description</th>
                            <th>Date</th>
                            <th>Qtr No.</th>
                            <th>Phone</th>
                            <th>Status</th>
                            <th>Action Taken</th>
                            <th>Feedback</th>
                        </tr>
                    </thead>
                    <tbody>

                    <%
                        ComplaintDAOImpl dao =
                            new ComplaintDAOImpl(DBConnect.getConnection());

                        List<Complaintdtls> list =
                            dao.getUserClosedComplaints(user.getEmpn());

                        if (list != null && !list.isEmpty()) {
                            for (Complaintdtls c : list) {
                    %>
                        <tr>
                            <td><%= c.getid() %></td>
                            <td>
                                <img src="images/<%= c.getImage() %>"
                                     class="complaint-img">
                            </td>
                            <td><%= c.getCategory() %></td>
                            <td><%= c.getComplaintType() %></td>
                            <td><%= c.getTitle() %></td>
                            <td><%= c.getDescription() %></td>
                            <td><%= c.getCreatedate() %></td>
                            <td><%= c.getQtrno() %></td>
                            <td><%= c.getPhone() %></td>
                            <td><%= c.getStatus() %></td>
                            <td><%= c.getAction() %></td>

                            <!-- ✅ FEEDBACK COLUMN UPDATED -->
                            <td>
                                <%
                                    if ("Closed".equalsIgnoreCase(c.getStatus())) {

                                        boolean feedbackSubmitted = false;

                                        try {
                                            Connection conn = DBConnect.getConnection();

                                            String fbSql =
                                                "SELECT COUNT(*) FROM CTRACK.COMPLAINT_FEEDBACK " +
                                                "WHERE COMPLAINT_ID=? AND EMPN=?";

                                            PreparedStatement psFb = conn.prepareStatement(fbSql);
                                            psFb.setInt(1, c.getid());
                                            psFb.setLong(2, user.getEmpn());

                                            ResultSet rsFb = psFb.executeQuery();
                                            if (rsFb.next()) {
                                                feedbackSubmitted = rsFb.getInt(1) > 0;
                                            }

                                            rsFb.close();
                                            psFb.close();

                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }

                                        if (feedbackSubmitted) {
                                %>
                                            <span class="badge badge-success mb-2 d-inline-block">
                                                Feedback Submitted
                                            </span>
                                            <br>

                                            <a href="viewFeedback.jsp?id=<%= c.getid() %>"
                                               class="btn btn-sm btn-info">
                                               View Feedback
                                            </a>
                                <%
                                        } else {
                                %>
                                            <span class="badge badge-warning mb-2 d-inline-block">
                                                Pending Feedback
                                            </span>
                                            <br>

                                            <a href="feedback.jsp?id=<%= c.getid() %>"
                                               class="btn btn-sm btn-success">
                                               Give Feedback
                                            </a>
                                <%
                                        }

                                    } else {
                                %>
                                        <span class="text-muted">-</span>
                                <%
                                    }
                                %>
                            </td>

                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="12" class="text-center">
                                No complaints found
                            </td>
                        </tr>
                    <%
                        }
                    %>

                    </tbody>
                </table>
            </div>

            <!-- ============ MOBILE CARD VIEW ============ -->
            <div class="d-md-none mt-3">
                <%
                    if (list != null && !list.isEmpty()) {
                        for (Complaintdtls c : list) {
                %>
                    <div class="mobile-card">

                        <div class="text-center mb-3">
                            <img src="images/<%= c.getImage() %>"
                                 class="complaint-img">
                        </div>

                        <h6><%= c.getTitle() %></h6>

                        <small><b>ID:</b> <%= c.getid() %></small>
                        <small><b>Category:</b> <%= c.getCategory() %></small>
                        <small><b>Complaint Type:</b> <%= c.getComplaintType() %></small>
                        <small><b>Description:</b> <%= c.getDescription() %></small>
                        <small><b>Date:</b> <%= c.getCreatedate() %></small>
                        <small><b>Quarter No:</b> <%= c.getQtrno() %></small>
                        <small><b>Phone:</b> <%= c.getPhone() %></small>
                        <small><b>Status:</b> <%= c.getStatus() %></small>
                        <small><b>Action Taken:</b> <%= c.getAction() %></small>

                        <% if ("Closed".equalsIgnoreCase(c.getStatus())) { %>

                            <%
                                boolean feedbackSubmittedMobile = false;

                                try {
                                    Connection conn = DBConnect.getConnection();

                                    String fbSql =
                                        "SELECT COUNT(*) FROM CTRACK.COMPLAINT_FEEDBACK " +
                                        "WHERE COMPLAINT_ID=? AND EMPN=?";

                                    PreparedStatement psFb = conn.prepareStatement(fbSql);
                                    psFb.setInt(1, c.getid());
                                    psFb.setLong(2, user.getEmpn());

                                    ResultSet rsFb = psFb.executeQuery();
                                    if (rsFb.next()) {
                                        feedbackSubmittedMobile = rsFb.getInt(1) > 0;
                                    }

                                    rsFb.close();
                                    psFb.close();

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>

                            <div class="mt-2 text-center">

                                <% if (feedbackSubmittedMobile) { %>
                                    <span class="badge badge-success mb-2 d-inline-block">
                                        Feedback Submitted
                                    </span>
                                    <br>

                                    <a href="viewFeedback.jsp?id=<%= c.getid() %>"
                                       class="btn btn-sm btn-info">
                                       View Feedback
                                    </a>
                                <% } else { %>
                                    <span class="badge badge-warning mb-2 d-inline-block">
                                        Pending Feedback
                                    </span>
                                    <br>

                                    <a href="feedback.jsp?id=<%= c.getid() %>"
                                       class="btn btn-sm btn-success">
                                       Give Feedback
                                    </a>
                                <% } %>

                            </div>

                        <% } %>

                    </div>
                <%
                        }
                    }
                %>
            </div>

        </div>
    </div>

    <!-- ============ FOOTER (ALWAYS BOTTOM) ============ -->
    <%@include file="all_component/footer.jsp"%>

</div>

</body>
</html>
