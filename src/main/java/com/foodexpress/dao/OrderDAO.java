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
    // 1. GET ORDERS OF A USER
    // =========================================================

    public List<Order> getOrdersByUser(int userId) {

        List<Order> orderList = new ArrayList<>();

        String sql =
                "SELECT order_id, user_id, total_amount, " +
                "order_status, payment_status, delivery_address, order_date " +
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

                    if (rs.getTimestamp("order_date") != null) {

                        order.setOrderDate(
                                rs.getTimestamp("order_date").toString()
                        );
                    }

                    orderList.add(order);
                }
            }

        } catch (Exception e) {

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
                "o.order_date, " +
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

                order.setCustomerName(
                        rs.getString("full_name")
                );

                order.setEmail(
                        rs.getString("email")
                );

                order.setPhone(
                        rs.getString("phone")
                );

                if (rs.getTimestamp("order_date") != null) {

                    order.setOrderDate(
                            rs.getTimestamp("order_date").toString()
                    );
                }

                orderList.add(order);
            }

        } catch (Exception e) {

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

        ResultSet generatedKeys = null;

        int orderId = -1;

        try {

            con = DBConnection.getConnection();

            // Start transaction
            con.setAutoCommit(false);


            // =================================================
            // INSERT ORDER
            // =================================================

            String orderSQL =
                    "INSERT INTO orders " +
                    "(user_id, total_amount, order_status, " +
                    "payment_status, delivery_address) " +
                    "VALUES (?, ?, ?, ?, ?)";

            orderPst = con.prepareStatement(
                    orderSQL,
                    PreparedStatement.RETURN_GENERATED_KEYS
            );

            orderPst.setInt(
                    1,
                    order.getUserId()
            );

            orderPst.setDouble(
                    2,
                    order.getTotalAmount()
            );


            // =================================================
            // ORDER STATUS
            // =================================================

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


            // =================================================
            // PAYMENT STATUS
            // =================================================

            String paymentStatus =
                    order.getPaymentStatus();

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


            // =================================================
            // DELIVERY ADDRESS
            // =================================================

            orderPst.setString(
                    5,
                    order.getDeliveryAddress()
            );


            // =================================================
            // EXECUTE ORDER INSERT
            // =================================================

            int affectedRows =
                    orderPst.executeUpdate();

            if (affectedRows == 0) {

                con.rollback();

                return -1;
            }


            // =================================================
            // GET GENERATED ORDER ID
            // =================================================

            generatedKeys =
                    orderPst.getGeneratedKeys();

            if (generatedKeys.next()) {

                orderId =
                        generatedKeys.getInt(1);
            }

            if (orderId <= 0) {

                con.rollback();

                return -1;
            }


            System.out.println(
                    "Generated Order ID = "
                    + orderId
            );


            // =================================================
            // INSERT ORDER ITEMS
            // =================================================

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


            // =================================================
            // COMMIT
            // =================================================

            con.commit();

            System.out.println(
                    "Order successfully inserted."
            );

            System.out.println(
                    "Order ID = " + orderId
            );

            return orderId;


        } catch (Exception e) {

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

                if (orderPst != null) {
                    orderPst.close();
                }

                if (itemPst != null) {
                    itemPst.close();
                }

                if (con != null) {

                    con.setAutoCommit(true);

                    con.close();
                }

            } catch (Exception closeException) {

                closeException.printStackTrace();
            }
        }
    }


    // =========================================================
    // 4. UPDATE ORDER STATUS
    // =========================================================

    public boolean updateOrderStatus(
            int orderId,
            String status) {

        boolean updated = false;

        String sql =
                "UPDATE orders " +
                "SET order_status=? " +
                "WHERE order_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst =
                        con.prepareStatement(sql)
        ) {

            pst.setString(
                    1,
                    status
            );

            pst.setInt(
                    2,
                    orderId
            );

            int rows =
                    pst.executeUpdate();

            if (rows > 0) {

                updated = true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return updated;
    }


    // =========================================================
    // 5. DELETE ORDER
    // =========================================================

    public boolean deleteOrder(int orderId) {

        Connection con = null;

        PreparedStatement itemPst = null;
        PreparedStatement orderPst = null;

        boolean deleted = false;

        try {

            con = DBConnection.getConnection();

            con.setAutoCommit(false);


            // =================================================
            // DELETE ORDER ITEMS FIRST
            // =================================================

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


            // =================================================
            // DELETE ORDER
            // =================================================

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

                deleted = true;

            } else {

                con.rollback();
            }


        } catch (Exception e) {

            e.printStackTrace();

            try {

                if (con != null) {

                    con.rollback();
                }

            } catch (Exception rollbackException) {

                rollbackException.printStackTrace();
            }


        } finally {

            try {

                if (itemPst != null) {
                    itemPst.close();
                }

                if (orderPst != null) {
                    orderPst.close();
                }

                if (con != null) {

                    con.setAutoCommit(true);

                    con.close();
                }

            } catch (Exception closeException) {

                closeException.printStackTrace();
            }
        }

        return deleted;
    }
}