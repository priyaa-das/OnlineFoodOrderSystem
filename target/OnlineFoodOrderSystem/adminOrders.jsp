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

            %>


            <tr>

                <td>
                    <%= order.getOrderId() %>
                </td>


                <td>
                    <%= order.getCustomerName() %>
                </td>


                <td>
                    <%= order.getEmail() %>
                </td>


                <td>
                    <%= order.getPhone() %>
                </td>


                <td>
                    ৳ <%= order.getTotalAmount() %>
                </td>


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
                                <%= "Pending".equals(order.getOrderStatus())
                                ? "selected" : "" %>
                            >
                                Pending
                            </option>


                            <option
                                value="Preparing"
                                <%= "Preparing".equals(order.getOrderStatus())
                                ? "selected" : "" %>
                            >
                                Preparing
                            </option>


                            <option
                                value="Delivered"
                                <%= "Delivered".equals(order.getOrderStatus())
                                ? "selected" : "" %>
                            >
                                Delivered
                            </option>


                            <option
                                value="Cancelled"
                                <%= "Cancelled".equals(order.getOrderStatus())
                                ? "selected" : "" %>
                            >
                                Cancelled
                            </option>

                        </select>

                    </form>

                </td>


                <td>
                    <%= order.getPaymentStatus() %>
                </td>


                <td>
                    <%= order.getDeliveryAddress() %>
                </td>


                <td>
                    <%= order.getOrderDate() %>
                </td>


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
                    colspan="10"
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