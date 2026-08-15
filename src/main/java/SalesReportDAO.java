package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SalesReportDAO {

    // =====================================================
    // TOTAL ORDERS
    // =====================================================

    public int getTotalOrders() {

        int totalOrders = 0;

        String sql = "SELECT COUNT(*) FROM orders";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            if (rs.next()) {

                totalOrders = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return totalOrders;
    }


    // =====================================================
    // TOTAL REVENUE
    // =====================================================

    public double getTotalRevenue() {

        double totalRevenue = 0;

        String sql =
            "SELECT COALESCE(SUM(total_amount), 0) " +
            "FROM orders " +
            "WHERE order_status <> 'Cancelled'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            if (rs.next()) {

                totalRevenue = rs.getDouble(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return totalRevenue;
    }


    // =====================================================
    // TODAY'S ORDERS
    // =====================================================

    public int getTodayOrders() {

        int todayOrders = 0;

        String sql =
            "SELECT COUNT(*) " +
            "FROM orders " +
            "WHERE DATE(order_date) = CURDATE()";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            if (rs.next()) {

                todayOrders = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return todayOrders;
    }


    // =====================================================
    // TODAY'S SALES
    // =====================================================

    public double getTodaySales() {

        double todaySales = 0;

        String sql =
            "SELECT COALESCE(SUM(total_amount), 0) " +
            "FROM orders " +
            "WHERE DATE(order_date) = CURDATE() " +
            "AND order_status <> 'Cancelled'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            if (rs.next()) {

                todaySales = rs.getDouble(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return todaySales;
    }


    // =====================================================
    // PENDING ORDERS
    // =====================================================

    public int getPendingOrders() {

        int pendingOrders = 0;

        String sql =
            "SELECT COUNT(*) " +
            "FROM orders " +
            "WHERE order_status = 'Pending'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            if (rs.next()) {

                pendingOrders = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return pendingOrders;
    }


    // =====================================================
    // PREPARING ORDERS
    // =====================================================

    public int getPreparingOrders() {

        int preparingOrders = 0;

        String sql =
            "SELECT COUNT(*) " +
            "FROM orders " +
            "WHERE order_status = 'Preparing'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            if (rs.next()) {

                preparingOrders = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return preparingOrders;
    }


    // =====================================================
    // DELIVERED ORDERS
    // =====================================================

    public int getDeliveredOrders() {

        int deliveredOrders = 0;

        String sql =
            "SELECT COUNT(*) " +
            "FROM orders " +
            "WHERE order_status = 'Delivered'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            if (rs.next()) {

                deliveredOrders = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return deliveredOrders;
    }


    // =====================================================
    // CANCELLED ORDERS
    // =====================================================

    public int getCancelledOrders() {

        int cancelledOrders = 0;

        String sql =
            "SELECT COUNT(*) " +
            "FROM orders " +
            "WHERE order_status = 'Cancelled'";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {

            if (rs.next()) {

                cancelledOrders = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return cancelledOrders;
    }
}