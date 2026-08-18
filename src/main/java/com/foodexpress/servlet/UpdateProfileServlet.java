package com.foodexpress.servlet;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        // ==========================================
        // LOGIN CHECK
        // ==========================================

        if (user == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // ==========================================
        // GET USER ID
        // ==========================================

        int userId = user.getUserId();

        // ==========================================
        // GET FORM DATA
        // ==========================================

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // ==========================================
        // VALIDATION
        // ==========================================

        if (fullName == null || fullName.trim().isEmpty()
                || email == null || email.trim().isEmpty()) {

            response.sendRedirect("editProfile.jsp?error=required");
            return;
        }

        fullName = fullName.trim();
        email = email.trim();

        if (phone != null) {
            phone = phone.trim();
        }

        if (address != null) {
            address = address.trim();
        }

        // ==========================================
        // UPDATE DATABASE
        // ==========================================

        String sql =
                "UPDATE users SET "
                + "full_name=?, "
                + "email=?, "
                + "phone=?, "
                + "address=? "
                + "WHERE user_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setString(1, fullName);
            pst.setString(2, email);
            pst.setString(3, phone);
            pst.setString(4, address);
            pst.setInt(5, userId);

            int rows = pst.executeUpdate();

            // ==========================================
            // SUCCESS
            // ==========================================

            if (rows > 0) {

                // Update session user object
                user.setFullName(fullName);
                user.setEmail(email);
                user.setPhone(phone);
                user.setAddress(address);

                session.setAttribute("user", user);

                System.out.println(
                        "PROFILE UPDATED SUCCESSFULLY - USER ID = "
                        + userId
                );

                response.sendRedirect("profile.jsp?success=updated");

            } else {

                System.out.println(
                        "PROFILE UPDATE FAILED - NO ROW UPDATED"
                );

                response.sendRedirect(
                        "editProfile.jsp?error=notupdated"
                );
            }

        } catch (java.sql.SQLIntegrityConstraintViolationException e) {

            // Duplicate email
            e.printStackTrace();

            response.sendRedirect(
                    "editProfile.jsp?error=email"
            );

        } catch (Exception e) {

            System.out.println("PROFILE UPDATE DATABASE ERROR");

            e.printStackTrace();

            response.sendRedirect(
                    "editProfile.jsp?error=database"
            );
        }
    }
}