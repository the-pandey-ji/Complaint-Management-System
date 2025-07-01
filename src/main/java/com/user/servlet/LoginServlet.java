package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.entity.User;
import com.DAO.UserDAOImpl;
import com.DB.DBConnect;

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
	
	UserDAOImpl userDAO = new UserDAOImpl(DBConnect.getConnection());

	HttpSession session = request.getSession();


		// Handle POST request
//		response.getWriter().write("POST request handled successfully.");
		try {
			int empn = Integer.parseInt(request.getParameter("empn"));
			String password = request.getParameter("password");
			
			if (0000==empn && "0000".equals(password)) {
				
				User us = new User();
				session.setAttribute("user", us);
				// Redirect to admin dashboard
				response.sendRedirect("admin/home.jsp");
			} else if (empn > 0 && password != null && !password.isEmpty()) {
				
				User us = userDAO.userLogin(empn, password);
				
				if (us != null) {
					// Valid user, set session attributes
					session.setAttribute("user", us);
					session.setAttribute("empn", us.getEmpn());
					session.setAttribute("username", us.getUsername());
					session.setAttribute("qtrno", us.getQtrno());
					session.setAttribute("email", us.getEmail());
					session.setAttribute("phone", us.getPhone());
					

					// Redirect to user dashboard
					response.sendRedirect("home.jsp");
					
				} else {
					// Invalid credentials
					request.setAttribute("errorMsg", "Invalid Employee Number or Password.");
					response.sendRedirect("login.jsp");
					return;
				}
				
			} else {
				// Invalid credentials
				request.setAttribute("errorMsg", "Invalid Employee Number or Password.");
				response.sendRedirect("login.jsp");
			}

			System.out.println("Employee Number: " + empn + ", Password: " + password);
			}

		 catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMsg", "An error occurred while processing your request.");
			response.sendRedirect("login.jsp");
		}
	}

}
