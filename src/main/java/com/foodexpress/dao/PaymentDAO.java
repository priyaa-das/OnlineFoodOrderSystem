/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class PaymentDAO {

    public boolean addPayment(
            int orderId,
            String paymentMethod,
            double amount) {

        String sql =
                "INSERT INTO payments " +
                "(order_id, payment_method, amount, payment_status) " +
                "VALUES (?, ?, ?, ?)";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement pst =
                    con.prepareStatement(sql);

            pst.setInt(1, orderId);
            pst.setString(2, paymentMethod);
            pst.setDouble(3, amount);
            pst.setString(4, "Pending");

            int result = pst.executeUpdate();

            pst.close();
            con.close();

            return result > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}
