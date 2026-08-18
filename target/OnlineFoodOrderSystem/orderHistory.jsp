<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.foodexpress.model.User"%>
<%@page import="com.foodexpress.model.Order"%>

<%
    // =====================================================
    // LOGIN CHECK
    // =====================================================

    User user =
            (User) session.getAttribute("user");

    if (user == null) {

        response.sendRedirect("login.jsp");

        return;
    }

    // =====================================================
    // GET ORDERS FROM SERVLET
    // =====================================================

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

            margin: 0;

            font-family: 'Poppins', sans-serif;

            background: #f5f7fb;

        }


        /* ================= NAVBAR ================= */

        .navbar {

            display: flex;

            justify-content: space-between;

            align-items: center;

            padding: 18px 45px;

            background: #2196F3;

            box-shadow:
                0 3px 12px rgba(0,0,0,0.12);

        }

        .logo {

            color: white;

            font-size: 25px;

            font-weight: 700;

        }

        .nav-links {

            display: flex;

            list-style: none;

            gap: 25px;

            margin: 0;

            padding: 0;

        }

        .nav-links a {

            color: white;

            text-decoration: none;

            font-weight: 500;

        }

        .nav-links a:hover {

            opacity: 0.85;

        }


        /* ================= HERO ================= */

        .orders-hero {

            padding: 55px 8%;

            background:
                linear-gradient(
                    135deg,
                    #e3f2fd,
                    #ffffff
                );

            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 40px;

        }

        .hero-text {

            max-width: 650px;

        }

        .hero-text .tagline {

            color: #2196F3;

            font-weight: 600;

            font-size: 15px;

        }

        .hero-text h1 {

            font-size: 42px;

            margin: 12px 0;

            color: #172033;

        }

        .hero-text p {

            color: #64748b;

            line-height: 1.7;

        }

        .hero-image img {

            width: 330px;

            height: 220px;

            object-fit: cover;

            border-radius: 18px;

            box-shadow:
                0 10px 30px rgba(0,0,0,0.15);

        }


        /* ================= ORDERS SECTION ================= */

        .orders-section {

            padding: 55px 8%;

        }

        .section-title {

            margin-bottom: 30px;

        }

        .section-title h2 {

            font-size: 30px;

            margin-bottom: 5px;

            color: #172033;

        }

        .section-title p {

            color: #64748b;

        }


        /* ================= ORDER CARD ================= */

        .order-card {

            background: white;

            border-radius: 16px;

            margin-bottom: 25px;

            padding: 28px;

            box-shadow:
                0 5px 20px rgba(0,0,0,0.07);

            transition:
                transform 0.2s,
                box-shadow 0.2s;

        }

        .order-card:hover {

            transform: translateY(-3px);

            box-shadow:
                0 10px 28px rgba(0,0,0,0.10);

        }


        .order-top {

            display: flex;

            justify-content: space-between;

            align-items: center;

            border-bottom: 1px solid #edf0f5;

            padding-bottom: 18px;

            margin-bottom: 20px;

        }

        .order-id {

            font-size: 20px;

            font-weight: 700;

            color: #172033;

        }

        .order-date {

            color: #64748b;

            font-size: 14px;

        }


        /* ================= ORDER DETAILS ================= */

        .order-details {

            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(180px, 1fr));

            gap: 20px;

        }

        .detail-box {

            background: #f8fafc;

            padding: 17px;

            border-radius: 10px;

        }

        .detail-box span {

            display: block;

            color: #64748b;

            font-size: 13px;

            margin-bottom: 6px;

        }

        .detail-box strong {

            color: #172033;

            font-size: 16px;

        }

        .amount {

            color: #2196F3 !important;

            font-size: 20px !important;

        }


        /* ================= STATUS ================= */

        .status {

            display: inline-block;

            padding: 6px 13px;

            border-radius: 20px;

            font-size: 13px;

            font-weight: 600;

        }

        .pending {

            background: #fff3cd;

            color: #856404;

        }

        .preparing {

            background: #dbeafe;

            color: #1d4ed8;

        }

        .delivered {

            background: #dcfce7;

            color: #166534;

        }

        .cancelled {

            background: #fee2e2;

            color: #991b1b;

        }


        /* ================= PAYMENT ================= */

        .paid {

            color: #15803d;

        }

        .unpaid {

            color: #b45309;

        }


        /* ================= TIME DETAILS ================= */

        .time-box {

            background: #eff6ff;

            border: 1px solid #dbeafe;

        }

        .time-label {

            color: #1976d2 !important;

            font-weight: 600;

        }

        .time-value {

            color: #1565c0 !important;

            font-size: 17px !important;

        }


        /* ================= EMPTY ORDERS ================= */

        .empty-orders {

            background: white;

            padding: 60px 30px;

            border-radius: 16px;

            text-align: center;

            box-shadow:
                0 5px 20px rgba(0,0,0,0.07);

        }

        .empty-orders h2 {

            color: #172033;

            margin-bottom: 10px;

        }

        .empty-orders p {

            color: #64748b;

            margin-bottom: 25px;

        }

        .primary-btn {

            display: inline-block;

            padding: 12px 25px;

            background: #2196F3;

            color: white;

            text-decoration: none;

            border-radius: 7px;

            font-weight: 500;

        }

        .primary-btn:hover {

            background: #1976D2;

        }


        /* ================= FOOTER ================= */

        footer {

            background: #172033;

            color: white;

            padding: 45px 8% 20px;

        }

        .footer-container {

            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));

            gap: 35px;

        }

        .footer-box h3 {

            margin-bottom: 15px;

        }

        .footer-box p {

            color: #cbd5e1;

            line-height: 1.7;

        }

        .footer-box a {

            display: block;

            color: #cbd5e1;

            text-decoration: none;

            margin: 8px 0;

        }

        .footer-box a:hover {

            color: white;

        }

        .copyright {

            text-align: center;

            color: #94a3b8;

            margin-top: 25px;

        }


        /* ================= MOBILE ================= */

        @media(max-width: 768px) {

            .navbar {

                padding: 18px 20px;

                flex-direction: column;

                gap: 15px;

            }

            .nav-links {

                flex-wrap: wrap;

                justify-content: center;

                gap: 15px;

            }

            .orders-hero {

                flex-direction: column;

                text-align: center;

                padding: 40px 20px;

            }

            .hero-text h1 {

                font-size: 32px;

            }

            .hero-image img {

                width: 100%;

                max-width: 330px;

            }

            .orders-section {

                padding: 40px 20px;

            }

            .order-top {

                flex-direction: column;

                align-items: flex-start;

                gap: 8px;

            }

        }

    </style>

