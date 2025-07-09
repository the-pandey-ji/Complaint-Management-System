<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.ComplaintDAOImpl"%>
<%@page import="com.DAO.ComplaintDAO"%>
<%@page import="com.entity.Complaintdtls"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

	

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin: Close Complaints</title>
<%@include file="allCss.jsp"%>
</head>
<body>
	<%@include file="navbar.jsp"%>
	
	
 <div class="container">
        <h3 class="text-center">Close Complaint</h3>
		<div class="text-center">
			<%
			String succMsg = (String) session.getAttribute("succMsg");
			if (succMsg != null) {
			%>
			<div class="alert alert-success">
				<%=succMsg%>
			</div>
			<%
			session.removeAttribute("succMsg");
			}
			%>

			<%
			String failedMsg = (String) session.getAttribute("failedMsg");
			if (failedMsg != null) {
			%>
			<div class="alert alert-danger">
				<%=failedMsg%>
			</div>
			<%
			session.removeAttribute("failedMsg");
			}
			%>
			</div>
			
			
			

<%
    String idParam = request.getParameter("id");
    int id = 0;
    Complaintdtls complaint = null;

    if (idParam != null && !idParam.isEmpty()) {
        try {
            id = Integer.parseInt(idParam);
            ComplaintDAOImpl dao = new ComplaintDAOImpl(DBConnect.getConnection());
            complaint = dao.getComplaintById(id);
        } catch (NumberFormatException e) {
            out.println("<div style='color: red;'>Invalid complaint ID.</div>");
        }
    }

    if (complaint == null) {
%>
    <div style="color: red;">Complaint not found or invalid ID.</div>
<%
    } else {
%>
    <form action="../ComplaintClose" method="post">
        <input type="hidden" name="id" value="<%= complaint.getid() %>">
        <div class="form-group">
            <label for="complaintId">Complaint ID:</label>
            <input type="text" id="complaintId" name="complaintId" class="form-control" value="<%= complaint.getid() %>" readonly>
        </div>
        <div class="form-group">
            <label for="actionTaken">Action Taken:</label>
            <textarea id="actionTaken" name="actionTaken" class="form-control" rows="4" required></textarea>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-success">Close Complaint</button>
        </div>
    </form>
<%
    }
%>
		</div>




		<div style="margin-top: 430px;">
		<%@include file="footer.jsp"%></div>
</body>
</html>