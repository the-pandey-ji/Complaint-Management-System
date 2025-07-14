package com.user.servlet;

import java.io.IOException;
   import javax.servlet.ServletException;
   import javax.servlet.annotation.WebServlet;
   import javax.servlet.http.HttpServlet;
   import javax.servlet.http.HttpServletRequest;
   import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.UserDAOImpl;
import com.DB.DBConnect;
import com.entity.User;

   @WebServlet("/register")
   public class RegisterServlet extends HttpServlet {
       private static final long serialVersionUID = 1L;

	@Override
       protected void doPost(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
           // Handle POST request
           response.getWriter().write("POST request handled successfully.");
			try {
				long empn = Long.parseLong(request.getParameter("empn"));
				String username = request.getParameter("username");
//				String qtrno = request.getParameter("qtrno");
				String qtrno = request.getParameter("qtrno");
				if (qtrno == null || qtrno.isEmpty()) {
				    request.setAttribute("failedMsg", "Quarter number is required.");
				    response.sendRedirect("register.jsp");
				    System.out.println("Quarter number is null or empty.");
				    System.out.println("Redirectin"+qtrno);
				    return;
				}
				String email = request.getParameter("email");
				String phone = request.getParameter("phone");
				String password = request.getParameter("password");
				//String check = request.getParameter("check");
				
//				System.out.println("Employee Number: " + empn + ", Username: " + username + ", Email: " + email
//						+ ", Phone: " + phone + ", Password: " + password);

				User user = new User();
				user.setEmpn(empn);
				user.setQtrno(qtrno);
				user.setUsername(username);
				user.setEmail(email);
				user.setPhone(phone);
				user.setPassword(password);
				
				HttpSession session = request.getSession();
				
				
				UserDAOImpl dao = new UserDAOImpl(DBConnect.getConnection());
				boolean f = dao.userRegister(user);
				if (f) {
					session.setAttribute("succMsg", "Registration Successful! Please Login.");
					response.sendRedirect("index.jsp");
				} else {
					request.setAttribute("errorMsg", "Something went wrong, please try again.");
					response.sendRedirect("register.jsp");
				}
			
			
			}
			catch(Exception e) {
				e.printStackTrace();
			}
       }
   }
