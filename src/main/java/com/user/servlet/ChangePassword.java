
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

@WebServlet("/changePassword")
public class ChangePassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Userobj") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            UserDAOImpl userDAO = new UserDAOImpl(DBConnect.getConnection());
            User user = (User) session.getAttribute("Userobj");

            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // Validate current password
            if (!user.getPassword().equals(currentPassword)) {
                session.setAttribute("failedMsg", "Current password is incorrect.");
                response.sendRedirect("changePassword.jsp");
                return;
            }

            // Validate new password and confirmation
            if (newPassword == null || newPassword.isEmpty() || !newPassword.equals(confirmPassword)) {
                session.setAttribute("failedMsg", "New password and confirmation do not match.");
                response.sendRedirect("changePassword.jsp");
                return;
            }

            // Update password in the database
            boolean isUpdated = userDAO.updatePassword(user.getEmpn(), newPassword);
            if (isUpdated) {
                session.setAttribute("succMsg", "Password changed successfully.");
                response.sendRedirect("changePassword.jsp");
            } else {
                session.setAttribute("failedMsg", "Failed to change password. Please try again.");
                response.sendRedirect("changePassword.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "An error occurred while processing your request.");
            response.sendRedirect("changePassword.jsp");
        }
    }
}
