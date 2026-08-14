package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.Cart;
import com.foodexpress.model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {


    // =====================================================
    // PLACE ORDER
    // =====================================================

    public int placeOrder(
            Order order,
            List<Cart> cartList,
            String paymentMethod) throws Exception {

        Connection con = null;

        try {

            con = DBConnection.getConnection();

            con.setAutoCommit(false);


            // =============================================
            // INSERT ORDER
            // =============================================

            String orderSQL =
                    "INSERT INTO orders " +
                    "(user_id, total_amount, order_status, " +
                    "payment_status, delivery_address) " +
                    "VALUES (?, ?, ?, ?, ?)";

            PreparedStatement orderPS =
                    con.prepareStatement(
                            orderSQL,
                            PreparedStatement.RETURN_GENERATED_KEYS
                    );


            orderPS.setInt(
                    1,
                    order.getUserId()
            );

            orderPS.setDouble(
                    2,
                    order.getTotalAmount()
            );

            orderPS.setString(
                    3,
                    order.getOrderStatus()
            );

            orderPS.setString(
                    4,
                    order.getPaymentStatus()
            );

            orderPS.setString(
                    5,
                    order.getDeliveryAddress()
            );


            int affectedRows =
                    orderPS.executeUpdate();


            if (affectedRows == 0) {

                con.rollback();

                return -1;
            }


            // =============================================
            // GET GENERATED ORDER ID
            // =============================================

            ResultSet generatedKeys =
                    orderPS.getGeneratedKeys();


            int orderId = -1;


            if (generatedKeys.next()) {

                orderId =
                        generatedKeys.getInt(1);
            }


            generatedKeys.close();
            orderPS.close();


            if (orderId <= 0) {

                con.rollback();

                return -1;
            }


            // =============================================
            // INSERT PAYMENT
            // =============================================

            String paymentSQL =
                    "INSERT INTO payments " +
                    "(order_id, payment_method, amount, payment_status) " +
                    "VALUES (?, ?, ?, ?)";


            PreparedStatement paymentPS =
                    con.prepareStatement(paymentSQL);


            paymentPS.setInt(
                    1,
                    orderId
            );

            paymentPS.setString(
                    2,
                    paymentMethod
            );

            paymentPS.setDouble(
                    3,
                    order.getTotalAmount()
            );

            paymentPS.setString(
                    4,
                    order.getPaymentStatus()
            );


            paymentPS.executeUpdate();

            paymentPS.close();


            // =============================================
            // CLEAR CART
            // =============================================

            String cartSQL =
                    "DELETE FROM cart WHERE user_id = ?";


            PreparedStatement cartPS =
                    con.prepareStatement(cartSQL);


            cartPS.setInt(
                    1,
                    order.getUserId()
            );


            cartPS.executeUpdate();

            cartPS.close();


            // =============================================
            // COMMIT
            // =============================================

            con.commit();

            con.close();


            return orderId;


        } catch (Exception e) {

            e.printStackTrace();


            if (con != null) {

                try {

                    con.rollback();

                } catch (Exception rollbackError) {

                    rollbackError.printStackTrace();
                }

                try {

                    con.close();

                } catch (Exception closeError) {

                    closeError.printStackTrace();
                }
            }


            throw e;
        }
    }


    // =====================================================
    // GET ALL ORDERS FOR ADMIN
    // =====================================================

    public List<Order> getAllOrders() {

        List<Order> orders =
                new ArrayList<>();


        String sql =
                "SELECT " +
                "o.order_id, " +
                "o.user_id, " +
                "u.full_name, " +
                "u.email, " +
                "u.phone, " +
                "o.total_amount, " +
                "o.order_status, " +
                "o.payment_status, " +
                "o.delivery_address, " +
                "o.order_date " +

                "FROM orders o " +

                "JOIN users u " +
                "ON o.user_id = u.user_id " +

                "ORDER BY o.order_id DESC";


        try {

            Connection con =
                    DBConnection.getConnection();


            PreparedStatement ps =
                    con.prepareStatement(sql);


            ResultSet rs =
                    ps.executeQuery();


            while (rs.next()) {

                Order order =
                        new Order();


                order.setOrderId(
                        rs.getInt("order_id")
                );


                order.setUserId(
                        rs.getInt("user_id")
                );


                order.setCustomerName(
                        rs.getString("full_name")
                );


                order.setEmail(
                        rs.getString("email")
                );


                order.setPhone(
                        rs.getString("phone")
                );


                order.setTotalAmount(
                        rs.getDouble("total_amount")
                );


                order.setOrderStatus(
                        rs.getString("order_status")
                );


                order.setPaymentStatus(
                        rs.getString("payment_status")
                );


                order.setDeliveryAddress(
                        rs.getString("delivery_address")
                );


                order.setOrderDate(
                        rs.getString("order_date")
                );


                orders.add(order);
            }


            rs.close();
            ps.close();
            con.close();


        } catch (Exception e) {

            e.printStackTrace();
        }


        return orders;
    }


    // =====================================================
    // UPDATE ORDER STATUS
    // =====================================================

    public boolean updateOrderStatus(
            int orderId,
            String status) {


        String sql =
                "UPDATE orders " +
                "SET order_status = ? " +
                "WHERE order_id = ?";


        try {

            Connection con =
                    DBConnection.getConnection();


            PreparedStatement ps =
                    con.prepareStatement(sql);


            ps.setString(
                    1,
                    status
            );


            ps.setInt(
                    2,
                    orderId
            );


            int result =
                    ps.executeUpdate();


            ps.close();
            con.close();


            return result > 0;


        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // DELETE ORDER
    // =====================================================

    public boolean deleteOrder(int orderId) {

        Connection con = null;


        try {

            con =
                    DBConnection.getConnection();

            con.setAutoCommit(false);


            // ---------------------------------------------
            // Delete payment first
            // ---------------------------------------------

            String paymentSQL =
                    "DELETE FROM payments " +
                    "WHERE order_id = ?";


            PreparedStatement paymentPS =
                    con.prepareStatement(paymentSQL);


            paymentPS.setInt(
                    1,
                    orderId
            );


            paymentPS.executeUpdate();

            paymentPS.close();


            // ---------------------------------------------
            // Delete order
            // ---------------------------------------------

            String orderSQL =
                    "DELETE FROM orders " +
                    "WHERE order_id = ?";


            PreparedStatement orderPS =
                    con.prepareStatement(orderSQL);


            orderPS.setInt(
                    1,
                    orderId
            );


            int result =
                    orderPS.executeUpdate();


            orderPS.close();


            con.commit();

            con.close();


            return result > 0;


        } catch (Exception e) {

            e.printStackTrace();


            try {

                if (con != null) {

                    con.rollback();
                    con.close();
                }

            } catch (Exception rollbackError) {

                rollbackError.printStackTrace();
            }


            return false;
        }
    }
}