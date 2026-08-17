package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.Cart;
import com.foodexpress.model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // =====================================================
    // PLACE ORDER
    // =====================================================

    public int placeOrder(
            Order order,
            List<Cart> cartList,
            String paymentMethod) {

        Connection con = null;
        PreparedStatement orderPst = null;
        PreparedStatement itemPst = null;
        PreparedStatement clearPst = null;
        ResultSet rs = null;

        int orderId = -1;

        try {

            con = DBConnection.getConnection();

            con.setAutoCommit(false);

            // =============================================
            // INSERT ORDER
            // =============================================

            String orderSql =
                    "INSERT INTO orders " +
                    "(user_id, total_amount, order_status, " +
                    "payment_status, delivery_address) " +
                    "VALUES (?, ?, ?, ?, ?)";

            orderPst = con.prepareStatement(
                    orderSql,
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

            orderPst.setString(
                    3,
                    order.getOrderStatus()
            );

            orderPst.setString(
                    4,
                    order.getPaymentStatus()
            );

            orderPst.setString(
                    5,
                    order.getDeliveryAddress()
            );

            int rows =
                    orderPst.executeUpdate();

            if (rows == 0) {

                con.rollback();

                return -1;
            }

            // =============================================
            // GET GENERATED ORDER ID
            // =============================================

            rs =
                    orderPst.getGeneratedKeys();

            if (rs.next()) {

                orderId =
                        rs.getInt(1);

            } else {

                con.rollback();

                return -1;
            }

            // =============================================
            // INSERT ORDER ITEMS
            // =============================================

            /*
             * This code assumes an order_items table.
             *
             * If you do not have order_items table yet,
             * comment this section temporarily.
             */

            String itemSql =
                    "INSERT INTO order_items " +
                    "(order_id, food_id, quantity, price) " +
                    "VALUES (?, ?, ?, ?)";

            try {

                itemPst =
                        con.prepareStatement(itemSql);

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

            } catch (Exception e) {

                /*
                 * If order_items table does not exist,
                 * order itself can still be saved.
                 */

                System.out.println(
                        "Order items table not available."
                );

            }

            // =============================================
            // CLEAR CART
            // =============================================

            String clearSql =
                    "DELETE FROM cart WHERE user_id=?";

            clearPst =
                    con.prepareStatement(clearSql);

            clearPst.setInt(
                    1,
                    order.getUserId()
            );

            clearPst.executeUpdate();

            // =============================================
            // COMMIT
            // =============================================

            con.commit();

            return orderId;

        } catch (Exception e) {

            e.printStackTrace();

            try {

                if (con != null) {
                    con.rollback();
                }

            } catch (Exception ex) {
                ex.printStackTrace();
            }

            return -1;

        } finally {

            try {
                if (rs != null) rs.close();
            } catch (Exception e) {
            }

            try {
                if (orderPst != null) orderPst.close();
            } catch (Exception e) {
            }

            try {
                if (itemPst != null) itemPst.close();
            } catch (Exception e) {
            }

            try {
                if (clearPst != null) clearPst.close();
            } catch (Exception e) {
            }

            try {
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (Exception e) {
            }
        }
    }


    // =====================================================
    // GET ORDERS OF USER
    // =====================================================

    public List<Order> getOrdersByUser(int userId) {

        List<Order> orderList =
                new ArrayList<>();

        String sql =
                "SELECT order_id, user_id, total_amount, " +
                "order_status, payment_status, " +
                "delivery_address, order_date " +
                "FROM orders " +
                "WHERE user_id=? " +
                "ORDER BY order_date DESC";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement pst =
                        con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    userId
            );

            try (
                    ResultSet rs =
                            pst.executeQuery()
            ) {

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

                    /*
                     * Order.java uses String.
                     * Therefore Timestamp is converted
                     * to String.
                     */

                    order.setOrderDate(
                            rs.getTimestamp("order_date")
                               .toString()
                    );

                    orderList.add(order);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orderList;
    }


    // =====================================================
    // GET ALL ORDERS - ADMIN
    // =====================================================

    public List<Order> getAllOrders() {

        List<Order> orderList =
                new ArrayList<>();

        String sql =
                "SELECT o.order_id, o.user_id, " +
                "o.total_amount, o.order_status, " +
                "o.payment_status, o.delivery_address, " +
                "o.order_date, " +
                "u.full_name, u.email, u.phone " +
                "FROM orders o " +
                "INNER JOIN users u " +
                "ON o.user_id = u.user_id " +
                "ORDER BY o.order_date DESC";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement pst =
                        con.prepareStatement(sql);

                ResultSet rs =
                        pst.executeQuery()
        ) {

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
                        rs.getTimestamp("order_date")
                           .toString()
                );

                orderList.add(order);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orderList;
    }


    // =====================================================
    // UPDATE ORDER STATUS
    // =====================================================

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

            pst.setString(
                    1,
                    status
            );

            pst.setInt(
                    2,
                    orderId
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // DELETE ORDER
    // =====================================================

    public boolean deleteOrder(
            int orderId) {

        String sql =
                "DELETE FROM orders " +
                "WHERE order_id=?";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement pst =
                        con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    orderId
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}