<%-- 
    Document   : manageOrders
    Created on : Aug 14, 2026, 2:53:20 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.foodexpress.model.Order"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User admin =
            (User) session.getAttribute("admin");

    if (admin == null) {
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

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Orders | FoodExpress</title>

    <link rel="stylesheet"
          href="css/style.css">

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f6fa;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 40px;
            background: #222;
        }

        .logo {
            color: white;
            font-size: 25px;
            font-weight: bold;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 25px;
            margin: 0;
            padding: 0;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
        }

        .dashboard {
            padding: 35px;
        }

        .dashboard h1 {
            margin-bottom: 25px;
        }

        .message {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
            background: #e8f5e9;
            color: #2e7d32;
        }

        .error {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
            background: #ffebee;
            color: #c62828;
        }

        .table-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            overflow-x: auto;
            box-shadow:
                0 3px 12px rgba(0,0,0,0.10);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #222;
            color: white;
            padding: 14px;
            text-align: left;
        }

        td {
            padding: 13px;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background: #f9f9f9;
        }

        .status-form {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .update-btn {
            padding: 8px 14px;
            border: none;
            background: #222;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

        .update-btn:hover {
            opacity: 0.85;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 18px;
            background: #555;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .empty {
            text-align: center;
            padding: 30px;
            color: #777;
        }

    </style>

</head>

<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <div class="logo">
        FoodExpress Admin
    </div>

    <ul class="nav-links">

        <li>
            <a href="adminDashboard.jsp">
                Dashboard
            </a>
        </li>

        <li>
            <a href="LogoutServlet">
                Logout
            </a>
        </li>

    </ul>

</nav>


<!-- ================= MAIN ================= -->

<section class="dashboard">

    <h1>
        Manage Orders
    </h1>


    <a href="adminDashboard.jsp"
       class="back-btn">

        ← Back to Dashboard

    </a>


    <!-- ================= SUCCESS ================= -->

    <% if ("updated".equals(success)) { %>

        <div class="message">

            Order status updated successfully.

        </div>

    <% } %>


    <!-- ================= ERROR ================= -->

    <% if (error != null) { %>

        <div class="error">

            Failed to update order.

        </div>

    <% } %>


    <!-- ================= ORDER TABLE ================= -->

    <div class="table-container">

        <% if (orderList == null ||
               orderList.isEmpty()) { %>

            <div class="empty">

                <h3>
                    No Orders Found
                </h3>

                <p>
                    There are currently no customer orders.
                </p>

            </div>

        <% } else { %>


        <table>

            <thead>

                <tr>

                    <th>
                        Order ID
                    </th>

                    <th>
                        User ID
                    </th>

                    <th>
                        Total Amount
                    </th>

                    <th>
                        Order Status
                    </th>

                    <th>
                        Payment Status
                    </th>

                    <th>
                        Delivery Address
                    </th>

                    <th>
                        Order Date
                    </th>

                    <th>
                        Action
                    </th>

                </tr>

            </thead>


            <tbody>

            <%
                for (Order order : orderList) {
            %>

                <tr>

                    <td>
                        #<%=order.getOrderId()%>
                    </td>


                    <td>
                        <%=order.getUserId()%>
                    </td>


                    <td>
                        ৳<%=String.format(
                                "%.2f",
                                order.getTotalAmount()
                        )%>
                    </td>


                    <td>

                        <%=order.getOrderStatus()%>

                    </td>


                    <td>

                        <%=order.getPaymentStatus()%>

                    </td>


                    <td>

                        <%=order.getDeliveryAddress()%>

                    </td>


                    <td>

                        <%=order.getOrderDate()%>

                    </td>


                    <td>

                        <form
                            action="ManageOrderServlet"
                            method="post"
                            class="status-form"
                        >

                            <input
                                type="hidden"
                                name="orderId"
                                value="<%=order.getOrderId()%>"
                            >


                            <select name="orderStatus">

                                <option
                                    value="Pending"
                                    <%= "Pending".equals(
                                            order.getOrderStatus()
                                       ) ? "selected" : "" %>
                                >
                                    Pending
                                </option>


                                <option
                                    value="Preparing"
                                    <%= "Preparing".equals(
                                            order.getOrderStatus()
                                       ) ? "selected" : "" %>
                                >
                                    Preparing
                                </option>


                                <option
                                    value="Delivered"
                                    <%= "Delivered".equals(
                                            order.getOrderStatus()
                                       ) ? "selected" : "" %>
                                >
                                    Delivered
                                </option>


                                <option
                                    value="Cancelled"
                                    <%= "Cancelled".equals(
                                            order.getOrderStatus()
                                       ) ? "selected" : "" %>
                                >
                                    Cancelled
                                </option>

                            </select>


                            <button
                                type="submit"
                                class="update-btn"
                            >
                                Update
                            </button>

                        </form>

                    </td>

                </tr>

            <%
                }
            %>

            </tbody>

        </table>

        <% } %>

    </div>

</section>

</body>

</html>