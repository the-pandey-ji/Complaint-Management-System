
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
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAOImpl userDAO = new UserDAOImpl(DBConnect.getConnection());
        HttpSession session = request.getSession();

        try {
            long empn = Long.parseLong(request.getParameter("empn"));
            String password = request.getParameter("password");

            if (empn > 0 && password != null && !password.isEmpty()) {
                User us = userDAO.userLogin(empn, password);
                System.out.println("User object: " + us);

                if (us != null) {
                    session.setAttribute("Userobj", us);
                    
                    System.out.println("User object after login: ");

                    if (us.getRole().equals("AC") || us.getRole().equals("AE")) {
                        // Redirect to admin dashboard
                    	System.out.println("Redirecting to admin dashboard");
                        response.sendRedirect("admin/home.jsp");
                    } else {
                        // Redirect to user dashboard
                        response.sendRedirect("home.jsp");
                    }
                }
            } else {
                // Invalid input
                session.setAttribute("errorMsg", "Invalid Employee Number or Password.");
                response.sendRedirect("index.jsp");
            }

            System.out.println("Employee Number: " + empn + ", Password: " + password);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An error occurred while processing your request.");
            response.sendRedirect("index.jsp");
        }
    }
}
