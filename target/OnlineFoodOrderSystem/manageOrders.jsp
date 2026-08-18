<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.foodexpress.model.Order"%>

<%
    if (session == null ||
        session.getAttribute("admin") == null) {

        response.sendRedirect("adminLogin.jsp");
        return;
    }

    List<Order> orderList =
            (List<Order>) request.getAttribute("orderList");

    String success =
            request.getParameter("success");

    String error =
            request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Orders - FoodExpress</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f4faff;
            color: #263238;
        }


        /* =====================================================
           NAVBAR
        ===================================================== */

        .navbar {
            height: 72px;
            background: #ffffff;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 6%;

            box-shadow: 0 2px 12px rgba(70, 130, 180, 0.10);

            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo {
            text-decoration: none;

            font-size: 25px;
            font-weight: 800;

            color: #4da6d8;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .nav-links a {
            text-decoration: none;

            color: #455a64;

            font-size: 14px;
            font-weight: 600;
        }

        .nav-links a:hover {
            color: #3b9ac4;
        }


        /* =====================================================
           PAGE
        ===================================================== */

        .container {
            width: 94%;
            max-width: 1350px;

            margin: 35px auto 60px;
        }

        .page-header {
            margin-bottom: 25px;
        }

        .page-header h1 {
            color: #263238;
            font-size: 30px;
            margin-bottom: 7px;
        }

        .page-header p {
            color: #78909c;
            font-size: 14px;
        }


        /* =====================================================
           ALERTS
        ===================================================== */

        .alert {
            padding: 13px 18px;

            border-radius: 9px;

            margin-bottom: 20px;

            font-size: 14px;
            font-weight: 600;
        }

        .success {
            background: #e7f7ef;
            color: #238b57;
            border: 1px solid #bce8d0;
        }

        .error {
            background: #fff0f0;
            color: #c94b4b;
            border: 1px solid #f2c3c3;
        }


        /* =====================================================
           ORDER CARD
        ===================================================== */

        .orders-wrapper {
            display: flex;
            flex-direction: column;

            gap: 20px;
        }

        .order-card {
            background: #ffffff;

            border-radius: 16px;

            box-shadow:
                0 5px 20px rgba(70, 130, 180, 0.09);

            border: 1px solid #e4f1f8;

            overflow: hidden;
        }


        /* =====================================================
           CARD HEADER
        ===================================================== */

        .order-header {
            background: #eaf7fd;

            padding: 17px 22px;

            display: flex;
            justify-content: space-between;
            align-items: center;

            border-bottom: 1px solid #d8edf7;
        }

        .order-number {
            font-size: 18px;
            font-weight: 800;

            color: #267da6;
        }

        .order-date {
            color: #78909c;
            font-size: 12px;
        }


        /* =====================================================
           ORDER BODY
        ===================================================== */

        .order-body {
            padding: 23px;
        }

        .customer-section {
            margin-bottom: 22px;
        }

        .section-title {
            font-size: 15px;

            color: #267da6;

            margin-bottom: 13px;

            font-weight: 700;
        }

        .customer-grid {
            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 12px;
        }

        .info-box {
            background: #f7fbfe;

            border-radius: 9px;

            padding: 13px;
        }

        .info-box label {
            display: block;

            font-size: 11px;

            color: #90a4ae;

            margin-bottom: 6px;

            text-transform: uppercase;
        }

        .info-box span {
            font-size: 14px;

            color: #37474f;

            font-weight: 600;

            word-break: break-word;
        }


        /* =====================================================
           ORDER MANAGEMENT
        ===================================================== */

        .manage-section {
            border-top: 1px solid #edf4f7;

            padding-top: 20px;
        }

        .form-grid {
            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 15px;
        }

        .form-group {
            display: flex;

            flex-direction: column;
        }

        .form-group label {
            font-size: 12px;

            color: #607d8b;

            font-weight: 700;

            margin-bottom: 7px;
        }

        .form-group select,
        .form-group input {
            width: 100%;

            height: 42px;

            border: 1px solid #cfe5ef;

            border-radius: 8px;

            padding: 0 11px;

            background: #ffffff;

            color: #37474f;

            font-size: 13px;

            outline: none;
        }

        .form-group select:focus,
        .form-group input:focus {
            border-color: #66b9df;

            box-shadow:
                0 0 0 3px rgba(
                    102,
                    185,
                    223,
                    0.12
                );
        }


        /* =====================================================
           READ ONLY CUSTOMER INFO
        ===================================================== */

        .readonly-field {
            width: 100%;

            min-height: 42px;

            border: 1px solid #e1edf3;

            border-radius: 8px;

            padding: 11px;

            background: #f7fbfe;

            color: #455a64;

            font-size: 13px;

            font-weight: 600;

            display: flex;

            align-items: center;
        }

        .method-pickup {
            color: #7b1fa2;
        }

        .method-delivery {
            color: #2e7d32;
        }

        .not-available {
            color: #90a4ae;
            font-weight: 500;
        }


        /* =====================================================
           UPDATE BUTTON
        ===================================================== */

        .form-actions {
            margin-top: 18px;

            display: flex;

            justify-content: flex-end;
        }

        .update-btn {
            border: none;

            background: #5aaed6;

            color: #ffffff;

            padding: 11px 24px;

            border-radius: 8px;

            font-size: 13px;

            font-weight: 700;

            cursor: pointer;

            transition: 0.2s;
        }

        .update-btn:hover {
            background: #4299c3;
        }


        /* =====================================================
           EMPTY
        ===================================================== */

        .empty {
            background: #ffffff;

            padding: 50px;

            text-align: center;

            border-radius: 15px;

            box-shadow:
                0 5px 20px rgba(
                    70,
                    130,
                    180,
                    0.08
                );
        }

        .empty h2 {
            color: #607d8b;

            margin-bottom: 8px;
        }

        .empty p {
            color: #90a4ae;

            font-size: 14px;
        }


        /* =====================================================
           BACK BUTTON
        ===================================================== */

        .back-area {
            margin-top: 25px;
        }

        .back-btn {
            display: inline-block;

            text-decoration: none;

            background: #e8f5fb;

            color: #317fa5;

            padding: 11px 20px;

            border-radius: 8px;

            font-size: 13px;

            font-weight: 700;
        }

        .back-btn:hover {
            background: #d8edf7;
        }


        /* =====================================================
           MOBILE
        ===================================================== */

        @media (max-width: 1000px) {

            .form-grid {
                grid-template-columns:
                    repeat(2, 1fr);
            }

            .customer-grid {
                grid-template-columns:
                    repeat(2, 1fr);
            }
        }


        @media (max-width: 700px) {

            .navbar {
                padding: 0 20px;
            }

            .nav-links {
                gap: 12px;
            }

            .nav-links a {
                font-size: 11px;
            }

            .container {
                width: 94%;
            }

            .customer-grid {
                grid-template-columns: 1fr;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .order-header {
                flex-direction: column;

                align-items: flex-start;

                gap: 6px;
            }

            .form-actions {
                justify-content: stretch;
            }

            .update-btn {
                width: 100%;
            }
        }

    </style>

</head>


<body>


<!-- =========================================================
     NAVBAR
========================================================= -->

<nav class="navbar">

    <a href="adminDashboard.jsp"
       class="logo">

        FoodExpress

    </a>


    <div class="nav-links">

        <a href="adminDashboard.jsp">
            Dashboard
        </a>

        <a href="ManageOrderServlet">
            Manage Orders
        </a>

        <a href="ManageOfferServlet">
            Manage Offers
        </a>

        <a href="LogoutServlet">
            Logout
        </a>

    </div>

</nav>



<!-- =========================================================
     MAIN
========================================================= -->

<div class="container">


    <div class="page-header">

        <h1>
            Manage Orders
        </h1>

        <p>
            Manage order status and estimated delivery time.
        </p>

    </div>



    <!-- =====================================================
         SUCCESS MESSAGE
    ===================================================== -->

    <% if ("updated".equals(success)) { %>

        <div class="alert success">

            Order information updated successfully.

        </div>

    <% } %>



    <!-- =====================================================
         ERROR MESSAGES
    ===================================================== -->

    <% if ("update".equals(error)) { %>

        <div class="alert error">

            Failed to update order information.

        </div>

    <% } %>


    <% if ("database".equals(error)) { %>

        <div class="alert error">

            Database error occurred while updating the order.

        </div>

    <% } %>


    <% if ("invalid".equals(error)) { %>

        <div class="alert error">

            Invalid order information.

        </div>

    <% } %>


    <% if ("invalidStatus".equals(error)) { %>

        <div class="alert error">

            Invalid order status selected.

        </div>

    <% } %>


    <% if ("notfound".equals(error)) { %>

        <div class="alert error">

            Order not found.

        </div>

    <% } %>


    <% if ("pickup".equals(error)) { %>

        <div class="alert error">

            Pickup orders do not require estimated delivery time.

        </div>

    <% } %>



    <!-- =====================================================
         ORDERS
    ===================================================== -->

    <% if (orderList == null ||
           orderList.isEmpty()) { %>


        <div class="empty">

            <h2>
                No Orders Found
            </h2>

            <p>
                There are currently no customer orders.
            </p>

        </div>


    <% } else { %>


        <div class="orders-wrapper">


            <% for (Order order : orderList) { %>


                <div class="order-card">


                    <!-- =====================================
                         HEADER
                    ====================================== -->

                    <div class="order-header">

                        <div class="order-number">

                            Order #<%= order.getOrderId() %>

                        </div>


                        <div class="order-date">

                            <% if (order.getOrderDate() != null) { %>

                                <%= order.getOrderDate() %>

                            <% } else { %>

                                Date not available

                            <% } %>

                        </div>

                    </div>



                    <div class="order-body">


                        <!-- =================================
                             CUSTOMER INFORMATION
                        ================================== -->

                        <div class="customer-section">

                            <div class="section-title">

                                Customer Information

                            </div>


                            <div class="customer-grid">


                                <div class="info-box">

                                    <label>
                                        Customer
                                    </label>

                                    <span>

                                        <%= order.getCustomerName() != null
                                                ? order.getCustomerName()
                                                : "Unknown" %>

                                    </span>

                                </div>


                                <div class="info-box">

                                    <label>
                                        Email
                                    </label>

                                    <span>

                                        <%= order.getEmail() != null
                                                ? order.getEmail()
                                                : "Not available" %>

                                    </span>

                                </div>


                                <div class="info-box">

                                    <label>
                                        Phone
                                    </label>

                                    <span>

                                        <%= order.getPhone() != null
                                                ? order.getPhone()
                                                : "Not available" %>

                                    </span>

                                </div>


                                <div class="info-box">

                                    <label>
                                        Total Amount
                                    </label>

                                    <span>

                                        ৳ <%= String.format(
                                                "%.2f",
                                                order.getTotalAmount()
                                        ) %>

                                    </span>

                                </div>


                                <div class="info-box">

                                    <label>
                                        Payment
                                    </label>

                                    <span>

                                        <%= order.getPaymentStatus() != null
                                                ? order.getPaymentStatus()
                                                : "Pending" %>

                                    </span>

                                </div>


                                <div class="info-box">

                                    <label>
                                        Address
                                    </label>

                                    <span>

                                        <%= order.getDeliveryAddress() != null &&
                                            !order.getDeliveryAddress().trim().isEmpty()
                                                ? order.getDeliveryAddress()
                                                : "No address" %>

                                    </span>

                                </div>


                            </div>

                        </div>



                        <!-- =================================
                             ORDER MANAGEMENT
                        ================================== -->

                        <div class="manage-section">


                            <div class="section-title">

                                Order Management

                            </div>


                            <form action="ManageOrderServlet"
                                  method="post">


                                <input type="hidden"
                                       name="orderId"
                                       value="<%= order.getOrderId() %>">



                                <div class="form-grid">


                                    <!-- STATUS -->

                                    <div class="form-group">

                                        <label>
                                            Order Status
                                        </label>


                                        <select name="orderStatus"
                                                required>


                                            <option value="Pending"
                                                <%= "Pending".equalsIgnoreCase(
                                                        order.getOrderStatus()
                                                ) ? "selected" : "" %>>

                                                Pending

                                            </option>


                                            <option value="Preparing"
                                                <%= "Preparing".equalsIgnoreCase(
                                                        order.getOrderStatus()
                                                ) ? "selected" : "" %>>

                                                Preparing

                                            </option>


                                            <option value="Delivered"
                                                <%= "Delivered".equalsIgnoreCase(
                                                        order.getOrderStatus()
                                                ) ? "selected" : "" %>>

                                                Delivered

                                            </option>


                                            <option value="Cancelled"
                                                <%= "Cancelled".equalsIgnoreCase(
                                                        order.getOrderStatus()
                                                ) ? "selected" : "" %>>

                                                Cancelled

                                            </option>


                                        </select>

                                    </div>



                                    <!-- DELIVERY METHOD -->
                                    <!-- CUSTOMER SELECTED -->

                                    <div class="form-group">

                                        <label>
                                            Delivery Method
                                        </label>


                                        <div class="readonly-field">

                                            <%
                                                String deliveryMethod =
                                                        order.getDeliveryMethod();

                                                if (deliveryMethod == null ||
                                                    deliveryMethod.trim().isEmpty()) {
                                            %>

                                                <span class="not-available">
                                                    Not Available
                                                </span>

                                            <%
                                                } else if ("Pickup".equalsIgnoreCase(
                                                        deliveryMethod)) {
                                            %>

                                                <span class="method-pickup">
                                                    Pickup
                                                </span>

                                            <%
                                                } else {
                                            %>

                                                <span class="method-delivery">
                                                    Delivery
                                                </span>

                                            <%
                                                }
                                            %>

                                        </div>

                                    </div>



                                    <!-- PICKUP TIME -->
                                    <!-- CUSTOMER SELECTED -->

                                    <div class="form-group">

                                        <label>
                                            Pickup Time
                                        </label>


                                        <div class="readonly-field">

                                            <%
                                                String pickupTime =
                                                        order.getPickupTime();

                                                if (pickupTime != null &&
                                                    !pickupTime.trim().isEmpty()) {
                                            %>

                                                <%= pickupTime %>

                                            <%
                                                } else {
                                            %>

                                                <span class="not-available">
                                                    N/A
                                                </span>

                                            <%
                                                }
                                            %>

                                        </div>

                                    </div>



                                    <!-- ESTIMATED DELIVERY TIME -->
                                    <!-- ADMIN CAN UPDATE -->

                                    <div class="form-group">

                                        <label>
                                            Estimated Delivery Time
                                        </label>


                                        <input
                                            type="text"
                                            name="estimatedDeliveryTime"
                                            value="<%= order.getEstimatedDeliveryTime() != null
                                                    ? order.getEstimatedDeliveryTime()
                                                    : "" %>"
                                            placeholder="e.g. 7:30 PM"
                                        >

                                    </div>


                                </div>



                                <!-- UPDATE BUTTON -->

                                <div class="form-actions">

                                    <button type="submit"
                                            class="update-btn">

                                        Update Order

                                    </button>

                                </div>


                            </form>


                        </div>


                    </div>

                </div>


            <% } %>


        </div>


    <% } %>



    <!-- =====================================================
         BACK
    ===================================================== -->

    <div class="back-area">

        <a href="adminDashboard.jsp"
           class="back-btn">

            ← Back to Dashboard

        </a>

    </div>


</div>


</body>

</html>