package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DAO.UserDAOImpl;
import com.DB.DBConnect;
import com.entity.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);

        try {
            /* ================= READ & VALIDATE INPUT ================= */
            String empnStr = request.getParameter("empn");
            String username = request.getParameter("username");
            String qtrno = request.getParameter("qtrno");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");

            if (empnStr == null || username == null || password == null ||
                empnStr.trim().isEmpty() || username.trim().isEmpty() ||
                password.trim().isEmpty()) {

                session.setAttribute("failedMsg", "All required fields must be filled");
                response.sendRedirect("register.jsp");
                return;
            }

            long empn;
            try {
                empn = Long.parseLong(empnStr);
            } catch (NumberFormatException e) {
                session.setAttribute("failedMsg", "Invalid Employee Number");
                response.sendRedirect("register.jsp");
                return;
            }

            /* ================= CHECK DUPLICATE EMPN ================= */
            UserDAOImpl dao = new UserDAOImpl(DBConnect.getConnection());
            User existingUser = dao.getUserByEmpn(empn);

            if (existingUser != null) {
                session.setAttribute("failedMsg",
                        "Employee ID already registered. Please login.");
                response.sendRedirect("register.jsp");
                return;
            }

            /* ================= CREATE USER OBJECT ================= */
            User user = new User();
            user.setEmpn(empn);
            user.setUsername(username);
            user.setQtrno(qtrno);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword(password);

            /* ================= ADMIN / USER REGISTRATION ================= */
            String fromAdmin = request.getParameter("fromAdmin");
            String role = request.getParameter("role");
            String status = request.getParameter("status");

            if ("true".equals(fromAdmin)) {
                user.setRole(role);
                user.setStatus(status);   // A / I
            } else {
                user.setRole("NU");       // Normal User
                user.setStatus("A");      // Active
            }

            /* ================= SAVE USER ================= */
            boolean success = dao.userRegister(user);

            if (success) {
                if ("true".equals(fromAdmin)) {
                    session.setAttribute("succMsg", "User created successfully");
                    response.sendRedirect("admin/manageUsers.jsp");
                } else {
                    session.setAttribute("succMsg",
                            "Registration successful. Please login.");
                    response.sendRedirect("index.jsp");
                }
            } else {
                session.setAttribute("failedMsg",
                        "Registration failed. Please try again.");
                response.sendRedirect(
                        "true".equals(fromAdmin)
                                ? "admin/manageUsers.jsp"
                                : "register.jsp"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg",
                    "Server error occurred. Please try again.");
            response.sendRedirect("register.jsp");
        }
    }
}
