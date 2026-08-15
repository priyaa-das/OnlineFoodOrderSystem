<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User admin = (User) session.getAttribute("admin");

    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    Integer totalOrders = (Integer) request.getAttribute("totalOrders");
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");

    Integer todayOrders = (Integer) request.getAttribute("todayOrders");
    Double todaySales = (Double) request.getAttribute("todaySales");

    Integer pendingOrders = (Integer) request.getAttribute("pendingOrders");
    Integer preparingOrders = (Integer) request.getAttribute("preparingOrders");
    Integer deliveredOrders = (Integer) request.getAttribute("deliveredOrders");
    Integer cancelledOrders = (Integer) request.getAttribute("cancelledOrders");

    if (totalOrders == null) totalOrders = 0;
    if (totalRevenue == null) totalRevenue = 0.0;

    if (todayOrders == null) todayOrders = 0;
    if (todaySales == null) todaySales = 0.0;

    if (pendingOrders == null) pendingOrders = 0;
    if (preparingOrders == null) preparingOrders = 0;
    if (deliveredOrders == null) deliveredOrders = 0;
    if (cancelledOrders == null) cancelledOrders = 0;
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Sales Report | FoodExpress Admin</title>

    <link rel="stylesheet"
          href="css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>

        * {
            box-sizing: border-box;
        }

        body {

            margin: 0;

            font-family: 'Poppins', sans-serif;

            background: #f5f8fc;

            color: #1e293b;

        }


        /* ================= NAVBAR ================= */

        .navbar {

            background: #2196F3;

            padding: 18px 45px;

            display: flex;

            justify-content: space-between;

            align-items: center;

            box-shadow: 0 3px 15px rgba(0,0,0,0.12);

        }

        .logo {

            color: white;

            font-size: 25px;

            font-weight: 700;

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

            font-size: 15px;

            font-weight: 500;

        }

        .nav-links a:hover {

            opacity: 0.85;

        }


        /* ================= PAGE HEADER ================= */

        .report-header {

            padding: 45px 50px 25px;

        }

        .report-header span {

            color: #2196F3;

            font-size: 14px;

            font-weight: 600;

            text-transform: uppercase;

            letter-spacing: 1px;

        }

        .report-header h1 {

            margin: 8px 0;

            font-size: 34px;

            color: #0f172a;

        }

        .report-header p {

            margin: 0;

            color: #64748b;

        }


        /* ================= MAIN CONTAINER ================= */

        .report-container {

            padding: 15px 50px 50px;

        }


        /* ================= SUMMARY CARDS ================= */

        .summary-grid {

            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(230px, 1fr));

            gap: 22px;

            margin-bottom: 35px;

        }

        .summary-card {

            background: white;

            border-radius: 15px;

            padding: 25px;

            box-shadow:
                0 5px 20px rgba(15,23,42,0.07);

            border: 1px solid #edf2f7;

            transition: 0.25s;

        }

        .summary-card:hover {

            transform: translateY(-5px);

            box-shadow:
                0 10px 28px rgba(15,23,42,0.12);

        }

        .card-top {

            display: flex;

            justify-content: space-between;

            align-items: center;

        }

        .card-title {

            color: #64748b;

            font-size: 14px;

            font-weight: 500;

        }

        .card-icon {

            width: 45px;

            height: 45px;

            border-radius: 12px;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 21px;

        }

        .card-value {

            font-size: 28px;

            font-weight: 700;

            margin-top: 15px;

            color: #0f172a;

        }

        .card-description {

            color: #94a3b8;

            font-size: 12px;

            margin-top: 5px;

        }


        /* Card backgrounds */

        .blue {

            background: #e8f3ff;

        }

        .green {

            background: #e9f9ef;

        }

        .orange {

            background: #fff4df;

        }

        .purple {

            background: #f1eaff;

        }


        /* ================= SECTION TITLE ================= */

        .section-title {

            margin: 10px 0 20px;

            font-size: 22px;

            color: #0f172a;

        }


        /* ================= STATUS GRID ================= */

        .status-grid {

            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(210px, 1fr));

            gap: 20px;

            margin-bottom: 35px;

        }

        .status-card {

            background: white;

            padding: 25px;

            border-radius: 14px;

            box-shadow:
                0 4px 18px rgba(0,0,0,0.06);

            border-left: 5px solid #2196F3;

        }

        .status-card h3 {

            margin: 0 0 10px;

            font-size: 15px;

            color: #64748b;

        }

        .status-number {

            font-size: 30px;

            font-weight: 700;

        }


        .pending {

            border-left-color: #f59e0b;

        }

        .pending .status-number {

            color: #f59e0b;

        }


        .preparing {

            border-left-color: #8b5cf6;

        }

        .preparing .status-number {

            color: #8b5cf6;

        }


        .delivered {

            border-left-color: #16a34a;

        }

        .delivered .status-number {

            color: #16a34a;

        }


        .cancelled {

            border-left-color: #ef4444;

        }

        .cancelled .status-number {

            color: #ef4444;

        }


        /* ================= REPORT BOX ================= */

        .report-box {

            background: white;

            padding: 30px;

            border-radius: 16px;

            box-shadow:
                0 5px 20px rgba(15,23,42,0.07);

            margin-bottom: 30px;

        }

        .report-box h2 {

            margin-top: 0;

            font-size: 21px;

        }

        .report-box p {

            color: #64748b;

            line-height: 1.7;

        }


        /* ================= BUTTONS ================= */

        .action-buttons {

            display: flex;

            gap: 15px;

            flex-wrap: wrap;

            margin-top: 25px;

        }

        .report-btn {

            display: inline-block;

            padding: 12px 22px;

            border-radius: 8px;

            text-decoration: none;

            font-size: 14px;

            font-weight: 600;

            transition: 0.2s;

        }

        .dashboard-btn {

            background: #2196F3;

            color: white;

        }

        .dashboard-btn:hover {

            background: #1976D2;

        }

        .order-btn {

            background: #e8f3ff;

            color: #1976D2;

        }

        .order-btn:hover {

            background: #d6eaff;

        }


        /* ================= FOOTER ================= */

        footer {

            background: #0f172a;

            color: white;

            padding: 35px 50px 20px;

            margin-top: 30px;

        }

        .footer-container {

            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));

            gap: 30px;

        }

        .footer-box h3 {

            margin-top: 0;

        }

        .footer-box p {

            color: #cbd5e1;

            line-height: 1.6;

            font-size: 14px;

        }

        .footer-box a {

            display: block;

            color: #cbd5e1;

            text-decoration: none;

            margin: 8px 0;

            font-size: 14px;

        }

        .footer-box a:hover {

            color: white;

        }

        .copyright {

            text-align: center;

            color: #94a3b8;

            margin-bottom: 0;

            font-size: 13px;

        }


        @media(max-width:700px) {

            .navbar {

                padding: 18px 20px;

            }

            .nav-links {

                gap: 10px;

            }

            .report-header,
            .report-container {

                padding-left: 20px;

                padding-right: 20px;

            }

            .report-header h1 {

                font-size: 27px;

            }

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

            <a href="AdminFoodServlet">

                Food

            </a>

        </li>

        <li>

            <a href="ManageOrderServlet">

                Orders

            </a>

        </li>

        <li>

            <a href="LogoutServlet">

                Logout

            </a>

        </li>

    </ul>

</nav>


<!-- ================= HEADER ================= -->

<section class="report-header">

    <span>

        Admin Analytics

    </span>

    <h1>

        Sales Report

    </h1>

    <p>

        Monitor your FoodExpress orders, revenue and sales performance.

    </p>

</section>


<!-- ================= REPORT CONTENT ================= -->

<section class="report-container">


    <!-- ================= SUMMARY ================= -->

    <div class="summary-grid">


        <!-- TOTAL ORDERS -->

        <div class="summary-card">

            <div class="card-top">

                <span class="card-title">

                    Total Orders

                </span>

                <div class="card-icon blue">

                    📦

                </div>

            </div>

            <div class="card-value">

                <%=totalOrders%>

            </div>

            <div class="card-description">

                All orders received

            </div>

        </div>


        <!-- TOTAL REVENUE -->

        <div class="summary-card">

            <div class="card-top">

                <span class="card-title">

                    Total Revenue

                </span>

                <div class="card-icon green">

                    ৳

                </div>

            </div>

            <div class="card-value">

                ৳<%=String.format("%.2f", totalRevenue)%>

            </div>

            <div class="card-description">

                Excluding cancelled orders

            </div>

        </div>


        <!-- TODAY ORDERS -->

        <div class="summary-card">

            <div class="card-top">

                <span class="card-title">

                    Today's Orders

                </span>

                <div class="card-icon orange">

                    🛒

                </div>

            </div>

            <div class="card-value">

                <%=todayOrders%>

            </div>

            <div class="card-description">

                Orders received today

            </div>

        </div>


        <!-- TODAY SALES -->

        <div class="summary-card">

            <div class="card-top">

                <span class="card-title">

                    Today's Sales

                </span>

                <div class="card-icon purple">

                    ৳

                </div>

            </div>

            <div class="card-value">

                ৳<%=String.format("%.2f", todaySales)%>

            </div>

            <div class="card-description">

                Today's revenue

            </div>

        </div>


    </div>


    <!-- ================= ORDER STATUS ================= -->

    <h2 class="section-title">

        Order Status Overview

    </h2>


    <div class="status-grid">


        <div class="status-card pending">

            <h3>

                Pending Orders

            </h3>

            <div class="status-number">

                <%=pendingOrders%>

            </div>

        </div>


        <div class="status-card preparing">

            <h3>

                Preparing Orders

            </h3>

            <div class="status-number">

                <%=preparingOrders%>

            </div>

        </div>


        <div class="status-card delivered">

            <h3>

                Delivered Orders

            </h3>

            <div class="status-number">

                <%=deliveredOrders%>

            </div>

        </div>


        <div class="status-card cancelled">

            <h3>

                Cancelled Orders

            </h3>

            <div class="status-number">

                <%=cancelledOrders%>

            </div>

        </div>


    </div>


    <!-- ================= REPORT INFORMATION ================= -->

    <div class="report-box">

        <h2>

            Sales Performance

        </h2>

        <p>

            This report provides an overview of the FoodExpress
            business performance based on the orders stored in the
            database.

        </p>

        <p>

            Total revenue is calculated from all orders except
            cancelled orders. Today's sales represent the revenue
            generated from today's valid orders.

        </p>


        <div class="action-buttons">

            <a href="adminDashboard.jsp"
               class="report-btn dashboard-btn">

                ← Back to Dashboard

            </a>

            <a href="ManageOrderServlet"
               class="report-btn order-btn">

                View Orders

            </a>

        </div>

    </div>


</section>


<!-- ================= FOOTER ================= -->

<footer>

    <div class="footer-container">


        <div class="footer-box">

            <h3>

                FoodExpress Admin

            </h3>

            <p>

                Manage food, orders, customers and sales
                from one powerful administration panel.

            </p>

        </div>


        <div class="footer-box">

            <h3>

                Quick Links

            </h3>

            <a href="adminDashboard.jsp">

                Dashboard

            </a>

            <a href="AdminFoodServlet">

                Manage Food

            </a>

            <a href="ManageOrderServlet">

                Manage Orders

            </a>

            <a href="ViewUsersServlet">

                View Users

            </a>

        </div>


        <div class="footer-box">

            <h3>

                Contact

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
