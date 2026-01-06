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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = null;

        try {
            /* ================= READ INPUT ================= */
            String empnStr = request.getParameter("empn");
            String password = request.getParameter("password");

            if (empnStr == null || password == null ||
                empnStr.trim().isEmpty() || password.trim().isEmpty()) {

                session = request.getSession(true);
                session.setAttribute("errorMsg",
                        "Invalid Employee Number or Password.");
                response.sendRedirect("index.jsp");
                return;
            }

            long empn;
            try {
                empn = Long.parseLong(empnStr);
            } catch (NumberFormatException e) {
                session = request.getSession(true);
                session.setAttribute("errorMsg",
                        "Invalid Employee Number or Password.");
                response.sendRedirect("index.jsp");
                return;
            }

            /* ================= AUTHENTICATE ================= */
            UserDAOImpl userDAO =
                    new UserDAOImpl(DBConnect.getConnection());

            User user = userDAO.userLogin(empn, password);

            if (user == null) {
                session = request.getSession(true);
                session.setAttribute("errorMsg",
                        "Invalid Employee Number or Password.");
                response.sendRedirect("index.jsp");
                return;
            }

            /* ================= PREVENT SESSION FIXATION ================= */
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            session = request.getSession(true);
            session.setAttribute("Userobj", user);

            /* ================= ROLE BASED REDIRECT ================= */
            if ("AC".equals(user.getRole()) || "AE".equals(user.getRole())) {
                response.sendRedirect("admin/home.jsp");
            } else {
                response.sendRedirect("home.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();

            session = request.getSession(true);
            session.setAttribute("errorMsg",
                    "An unexpected error occurred. Please try again.");
            response.sendRedirect("index.jsp");
        }
    }
}
