package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminProfileDAO {

    // =====================================================
    // GET ADMIN BY USER ID
    // =====================================================

    public User getAdminById(int userId) {

        User admin = null;

        String sql =
                "SELECT user_id, full_name, email, phone, password, " +
                "address, role, created_at " +
                "FROM users " +
                "WHERE user_id=? AND role='admin'";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setInt(1, userId);

            try (ResultSet rs = pst.executeQuery()) {

                if (rs.next()) {

                    admin = new User();

                    admin.setUserId(
                            rs.getInt("user_id")
                    );

                    admin.setFullName(
                            rs.getString("full_name")
                    );

                    admin.setEmail(
                            rs.getString("email")
                    );

                    admin.setPhone(
                            rs.getString("phone")
                    );

                    admin.setPassword(
                            rs.getString("password")
                    );

                    admin.setAddress(
                            rs.getString("address")
                    );

                    admin.setRole(
                            rs.getString("role")
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return admin;
    }


    // =====================================================
    // UPDATE ADMIN PROFILE
    // =====================================================

    public boolean updateAdminProfile(
            int userId,
            String fullName,
            String email,
            String phone,
            String address) {

        String sql =
                "UPDATE users SET " +
                "full_name=?, " +
                "email=?, " +
                "phone=?, " +
                "address=? " +
                "WHERE user_id=? AND role='admin'";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setString(1, fullName);
            pst.setString(2, email);
            pst.setString(3, phone);
            pst.setString(4, address);
            pst.setInt(5, userId);

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}