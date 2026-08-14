package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.User;

import java.util.ArrayList;
import java.util.List;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    Connection con;
    PreparedStatement pst;
    ResultSet rs;


    // =====================================================
    // REGISTER CUSTOMER
    // =====================================================

    public boolean registerUser(User user) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO users " +
                    "(full_name, email, phone, password, address, role) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            pst = con.prepareStatement(sql);

            pst.setString(1, user.getFullName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPhone());
            pst.setString(4, user.getPassword());
            pst.setString(5, user.getAddress());

            // Normal registration = customer
            pst.setString(6, "customer");

            int row = pst.executeUpdate();

            if (row > 0) {

                System.out.println("Customer Registration Successful");
                status = true;

            } else {

                System.out.println("Customer Registration Failed");
            }

        } catch (Exception e) {

            System.out.println("REGISTER USER ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return status;
    }


    // =====================================================
    // CUSTOMER LOGIN
    // =====================================================

    public User loginUser(String email, String password) {

        User user = null;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "SELECT * FROM users " +
                    "WHERE email=? " +
                    "AND password=? " +
                    "AND role='customer'";

            pst = con.prepareStatement(sql);

            pst.setString(1, email.trim());
            pst.setString(2, password.trim());

            rs = pst.executeQuery();

            if (rs.next()) {

                user = createUserFromResultSet(rs);

                System.out.println("CUSTOMER FOUND");

            } else {

                System.out.println("CUSTOMER NOT FOUND");
            }

        } catch (Exception e) {

            System.out.println("CUSTOMER LOGIN ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return user;
    }


    // =====================================================
    // ADMIN LOGIN
    // =====================================================

    public User adminLogin(String email, String password) {

        User user = null;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "SELECT * FROM users " +
                    "WHERE email=? " +
                    "AND password=? " +
                    "AND role='admin'";

            pst = con.prepareStatement(sql);

            pst = con.prepareStatement(sql);

            pst.setString(1, email.trim());
            pst.setString(2, password.trim());

            rs = pst.executeQuery();

            if (rs.next()) {

                user = createUserFromResultSet(rs);

                System.out.println("ADMIN FOUND");

            } else {

                System.out.println("ADMIN NOT FOUND");
            }

        } catch (Exception e) {

            System.out.println("ADMIN LOGIN ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return user;
    }


    // =====================================================
    // GET ALL USERS
    // =====================================================

    public List<User> getAllUsers() {

        List<User> userList = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql =
                    "SELECT user_id, full_name, email, " +
                    "phone, address, role, created_at " +
                    "FROM users " +
                    "ORDER BY user_id DESC";

            pst = con.prepareStatement(sql);

            rs = pst.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setUserId(
                        rs.getInt("user_id")
                );

                user.setFullName(
                        rs.getString("full_name")
                );

                user.setEmail(
                        rs.getString("email")
                );

                user.setPhone(
                        rs.getString("phone")
                );

                user.setAddress(
                        rs.getString("address")
                );

                user.setRole(
                        rs.getString("role")
                );

                userList.add(user);
            }

            System.out.println(
                    "Total Users = " + userList.size()
            );

        } catch (Exception e) {

            System.out.println(
                    "GET ALL USERS ERROR"
            );

            e.printStackTrace();

        } finally {

            closeResources();
        }

        return userList;
    }


    // =====================================================
    // GET CUSTOMERS ONLY
    // =====================================================

    public List<User> getAllCustomers() {

        List<User> customerList = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql =
                    "SELECT user_id, full_name, email, " +
                    "phone, address, role, created_at " +
                    "FROM users " +
                    "WHERE role='customer' " +
                    "ORDER BY user_id DESC";

            pst = con.prepareStatement(sql);

            rs = pst.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setUserId(
                        rs.getInt("user_id")
                );

                user.setFullName(
                        rs.getString("full_name")
                );

                user.setEmail(
                        rs.getString("email")
                );

                user.setPhone(
                        rs.getString("phone")
                );

                user.setAddress(
                        rs.getString("address")
                );

                user.setRole(
                        rs.getString("role")
                );

                customerList.add(user);
            }

            System.out.println(
                    "Total Customers = " +
                    customerList.size()
            );

        } catch (Exception e) {

            System.out.println(
                    "GET ALL CUSTOMERS ERROR"
            );

            e.printStackTrace();

        } finally {

            closeResources();
        }

        return customerList;
    }


    // =====================================================
    // DELETE CUSTOMER
    // =====================================================

    public boolean deleteUser(int userId) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "DELETE FROM users " +
                    "WHERE user_id=? " +
                    "AND role='customer'";

            pst = con.prepareStatement(sql);

            pst.setInt(1, userId);

            int row = pst.executeUpdate();

            if (row > 0) {

                System.out.println(
                        "Customer Deleted Successfully"
                );

                status = true;

            } else {

                System.out.println(
                        "Customer Not Found"
                );
            }

        } catch (Exception e) {

            System.out.println(
                    "DELETE USER ERROR"
            );

            e.printStackTrace();

        } finally {

            closeResources();
        }

        return status;
    }


    // =====================================================
    // CREATE USER FROM RESULT SET
    // =====================================================

    private User createUserFromResultSet(ResultSet rs)
            throws Exception {

        User user = new User();

        user.setUserId(
                rs.getInt("user_id")
        );

        user.setFullName(
                rs.getString("full_name")
        );

        user.setEmail(
                rs.getString("email")
        );

        user.setPhone(
                rs.getString("phone")
        );

        user.setAddress(
                rs.getString("address")
        );

        user.setRole(
                rs.getString("role")
        );

        return user;
    }


    // =====================================================
    // CLOSE DATABASE RESOURCES
    // =====================================================

    private void closeResources() {

        try {

            if (rs != null) {
                rs.close();
                rs = null;
            }

            if (pst != null) {
                pst.close();
                pst = null;
            }

            if (con != null) {
                con.close();
                con = null;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}