</head>


<body>


<!-- =====================================================
     NAVBAR
===================================================== -->

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
            <a href="OrderHistoryServlet">
                My Orders
            </a>
        </li>

        <li>
            <a href="profile.jsp">
                Profile
            </a>
        </li>

        <li>
            <a href="LogoutServlet">
                Logout
            </a>
        </li>

    </ul>

</nav>


<!-- =====================================================
     HERO
===================================================== -->

<section class="orders-hero">

    <div class="hero-text">

        <span class="tagline">

            FoodExpress Orders

        </span>

        <h1>

            My Orders

        </h1>

        <p>

            Hello
            <strong><%=user.getFullName()%></strong>!

            Here you can view your previous purchases
            and track the status of your current orders.

        </p>

    </div>


    <div class="hero-image">

        <img
            src="https://images.pexels.com/photos/3184192/pexels-photo-3184192.jpeg"
            alt="Orders">

    </div>

</section>


<!-- =====================================================
     ORDERS
===================================================== -->

<section class="orders-section">

    <div class="section-title">

        <h2>

            Your Order History

        </h2>

        <p>

            All your FoodExpress orders are shown below.

        </p>

    </div>


<%

    if(orderList != null &&
       !orderList.isEmpty()) {

        for(Order order : orderList) {


            // ==========================================
            // ORDER STATUS
            // ==========================================

            String status =
                    order.getOrderStatus();

            if(status == null ||
               status.trim().isEmpty()) {

                status = "Pending";

            }


            String statusClass =
                    status.toLowerCase();


            if(statusClass.equals("preparing")) {

                statusClass = "preparing";

            } else if(statusClass.equals("delivered")) {

                statusClass = "delivered";

            } else if(statusClass.equals("cancelled")) {

                statusClass = "cancelled";

            } else {

                statusClass = "pending";

            }


            // ==========================================
            // PAYMENT STATUS
            // ==========================================

            String paymentStatus =
                    order.getPaymentStatus();

            if(paymentStatus == null ||
               paymentStatus.trim().isEmpty()) {

                paymentStatus = "Pending";

            }


            // ==========================================
            // DELIVERY METHOD
            // ==========================================

            String deliveryMethod =
                    order.getDeliveryMethod();

            if(deliveryMethod == null ||
               deliveryMethod.trim().isEmpty()) {

                deliveryMethod = "Not Available";

            }


            // ==========================================
            // PICKUP TIME
            // ==========================================

            String pickupTime =
                    order.getPickupTime();


            // ==========================================
            // ESTIMATED DELIVERY TIME
            // ==========================================

            String estimatedDeliveryTime =
                    order.getEstimatedDeliveryTime();

%>


<!-- =====================================================
     ORDER CARD
===================================================== -->

<div class="order-card">


    <!-- ================= ORDER TOP ================= -->

    <div class="order-top">

        <div>

            <div class="order-id">

                Order #<%=order.getOrderId()%>

            </div>

        </div>


        <div class="order-date">

            <%=order.getOrderDate()%>

        </div>

    </div>


    <!-- ================= ORDER DETAILS ================= -->

    <div class="order-details">


        <!-- TOTAL -->

        <div class="detail-box">

            <span>

                Total Amount

            </span>

            <strong class="amount">

                ৳<%=String.format(
                    "%.2f",
                    order.getTotalAmount()
                )%>

            </strong>

        </div>


        <!-- ORDER STATUS -->

        <div class="detail-box">

            <span>

                Order Status

            </span>

            <strong>

                <span class="status <%=statusClass%>">

                    <%=status%>

                </span>

            </strong>

        </div>


        <!-- PAYMENT -->

        <div class="detail-box">

            <span>

                Payment Status

            </span>

            <strong class="<%=paymentStatus.equalsIgnoreCase("Paid")
                    ? "paid"
                    : "unpaid"%>">

                <%=paymentStatus%>

            </strong>

        </div>


        <!-- DELIVERY ADDRESS -->

        <div class="detail-box">

            <span>

                Delivery Address

            </span>

            <strong>

                <%=order.getDeliveryAddress() == null ||
                   order.getDeliveryAddress().trim().isEmpty()
                        ? "Not Available"
                        : order.getDeliveryAddress()%>

            </strong>

        </div>


        <!-- DELIVERY METHOD -->

        <div class="detail-box">

            <span>

                Delivery Method

            </span>

            <strong>

                <%=deliveryMethod%>

            </strong>

        </div>


        <!-- PICKUP TIME -->

        <%
            if(pickupTime != null &&
               !pickupTime.trim().isEmpty()) {
        %>

        <div class="detail-box time-box">

            <span class="time-label">

                Pickup Time

            </span>

            <strong class="time-value">

                <%=pickupTime%>

            </strong>

        </div>

        <%
            }
        %>


        <!-- ESTIMATED DELIVERY TIME -->

        <%
            if(estimatedDeliveryTime != null &&
               !estimatedDeliveryTime.trim().isEmpty()) {
        %>

        <div class="detail-box time-box">

            <span class="time-label">

                Estimated Delivery Time

            </span>

            <strong class="time-value">

                <%=estimatedDeliveryTime%>

            </strong>

        </div>

        <%
            }
        %>


    </div>

</div>


<%

        }

    } else {

%>


<!-- =====================================================
     EMPTY ORDERS
===================================================== -->

<div class="empty-orders">

    <h2>

        No Orders Yet

    </h2>

    <p>

        You haven't placed any orders yet.
        Explore our menu and order your favorite food!

    </p>

    <a href="MenuServlet"
       class="primary-btn">

        Explore Menu

    </a>

</div>


<%

    }

%>


</section>


<!-- =====================================================
     FOOTER
===================================================== -->

<footer>

    <div class="footer-container">


        <!-- FOOD EXPRESS -->

        <div class="footer-box">

            <h3>

                FoodExpress

            </h3>

            <p>

                Delicious food, fast delivery and
                a premium online food ordering experience.

            </p>

        </div>


        <!-- QUICK LINKS -->

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

            <a href="profile.jsp">
                Profile
            </a>

        </div>


        <!-- CONTACT -->

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