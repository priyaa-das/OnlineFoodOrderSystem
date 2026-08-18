<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.foodexpress.model.Order"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Admin Orders</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f6fa;
        }

        .header {
            background: #222;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
        }

        .container {
            width: 95%;
            margin: 30px auto;
        }

        .table-box {
            background: white;
            padding: 20px;
            border-radius: 10px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #333;
            color: white;
            padding: 12px;
        }

        td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        select {
            padding: 6px;
        }

        input[type="time"] {
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .update-btn {
            background: #2196F3;
            color: white;
            border: none;
            padding: 7px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        .update-btn:hover {
            background: #1976D2;
        }

        .delete {
            background: #dc3545;
            color: white;
            padding: 7px 12px;
            text-decoration: none;
            border-radius: 5px;
        }

        .delete:hover {
            background: #b02a37;
        }

        .method {
            font-weight: 600;
            color: #1565c0;
        }

        .pickup {
            color: #7b1fa2;
            font-weight: 600;
        }

        .delivery {
            color: #2e7d32;
            font-weight: 600;
        }

        .empty {
            padding: 30px;
            color: #777;
        }

    </style>

</head>


<body>


<div class="header">

    <h2>Online Food Order System</h2>

    <span>Admin Order Management</span>

</div>


<div class="container">

    <h2>All Orders</h2>


    <div class="table-box">

        <table>

            <tr>

                <th>Order ID</th>
                <th>Customer</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Total</th>
                <th>Order Status</th>
                <th>Payment</th>
                <th>Address</th>
                <th>Method</th>
                <th>Pickup Time</th>
                <th>Estimated Delivery Time</th>
                <th>Date</th>
                <th>Action</th>

            </tr>


            <%

                List<Order> orders =
                        (List<Order>)
                        request.getAttribute("orders");


                if (orders != null &&
                    !orders.isEmpty()) {


                    for (Order order : orders) {

                        String deliveryMethod =
                                order.getDeliveryMethod();

                        if (deliveryMethod == null ||
                            deliveryMethod.trim().isEmpty()) {

                            deliveryMethod = "Not Available";

                        }

                        boolean isPickup =
                                "Pickup".equalsIgnoreCase(
                                        deliveryMethod
                                );

            %>


            <tr>

                <!-- ORDER ID -->

                <td>
                    <%= order.getOrderId() %>
                </td>


                <!-- CUSTOMER -->

                <td>
                    <%= order.getCustomerName() %>
                </td>


                <!-- EMAIL -->

                <td>
                    <%= order.getEmail() %>
                </td>


                <!-- PHONE -->

                <td>
                    <%= order.getPhone() %>
                </td>


                <!-- TOTAL -->

                <td>
                    ৳ <%= order.getTotalAmount() %>
                </td>


                <!-- ORDER STATUS -->

                <td>

                    <form
                        action="<%=request.getContextPath()%>/AdminOrderServlet"
                        method="get"
                    >

                        <input
                            type="hidden"
                            name="action"
                            value="status"
                        >

                        <input
                            type="hidden"
                            name="id"
                            value="<%=order.getOrderId()%>"
                        >


                        <select
                            name="value"
                            onchange="this.form.submit()"
                        >

                            <option
                                value="Pending"
                                <%= "Pending".equalsIgnoreCase(
                                    order.getOrderStatus())
                                    ? "selected" : "" %>
                            >
                                Pending
                            </option>


                            <option
                                value="Preparing"
                                <%= "Preparing".equalsIgnoreCase(
                                    order.getOrderStatus())
                                    ? "selected" : "" %>
                            >
                                Preparing
                            </option>


                            <option
                                value="Delivered"
                                <%= "Delivered".equalsIgnoreCase(
                                    order.getOrderStatus())
                                    ? "selected" : "" %>
                            >
                                Delivered
                            </option>


                            <option
                                value="Cancelled"
                                <%= "Cancelled".equalsIgnoreCase(
                                    order.getOrderStatus())
                                    ? "selected" : "" %>
                            >
                                Cancelled
                            </option>

                        </select>

                    </form>

                </td>


                <!-- PAYMENT -->

                <td>
                    <%= order.getPaymentStatus() %>
                </td>


                <!-- ADDRESS -->

                <td>
                    <%= order.getDeliveryAddress() == null
                            ? "N/A"
                            : order.getDeliveryAddress() %>
                </td>


                <!-- DELIVERY METHOD -->
                <!-- ADMIN CANNOT CHANGE THIS -->

                <td>

                    <span class="method
                        <%=isPickup ? "pickup" : "delivery"%>">

                        <%=deliveryMethod%>

                    </span>

                </td>


                <!-- PICKUP TIME -->

                <td>

                    <%
                        if (isPickup &&
                            order.getPickupTime() != null &&
                            !order.getPickupTime()
                                   .trim()
                                   .isEmpty()) {
                    %>

                        <%=order.getPickupTime()%>

                    <%
                        } else if (isPickup) {
                    %>

                        Not Set

                    <%
                        } else {
                    %>

                        N/A

                    <%
                        }
                    %>

                </td>


                <!-- ESTIMATED DELIVERY TIME -->
                <!-- ADMIN CAN UPDATE THIS -->

                <td>

                    <%
                        if (!isPickup) {
                    %>

                        <form
                            action="<%=request.getContextPath()%>/AdminOrderTimeServlet"
                            method="post"
                            style="display:flex;
                                   flex-direction:column;
                                   gap:6px;
                                   align-items:center;"
                        >

                            <input
                                type="hidden"
                                name="orderId"
                                value="<%=order.getOrderId()%>"
                            >

                            <input
                                type="time"
                                name="estimatedDeliveryTime"
                                value="<%=order.getEstimatedDeliveryTime() == null
                                        ? ""
                                        : order.getEstimatedDeliveryTime()%>"
                                required
                            >

                            <button
                                type="submit"
                                class="update-btn"
                            >
                                Update Time
                            </button>

                        </form>

                    <%
                        } else {
                    %>

                        N/A

                    <%
                        }
                    %>

                </td>


                <!-- DATE -->

                <td>
                    <%= order.getOrderDate() %>
                </td>


                <!-- DELETE -->

                <td>

                    <a
                        class="delete"
                        href="<%=request.getContextPath()%>/AdminOrderServlet?action=delete&id=<%=order.getOrderId()%>"
                        onclick="return confirm('Delete this order?');"
                    >
                        Delete
                    </a>

                </td>

            </tr>


            <%

                    }

                } else {

            %>


            <tr>

                <td
                    colspan="13"
                    class="empty"
                >

                    No orders found.

                </td>

            </tr>


            <%

                }

            %>


        </table>

    </div>

</div>


</body>

</html>