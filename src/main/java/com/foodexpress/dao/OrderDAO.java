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

    // =========================================================
    // PLACE ORDER
    // =========================================================
    public int placeOrder(
            Order order,
            List<Cart> cartList,
            String paymentMethod) {

        Connection con = null;
        PreparedStatement orderStmt = null;
        PreparedStatement itemStmt = null;
        PreparedStatement paymentStmt = null;
        PreparedStatement deleteCartStmt = null;
        ResultSet rs = null;

        try {

            System.out.println("=================================");
            System.out.println("OrderDAO: Starting order...");
            System.out.println("User ID: " + order.getUserId());
            System.out.println("Payment: " + paymentMethod);
            System.out.println("Total: " + order.getTotalAmount());

            // =================================================
            // DATABASE CONNECTION
            // =================================================

            con = DBConnection.getConnection();

            if (con == null) {

                System.out.println(
                        "ERROR: Database connection is NULL."
                );

                return -1;
            }

            System.out.println(
                    "Database connected successfully."
            );

            // =================================================
            // START TRANSACTION
            // =================================================

            con.setAutoCommit(false);

            // =================================================
            // 1. INSERT INTO ORDERS
            // =================================================

            String orderSQL =
                    "INSERT INTO orders " +
                    "(user_id, total_amount, order_status, " +
                    "payment_status, delivery_address) " +
                    "VALUES (?, ?, ?, ?, ?)";

            orderStmt = con.prepareStatement(
                    orderSQL,
                    PreparedStatement.RETURN_GENERATED_KEYS
            );

            orderStmt.setInt(
                    1,
                    order.getUserId()
            );

            orderStmt.setDouble(
                    2,
                    order.getTotalAmount()
            );

            orderStmt.setString(
                    3,
                    "Pending"
            );

            /*
             * Cash on Delivery = Pending
             *
             * Bkash = Paid
             * Nagad = Paid
             * Rocket = Paid
             * Card = Paid
             */

            if ("Cash on Delivery".equals(paymentMethod)) {

                orderStmt.setString(
                        4,
                        "Pending"
                );

            } else {

                orderStmt.setString(
                        4,
                        "Paid"
                );
            }

            orderStmt.setString(
                    5,
                    order.getDeliveryAddress()
            );

            int orderRows =
                    orderStmt.executeUpdate();

            System.out.println(
                    "Orders table inserted rows: "
                    + orderRows
            );

            // =================================================
            // GET GENERATED ORDER ID
            // =================================================

            rs = orderStmt.getGeneratedKeys();

            int orderId = 0;

            if (rs.next()) {

                orderId =
                        rs.getInt(1);
            }

            System.out.println(
                    "Generated Order ID: "
                    + orderId
            );

            if (orderId == 0) {

                System.out.println(
                        "ERROR: Order ID not generated."
                );

                con.rollback();

                return -1;
            }

            // =================================================
            // 2. INSERT INTO ORDER_ITEMS
            // =================================================

            String itemSQL =
                    "INSERT INTO order_items " +
                    "(order_id, food_id, quantity, price) " +
                    "VALUES (?, ?, ?, ?)";

            itemStmt =
                    con.prepareStatement(itemSQL);

            for (Cart cart : cartList) {

                System.out.println(
                        "Adding Order Item:"
                );

                System.out.println(
                        "Food ID: "
                        + cart.getFoodId()
                );

                System.out.println(
                        "Quantity: "
                        + cart.getQuantity()
                );

                System.out.println(
                        "Price: "
                        + cart.getPrice()
                );

                itemStmt.setInt(
                        1,
                        orderId
                );

                itemStmt.setInt(
                        2,
                        cart.getFoodId()
                );

                itemStmt.setInt(
                        3,
                        cart.getQuantity()
                );

                itemStmt.setDouble(
                        4,
                        cart.getPrice()
                );

                itemStmt.addBatch();
            }

            itemStmt.executeBatch();

            System.out.println(
                    "Order items inserted successfully."
            );

            // =================================================
            // 3. INSERT INTO PAYMENTS
            // =================================================

            String paymentSQL =
                    "INSERT INTO payments " +
                    "(order_id, payment_method, amount, payment_status) " +
                    "VALUES (?, ?, ?, ?)";

            paymentStmt =
                    con.prepareStatement(paymentSQL);

            paymentStmt.setInt(
                    1,
                    orderId
            );

            paymentStmt.setString(
                    2,
                    paymentMethod
            );

            paymentStmt.setDouble(
                    3,
                    order.getTotalAmount()
            );

            if ("Cash on Delivery".equals(paymentMethod)) {

                paymentStmt.setString(
                        4,
                        "Pending"
                );

            } else {

                paymentStmt.setString(
                        4,
                        "Paid"
                );
            }

            int paymentRows =
                    paymentStmt.executeUpdate();

            System.out.println(
                    "Payment inserted rows: "
                    + paymentRows
            );

            // =================================================
            // 4. DELETE CART ITEMS
            // =================================================

            String deleteCartSQL =
                    "DELETE FROM cart WHERE user_id = ?";

            deleteCartStmt =
                    con.prepareStatement(
                            deleteCartSQL
                    );

            deleteCartStmt.setInt(
                    1,
                    order.getUserId()
            );

            int deletedRows =
                    deleteCartStmt.executeUpdate();

            System.out.println(
                    "Cart items deleted: "
                    + deletedRows
            );

            // =================================================
            // COMMIT TRANSACTION
            // =================================================

            con.commit();

            System.out.println(
                    "================================="
            );

            System.out.println(
                    "ORDER SUCCESS"
            );

            System.out.println(
                    "Order ID: " + orderId
            );

            System.out.println(
                    "Payment Method: "
                    + paymentMethod
            );

            System.out.println(
                    "================================="
            );

            return orderId;

        } catch (Exception e) {

            System.out.println(
                    "================================="
            );

            System.out.println(
                    "ORDER DAO ERROR"
            );

            System.out.println(
                    "================================="
            );

            e.printStackTrace();

            // =================================================
            // ROLLBACK
            // =================================================

            try {

                if (con != null) {

                    con.rollback();

                    System.out.println(
                            "Transaction rolled back."
                    );
                }

            } catch (Exception rollbackException) {

                rollbackException.printStackTrace();
            }

            return -1;

        } finally {

            // =================================================
            // CLOSE RESOURCES
            // =================================================

            try {

                if (rs != null) {
                    rs.close();
                }

                if (orderStmt != null) {
                    orderStmt.close();
                }

                if (itemStmt != null) {
                    itemStmt.close();
                }

                if (paymentStmt != null) {
                    paymentStmt.close();
                }

                if (deleteCartStmt != null) {
                    deleteCartStmt.close();
                }

                if (con != null) {
                    con.close();
                }

            } catch (Exception e) {

                e.printStackTrace();
            }
        }
    }


    // =========================================================
    // GET USER ORDERS
    // =========================================================

    public List<Order> getUserOrders(int userId) {

        List<Order> orderList =
                new ArrayList<>();

        String sql =
                "SELECT * FROM orders " +
                "WHERE user_id = ? " +
                "ORDER BY order_date DESC";

        try {

            Connection con =
                    DBConnection.getConnection();

            if (con == null) {

                System.out.println(
                        "ERROR: Database connection is NULL."
                );

                return orderList;
            }

            PreparedStatement pst =
                    con.prepareStatement(sql);

            pst.setInt(
                    1,
                    userId
            );

            ResultSet rs =
                    pst.executeQuery();

            while (rs.next()) {

                Order order =
                        new Order();

                order.setOrderId(
                        rs.getInt("order_id")
                );

                order.setUserId(
                        rs.getInt("user_id")
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

                orderList.add(order);
            }

            rs.close();
            pst.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orderList;
    }
}