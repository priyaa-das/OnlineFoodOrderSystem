package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.Cart;
import com.foodexpress.model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // =========================================================
    // 1. GET ORDERS OF A USER
    // =========================================================

    public List<Order> getOrdersByUser(int userId) {

        List<Order> orderList = new ArrayList<>();

        String sql =
                "SELECT order_id, user_id, total_amount, " +
                "order_status, payment_status, delivery_address, " +
                "order_date, delivery_method, pickup_time, " +
                "estimated_delivery_time " +
                "FROM orders " +
                "WHERE user_id=? " +
                "ORDER BY order_date DESC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setInt(1, userId);

            try (ResultSet rs = pst.executeQuery()) {

                while (rs.next()) {

                    Order order = new Order();

                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalAmount(rs.getDouble("total_amount"));

                    order.setOrderStatus(
                            rs.getString("order_status")
                    );

                    order.setPaymentStatus(
                            rs.getString("payment_status")
                    );

                    order.setDeliveryAddress(
                            rs.getString("delivery_address")
                    );

                    Timestamp orderDate =
                            rs.getTimestamp("order_date");

                    if (orderDate != null) {
                        order.setOrderDate(orderDate);
                    }

                    order.setDeliveryMethod(
                            rs.getString("delivery_method")
                    );

                    order.setPickupTime(
                            rs.getString("pickup_time")
                    );

                    order.setEstimatedDeliveryTime(
                            rs.getString("estimated_delivery_time")
                    );

                    orderList.add(order);
                }
            }

        } catch (Exception e) {

            System.out.println("GET USER ORDERS ERROR");
            e.printStackTrace();
        }

        return orderList;
    }


    // =========================================================
    // 2. GET ALL ORDERS FOR ADMIN
    // =========================================================

    public List<Order> getAllOrders() {

        List<Order> orderList = new ArrayList<>();

        String sql =
                "SELECT o.order_id, o.user_id, " +
                "o.total_amount, o.order_status, " +
                "o.payment_status, o.delivery_address, " +
                "o.order_date, o.delivery_method, " +
                "o.pickup_time, o.estimated_delivery_time, " +
                "u.full_name, u.email, u.phone " +
                "FROM orders o " +
                "LEFT JOIN users u " +
                "ON o.user_id = u.user_id " +
                "ORDER BY o.order_date DESC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql);
                ResultSet rs = pst.executeQuery()
        ) {

            while (rs.next()) {

                Order order = new Order();

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

                Timestamp orderDate =
                        rs.getTimestamp("order_date");

                if (orderDate != null) {
                    order.setOrderDate(orderDate);
                }

                order.setDeliveryMethod(
                        rs.getString("delivery_method")
                );

                order.setPickupTime(
                        rs.getString("pickup_time")
                );

                order.setEstimatedDeliveryTime(
                        rs.getString("estimated_delivery_time")
                );

                orderList.add(order);
            }

        } catch (Exception e) {

            System.out.println("GET ALL ORDERS ERROR");
            e.printStackTrace();
        }

        return orderList;
    }


    // =========================================================
    // 3. PLACE ORDER
    // =========================================================

    public int placeOrder(
            Order order,
            List<Cart> cartList,
            String paymentMethod) {

        Connection con = null;

        PreparedStatement orderPst = null;
        PreparedStatement itemPst = null;
        PreparedStatement clearPst = null;

        ResultSet generatedKeys = null;

        int orderId = -1;

        try {

            con = DBConnection.getConnection();

            con.setAutoCommit(false);

            String orderSQL =
                    "INSERT INTO orders " +
                    "(user_id, total_amount, order_status, " +
                    "payment_status, delivery_address, " +
                    "delivery_method, pickup_time, " +
                    "estimated_delivery_time) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            orderPst = con.prepareStatement(
                    orderSQL,
                    Statement.RETURN_GENERATED_KEYS
            );

            orderPst.setInt(
                    1,
                    order.getUserId()
            );

            orderPst.setDouble(
                    2,
                    order.getTotalAmount()
            );

            String orderStatus =
                    order.getOrderStatus();

            if (orderStatus == null ||
                orderStatus.trim().isEmpty()) {

                orderStatus = "Pending";
            }

            orderPst.setString(
                    3,
                    orderStatus
            );

            String paymentStatus =
                    paymentMethod;

            if (paymentStatus == null ||
                paymentStatus.trim().isEmpty()) {

                paymentStatus = "Pending";
            }

            if (paymentStatus.equalsIgnoreCase("Paid")) {
                paymentStatus = "Paid";
            } else {
                paymentStatus = "Pending";
            }

            orderPst.setString(
                    4,
                    paymentStatus
            );

            orderPst.setString(
                    5,
                    order.getDeliveryAddress()
            );

            String deliveryMethod =
                    order.getDeliveryMethod();

            if (deliveryMethod == null ||
                deliveryMethod.trim().isEmpty()) {

                deliveryMethod = "Delivery";
            }

            orderPst.setString(
                    6,
                    deliveryMethod
            );

            orderPst.setString(
                    7,
                    order.getPickupTime()
            );

            orderPst.setString(
                    8,
                    order.getEstimatedDeliveryTime()
            );

            int rows =
                    orderPst.executeUpdate();

            if (rows == 0) {

                con.rollback();

                return -1;
            }

            generatedKeys =
                    orderPst.getGeneratedKeys();

            if (generatedKeys.next()) {

                orderId =
                        generatedKeys.getInt(1);

            } else {

                con.rollback();

                return -1;
            }

            String itemSQL =
                    "INSERT INTO order_items " +
                    "(order_id, food_id, quantity, price) " +
                    "VALUES (?, ?, ?, ?)";

            itemPst =
                    con.prepareStatement(itemSQL);

            for (Cart cart : cartList) {

                itemPst.setInt(
                        1,
                        orderId
                );

                itemPst.setInt(
                        2,
                        cart.getFoodId()
                );

                itemPst.setInt(
                        3,
                        cart.getQuantity()
                );

                itemPst.setDouble(
                        4,
                        cart.getPrice()
                );

                itemPst.addBatch();
            }

            itemPst.executeBatch();

            String clearSQL =
                    "DELETE FROM cart WHERE user_id=?";

            clearPst =
                    con.prepareStatement(clearSQL);

            clearPst.setInt(
                    1,
                    order.getUserId()
            );

            clearPst.executeUpdate();

            con.commit();

            return orderId;

        } catch (Exception e) {

            System.out.println("PLACE ORDER ERROR");
            e.printStackTrace();

            try {

                if (con != null) {
                    con.rollback();
                }

            } catch (Exception rollbackException) {
                rollbackException.printStackTrace();
            }

            return -1;

        } finally {

            try {
                if (generatedKeys != null) {
                    generatedKeys.close();
                }
            } catch (Exception e) {
            }

            try {
                if (orderPst != null) {
                    orderPst.close();
                }
            } catch (Exception e) {
            }

            try {
                if (itemPst != null) {
                    itemPst.close();
                }
            } catch (Exception e) {
            }

            try {
                if (clearPst != null) {
                    clearPst.close();
                }
            } catch (Exception e) {
            }

            try {

                if (con != null) {

                    try {
                        con.setAutoCommit(true);
                    } catch (Exception e) {
                    }

                    try {
                        con.close();
                    } catch (Exception e) {
                    }
                }

            } catch (Exception e) {
            }
        }
    }


    // =========================================================
    // 4. UPDATE ONLY ORDER STATUS
    // =========================================================

    public boolean updateOrderStatus(
            int orderId,
            String status) {

        String sql =
                "UPDATE orders " +
                "SET order_status=? " +
                "WHERE order_id=?";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement pst =
                        con.prepareStatement(sql)
        ) {

            pst.setString(1, status);
            pst.setInt(2, orderId);

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "UPDATE ORDER STATUS ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // 5. UPDATE COMPLETE ORDER DETAILS
    // =========================================================

    public boolean updateOrderDetails(
            int orderId,
            String orderStatus,
            String deliveryMethod,
            String pickupTime,
            String estimatedDeliveryTime) {

        String sql =
                "UPDATE orders SET " +
                "order_status=?, " +
                "delivery_method=?, " +
                "pickup_time=?, " +
                "estimated_delivery_time=? " +
                "WHERE order_id=?";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement pst =
                        con.prepareStatement(sql)
        ) {

            pst.setString(
                    1,
                    orderStatus
            );

            pst.setString(
                    2,
                    deliveryMethod
            );

            pst.setString(
                    3,
                    pickupTime
            );

            pst.setString(
                    4,
                    estimatedDeliveryTime
            );

            pst.setInt(
                    5,
                    orderId
            );

            int rows =
                    pst.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            System.out.println(
                    "UPDATE ORDER DETAILS ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // 6. DELETE ORDER
    // =========================================================

    public boolean deleteOrder(
            int orderId) {

        Connection con = null;

        PreparedStatement itemPst = null;
        PreparedStatement orderPst = null;

        try {

            con =
                    DBConnection.getConnection();

            con.setAutoCommit(false);

            String itemSQL =
                    "DELETE FROM order_items " +
                    "WHERE order_id=?";

            itemPst =
                    con.prepareStatement(itemSQL);

            itemPst.setInt(
                    1,
                    orderId
            );

            itemPst.executeUpdate();

            String orderSQL =
                    "DELETE FROM orders " +
                    "WHERE order_id=?";

            orderPst =
                    con.prepareStatement(orderSQL);

            orderPst.setInt(
                    1,
                    orderId
            );

            int rows =
                    orderPst.executeUpdate();

            if (rows > 0) {

                con.commit();

                return true;

            } else {

                con.rollback();

                return false;
            }

        } catch (Exception e) {

            System.out.println(
                    "DELETE ORDER ERROR"
            );

            e.printStackTrace();

            try {

                if (con != null) {
                    con.rollback();
                }

            } catch (Exception ex) {
                ex.printStackTrace();
            }

            return false;

        } finally {

            try {
                if (itemPst != null) {
                    itemPst.close();
                }
            } catch (Exception e) {
            }

            try {
                if (orderPst != null) {
                    orderPst.close();
                }
            } catch (Exception e) {
            }

            try {

                if (con != null) {

                    try {
                        con.setAutoCommit(true);
                    } catch (Exception e) {
                    }

                    try {
                        con.close();
                    } catch (Exception e) {
                    }
                }

            } catch (Exception e) {
            }
        }
    }
}