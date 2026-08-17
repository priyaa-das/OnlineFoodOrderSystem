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
import java.sql.ResultSet;

@WebServlet("/UpdateAdminProfileServlet")
public class UpdateAdminProfileServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User admin = (User) session.getAttribute("admin");

        // ==============================
        // ADMIN LOGIN CHECK
        // ==============================

        if (admin == null) {

            response.sendRedirect("adminLogin.jsp");

            return;
        }

        // ==============================
        // GET FORM DATA
        // ==============================

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String phone =
                request.getParameter("phone");

        String address =
                request.getParameter("address");

        String password =
                request.getParameter("password");


        // ==============================
        // VALIDATION
        // ==============================

        if (fullName == null ||
            fullName.trim().isEmpty() ||
            email == null ||
            email.trim().isEmpty()) {

            response.sendRedirect(
                    "editAdminProfile.jsp?error=required"
            );

            return;
        }


        Connection con = null;
        PreparedStatement pst = null;

        try {

            con = DBConnection.getConnection();

            // ==========================================
            // CHECK WHETHER EMAIL IS USED BY ANOTHER USER
            // ==========================================

            String checkSql =
                    "SELECT user_id FROM users " +
                    "WHERE email=? AND user_id<>?";

            PreparedStatement checkPst =
                    con.prepareStatement(checkSql);

            checkPst.setString(1, email);
            checkPst.setInt(2, admin.getUserId());

            ResultSet rs =
                    checkPst.executeQuery();

            if (rs.next()) {

                rs.close();
                checkPst.close();

                response.sendRedirect(
                        "editAdminProfile.jsp?error=email"
                );

                return;
            }

            rs.close();
            checkPst.close();


            // ==========================================
            // UPDATE WITH PASSWORD
            // ==========================================

            if (password != null &&
                !password.trim().isEmpty()) {

                String sql =
                        "UPDATE users SET " +
                        "full_name=?, " +
                        "email=?, " +
                        "phone=?, " +
                        "address=?, " +
                        "password=? " +
                        "WHERE user_id=? AND role='admin'";

                pst = con.prepareStatement(sql);

                pst.setString(1, fullName);
                pst.setString(2, email);
                pst.setString(3, phone);
                pst.setString(4, address);
                pst.setString(5, password);
                pst.setInt(6, admin.getUserId());

            }

            // ==========================================
            // UPDATE WITHOUT PASSWORD
            // ==========================================

            else {

                String sql =
                        "UPDATE users SET " +
                        "full_name=?, " +
                        "email=?, " +
                        "phone=?, " +
                        "address=? " +
                        "WHERE user_id=? AND role='admin'";

                pst = con.prepareStatement(sql);

                pst.setString(1, fullName);
                pst.setString(2, email);
                pst.setString(3, phone);
                pst.setString(4, address);
                pst.setInt(5, admin.getUserId());
            }


            int updated =
                    pst.executeUpdate();


            // ==========================================
            // UPDATE SESSION
            // ==========================================

            if (updated > 0) {

                admin.setFullName(fullName);
                admin.setEmail(email);
                admin.setPhone(phone);
                admin.setAddress(address);

                session.setAttribute(
                        "admin",
                        admin
                );


                response.sendRedirect(
                        "adminProfile.jsp?success=updated"
                );

            } else {

                response.sendRedirect(
                        "editAdminProfile.jsp?error=failed"
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "editAdminProfile.jsp?error=database"
            );

        } finally {

            try {

                if (pst != null) {
                    pst.close();
                }

            } catch (Exception e) {
            }

            try {

                if (con != null) {
                    con.close();
                }

            } catch (Exception e) {
            }
        }
    }
}