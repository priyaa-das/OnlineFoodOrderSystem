<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.foodexpress.model.User"%>
<%@page import="com.foodexpress.model.Order"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {

        response.sendRedirect("login.jsp");
        return;

    }

    List<Order> orderList =
            (List<Order>) request.getAttribute("orderList");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Orders | FoodExpress</title>

    <link rel="stylesheet"
          href="css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">


    <style>

        body {

            background: #f5f8fc;

        }


        /* ================= PAGE HEADER ================= */

        .order-header {

            padding: 45px 50px;

            background: linear-gradient(
                135deg,
                #2196F3,
                #1976D2
            );

            color: white;

        }


        .order-header h1 {

            margin: 8px 0;

            font-size: 36px;

        }


        .order-header p {

            color: #e0f2fe;

            margin: 0;

        }


        .tagline {

            font-size: 13px;

            font-weight: 600;

            letter-spacing: 1px;

            text-transform: uppercase;

        }


        /* ================= ORDERS ================= */

        .orders-section {

            padding: 45px 50px;

        }


        .orders-section h2 {

            margin-top: 0;

            color: #0f172a;

        }


        .orders-table-wrapper {

            background: white;

            border-radius: 15px;

            overflow-x: auto;

            box-shadow:
                0 5px 20px rgba(15,23,42,0.07);

        }


        .orders-table {

            width: 100%;

            border-collapse: collapse;

            min-width: 850px;

        }


        .orders-table th {

            background: #2196F3;

            color: white;

            padding: 16px;

            text-align: left;

            font-size: 14px;

        }


        .orders-table td {

            padding: 17px 16px;

            border-bottom: 1px solid #edf2f7;

            color: #475569;

            font-size: 14px;

        }


        .orders-table tr:last-child td {

            border-bottom: none;

        }


        .orders-table tr:hover {

            background: #f8fbff;

        }


        /* ================= STATUS ================= */

        .status {

            display: inline-block;

            padding: 6px 12px;

            border-radius: 20px;

            font-size: 12px;

            font-weight: 600;

        }


        .pending {

            background: #fff4df;

            color: #d97706;

        }


        .preparing {

            background: #f1eaff;

            color: #7c3aed;

        }


        .delivered {

            background: #eaf9ef;

            color: #15803d;

        }


        .cancelled {

            background: #ffeded;

            color: #dc2626;

        }


        .payment {

            background: #e8f3ff;

            color: #1976D2;

        }


        /* ================= EMPTY ================= */

        .empty-box {

            background: white;

            text-align: center;

            padding: 60px 30px;

            border-radius: 15px;

            box-shadow:
                0 5px 20px rgba(15,23,42,0.06);

        }


        .empty-box h2 {

            margin-bottom: 10px;

        }


        .empty-box p {

            color: #64748b;

            margin-bottom: 25px;

        }


        .menu-btn {

            display: inline-block;

            padding: 11px 22px;

            background: #2196F3;

            color: white;

            text-decoration: none;

            border-radius: 7px;

            font-weight: 600;

            font-size: 14px;

        }


        .menu-btn:hover {

            background: #1976D2;

        }


        /* ================= RESPONSIVE ================= */

        @media(max-width:700px) {

            .order-header {

                padding: 35px 20px;

            }

            .orders-section {

                padding: 35px 20px;

            }

            .order-header h1 {

                font-size: 28px;

            }

        }

    </style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <div class="logo">

        FoodExpress

    </div>


    <ul class="nav-links">

        <li>

            <a href="userHome.jsp">

                Dashboard

            </a>

        </li>


        <li>

            <a href="MenuServlet">

                Menu

            </a>

        </li>


        <li>

            <a href="CartServlet">

                My Cart

            </a>

        </li>


        <li>

            <a href="OrderHistoryServlet"
               class="active">

                My Orders

            </a>

        </li>


        <li>

            <a href="profile.jsp">

                Profile

            </a>

        </li>


        <li>

            <a href="LogoutServlet"
               class="login-btn">

                Logout

            </a>

        </li>

    </ul>

</nav>


<!-- ================= HEADER ================= -->

<section class="order-header">

    <span class="tagline">

        Order History

    </span>


    <h1>

        My Orders

    </h1>


    <p>

        View your previous orders and track their current status.

    </p>

</section>


<!-- ================= ORDERS ================= -->

<section class="orders-section">

<%

    if (orderList != null && !orderList.isEmpty()) {

%>

    <h2>

        Your Order History

    </h2>


    <div class="orders-table-wrapper">

        <table class="orders-table">


            <tr>

                <th>Order ID</th>

                <th>Total Amount</th>

                <th>Order Status</th>

                <th>Payment</th>

                <th>Delivery Address</th>

                <th>Order Date</th>

            </tr>


<%

        for (Order order : orderList) {

            String status =
                    order.getOrderStatus();

            String statusClass =
                    "pending";

            if ("Preparing".equalsIgnoreCase(status)) {

                statusClass = "preparing";

            } else if ("Delivered".equalsIgnoreCase(status)) {

                statusClass = "delivered";

            } else if ("Cancelled".equalsIgnoreCase(status)) {

                statusClass = "cancelled";

            }

%>

            <tr>


                <td>

                    <strong>

                        #<%=order.getOrderId()%>

                    </strong>

                </td>


                <td>

                    <strong>

                        ৳<%=String.format(
                                "%.2f",
                                order.getTotalAmount()
                        )%>

                    </strong>

                </td>


                <td>

                    <span class="status <%=statusClass%>">

                        <%=order.getOrderStatus()%>

                    </span>

                </td>


                <td>

                    <span class="status payment">

                        <%=order.getPaymentStatus()%>

                    </span>

                </td>


                <td>

                    <%=order.getDeliveryAddress()%>

                </td>


                <td>

                    <%=order.getOrderDate()%>

                </td>


            </tr>

<%

        }

%>

        </table>

    </div>


<%

    } else {

%>


    <div class="empty-box">


        <h2>

            No Orders Yet

        </h2>


        <p>

            You haven't placed any orders yet.
            Explore our menu and order your favorite food.

        </p>


        <a href="MenuServlet"
           class="menu-btn">

            Explore Menu

        </a>


    </div>


<%

    }

%>

</section>


<!-- ================= FOOTER ================= -->

<footer>

    <div class="footer-container">


        <div class="footer-box">

            <h3>

                FoodExpress

            </h3>


            <p>

                Delicious food, fast delivery and a premium
                online food ordering experience.

            </p>

        </div>


        <div class="footer-box">

            <h3>

                Quick Links

            </h3>


            <a href="userHome.jsp">

                Dashboard

            </a>


            <a href="MenuServlet">

                Menu

            </a>


            <a href="CartServlet">

                My Cart

            </a>


            <a href="OrderHistoryServlet">

                My Orders

            </a>

        </div>


        <div class="footer-box">

            <h3>

                Contact Us

            </h3>


            <p>

                Email : info@foodexpress.com

            </p>


            <p>

                Phone : +880 1700-123456

            </p>


            <p>

                Sylhet, Bangladesh

            </p>

        </div>


    </div>


    <hr>


    <p class="copyright">

        © 2026 FoodExpress. All Rights Reserved.

    </p>

</footer>


</body>

</html>