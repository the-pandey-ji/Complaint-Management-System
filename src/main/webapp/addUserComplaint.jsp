<%@page import="java.util.List"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.UserDAOImpl"%>
<%@page import="com.entity.User"%>
<%@page import="com.UserComplaint.servlet.AddUserComplaint"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
User user = (User) session.getAttribute("Userobj");
if (user == null) {
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Add Complaint</title>
<%@include file="all_component/allCss.jsp"%>

<style>
body {
    background-color: #f4f6f9;
}

.form-card {
    border-radius: 16px;
    box-shadow: 0 12px 30px rgba(0,0,0,.12);
    border: none;
}

.form-title {
    font-weight: 700;
    color: #0b6b3a;
}

.form-subtitle {
    font-size: 14px;
    color: #6c757d;
}

.form-control {
    border-radius: 10px;
}

.btn-submit {
    border-radius: 12px;
    font-weight: 600;
    padding: 10px 30px;
}

.section-divider {
    height: 4px;
    width: 80px;
    background: linear-gradient(90deg,#0b6b3a,#1e8f5a);
    border-radius: 4px;
    margin: 10px auto 25px;
}
</style>
</head>

<body>

<%@include file="all_component/navbar.jsp"%>

<!-- PAGE HEADER -->
<div class="container mt-5 text-center">
    <h2 class="form-title">Raise a New Complaint</h2>
    <p class="form-subtitle">
        Please provide accurate details for faster resolution
    </p>
    <div class="section-divider"></div>
</div>

<!-- FORM CARD -->
<div class="container mb-5">
  <div class="row justify-content-center">
    <div class="col-md-7">

      <div class="card form-card">
        <div class="card-body p-4">

          <!-- SUCCESS MESSAGE -->
          <%
              String succMsg = (String) session.getAttribute("succMsg");
              if (succMsg != null) {
          %>
              <div class="alert alert-success text-center font-weight-bold">
                  <%= succMsg %>
              </div>
          <%
              session.removeAttribute("succMsg");
              }
          %>

          <!-- ERROR MESSAGE -->
          <%
              String failedMsg = (String) session.getAttribute("failedMsg");
              if (failedMsg != null) {
          %>
              <div class="alert alert-danger text-center font-weight-bold">
                  <%= failedMsg %>
              </div>
          <%
              session.removeAttribute("failedMsg");
              }
          %>

          <form action="addcomplaintuser" method="post" enctype="multipart/form-data">

            <!-- CATEGORY -->
            <div class="form-group">
              <label>Complaint Category</label>
              <select name="category" class="form-control" required>
                <option value="">-- Select Category --</option>
                <option value="Civil">Civil</option>
                <option value="Electrical">Electrical</option>
              </select>
            </div>

            <!-- TITLE -->
            <div class="form-group">
              <label>Complaint Title</label>
              <input name="title" type="text" class="form-control"
                     placeholder="Brief title of the issue" required>
            </div>

            <!-- DESCRIPTION -->
            <div class="form-group">
              <label>Complaint Description</label>
              <textarea name="description" class="form-control"
                        rows="4"
                        placeholder="Describe the issue in detail"
                        required></textarea>
            </div>

             <div class="row">
            
            <!-- QTR -->
            <div class="col-md-6 form-group">
              <label>Quarter Number</label>
              <input name="qtrno" type="text" class="form-control"
                     value="<%= user.getQtrno() != null ? user.getQtrno() : "" %>">
            </div>

            <div class=" col-md-6 form-group">
              <label>Contact Number</label>
                <input type="text" class="form-control"
                       value="<%= user.getPhone() %>" >
            </div>
            </div>

           
               
                <input type="hidden" name="empn" value="<%= user.getEmpn() %>">
              

              
                <input type="hidden" name="username" value="<%= user.getUsername() %>">
             

          
              
                
                <input type="hidden" name="email" value="<%= user.getEmail() %>">
              

             
           

            <!-- IMAGE -->
            <div class="form-group">
              <label>Upload Photo (Optional)</label>
              <input name="imagefile" type="file" class="form-control-file">
            </div>

            <!-- SUBMIT -->
            <div class="text-center mt-4">
              <button type="submit" class="btn btn-success btn-submit">
                <i class="fas fa-paper-plane mr-1"></i> Submit Complaint
              </button>
            </div>

          </form>

        </div>
      </div>

    </div>
  </div>
</div>

<%@include file="all_component/footer.jsp"%>

</body>
</html>
 