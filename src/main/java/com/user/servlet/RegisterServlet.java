package com.user.servlet;

import java.io.IOException;
   import javax.servlet.ServletException;
   import javax.servlet.annotation.WebServlet;
   import javax.servlet.http.HttpServlet;
   import javax.servlet.http.HttpServletRequest;
   import javax.servlet.http.HttpServletResponse;

   @WebServlet("/register")
   public class RegisterServlet extends HttpServlet {
       private static final long serialVersionUID = 1L;

	@Override
       protected void doPost(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
           // Handle POST request
           response.getWriter().write("POST request handled successfully.");
       }
   }
