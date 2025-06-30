package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		// Handle POST request
//		response.getWriter().write("POST request handled successfully.");
		try {
			String empn = request.getParameter("empn");
			String password = request.getParameter("password");

			System.out.println("Employee Number: " + empn + ", Password: " + password);
			}

		 catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMsg", "An error occurred while processing your request.");
			response.sendRedirect("login.jsp");
		}
	}

}
