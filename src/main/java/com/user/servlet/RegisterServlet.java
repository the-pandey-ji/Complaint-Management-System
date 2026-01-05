package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.HttpServlet;

import com.DAO.UserDAOImpl;
import com.DB.DBConnect;
import com.entity.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            long empn = Long.parseLong(request.getParameter("empn"));
            String username = request.getParameter("username");
            String qtrno = request.getParameter("qtrno");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");

            // 🔹 ADMIN FIELDS
            String fromAdmin = request.getParameter("fromAdmin");
            String role = request.getParameter("role");
            String status = request.getParameter("status"); // A / I

            User user = new User();
            user.setEmpn(empn);
            user.setUsername(username);
            user.setQtrno(qtrno);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword(password);

            // 🔹 If created by Admin
            if ("true".equals(fromAdmin)) {
                user.setRole(role);
                user.setStatus(status);      // A = Active
				/* user.setUsercreationdate(new java.util.Date()); */
            } 
            // 🔹 Normal self-registration
            else {
                user.setRole("NU");
                user.setStatus("A");
				/* user.setUsercreationdate(new java.util.Date()); */
            }

            UserDAOImpl dao = new UserDAOImpl(DBConnect.getConnection());
            boolean success = dao.userRegister(user);

            if (success) {
                if ("true".equals(fromAdmin)) {
                    session.setAttribute("succMsg", "User created successfully");
                    response.sendRedirect("admin/manageUsers.jsp");
                } else {
                    session.setAttribute("succMsg", "Registration successful. Please login.");
                    response.sendRedirect("index.jsp");
                }
            } else {
                session.setAttribute("failedMsg", "User already exists or error occurred");
                response.sendRedirect(
                    "true".equals(fromAdmin)
                        ? "admin/manageUsers.jsp"
                        : "register.jsp"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "Server error");
            response.sendRedirect("register.jsp");
        }
    }
}
