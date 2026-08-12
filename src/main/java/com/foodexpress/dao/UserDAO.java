package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    Connection con;
    PreparedStatement pst;
    ResultSet rs;

    // ================= Register User =================

    public boolean registerUser(User user) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql = "INSERT INTO users(full_name,email,phone,password,address,role) VALUES(?,?,?,?,?,?)";

            pst = con.prepareStatement(sql);

            pst.setString(1, user.getFullName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPhone());
            pst.setString(4, user.getPassword());
            pst.setString(5, user.getAddress());
            pst.setString(6, "customer");

            int row = pst.executeUpdate();

            if (row > 0) {

                System.out.println("Registration Successful");

                status = true;

            } else {

                System.out.println("Registration Failed");

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;

    }

    // ================= Login User =================

    public User loginUser(String email, String password) {

        User user = null;

        try {

            con = DBConnection.getConnection();

            System.out.println("Email : " + email);
            System.out.println("Password : " + password);

            String sql = "SELECT * FROM users WHERE email=? AND password=?";

            pst = con.prepareStatement(sql);

            pst.setString(1, email.trim());
            pst.setString(2, password.trim());

            rs = pst.executeQuery();

            if (rs.next()) {

                System.out.println("USER FOUND");

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));

            } else {

                System.out.println("USER NOT FOUND");

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return user;

    }

}