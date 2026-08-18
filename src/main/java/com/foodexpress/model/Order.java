package com.foodexpress.model;

import java.sql.Timestamp;

public class Order {

    private int orderId;
    private int userId;
    private double totalAmount;

    private String orderStatus;
    private String paymentStatus;

    private String deliveryAddress;

    private Timestamp orderDate;

    private String deliveryMethod;
    private String pickupTime;
    private String estimatedDeliveryTime;

    private String orderType;

    // Customer information
    private String customerName;
    private String email;
    private String phone;

    public Order() {
    }

    // =========================
    // ORDER ID
    // =========================

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    // =========================
    // USER ID
    // =========================

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    // =========================
    // TOTAL AMOUNT
    // =========================

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    // =========================
    // ORDER STATUS
    // =========================

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    // =========================
    // PAYMENT STATUS
    // =========================

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    // =========================
    // DELIVERY ADDRESS
    // =========================

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    // =========================
    // ORDER DATE
    // =========================

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    // =========================
    // DELIVERY METHOD
    // =========================

    public String getDeliveryMethod() {
        return deliveryMethod;
    }

    public void setDeliveryMethod(String deliveryMethod) {
        this.deliveryMethod = deliveryMethod;
    }

    // =========================
    // PICKUP TIME
    // =========================

    public String getPickupTime() {
        return pickupTime;
    }

    public void setPickupTime(String pickupTime) {
        this.pickupTime = pickupTime;
    }

    // =========================
    // ESTIMATED DELIVERY TIME
    // =========================

    public String getEstimatedDeliveryTime() {
        return estimatedDeliveryTime;
    }

    public void setEstimatedDeliveryTime(String estimatedDeliveryTime) {
        this.estimatedDeliveryTime = estimatedDeliveryTime;
    }

    // =========================
    // ORDER TYPE
    // =========================

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    // =========================
    // CUSTOMER NAME
    // =========================

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    // =========================
    // CUSTOMER EMAIL
    // =========================

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // =========================
    // CUSTOMER PHONE
    // =========================

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}