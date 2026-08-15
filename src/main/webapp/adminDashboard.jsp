<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User admin = (User) session.getAttribute("admin");

    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | FoodExpress</title>

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

            display: flex;

            justify-content: space-between;

            align-items: center;

            padding: 18px 50px;

            background: #2196F3;

            box-shadow:
                0 3px 15px rgba(0,0,0,0.12);

        }


        .logo {

            color: white;

            font-size: 25px;

            font-weight: 700;

            letter-spacing: 0.3px;

        }


        .nav-links {

            list-style: none;

            display: flex;

            align-items: center;

            gap: 28px;

            margin: 0;

            padding: 0;

        }


        .nav-links a {

            color: white;

            text-decoration: none;

            font-size: 14px;

            font-weight: 500;

            transition: 0.2s;

        }


        .nav-links a:hover {

            opacity: 0.8;

        }


        .logout-btn {

            padding: 9px 18px;

            border: 1px solid rgba(255,255,255,0.5);

            border-radius: 7px;

        }


        .logout-btn:hover {

            background: rgba(255,255,255,0.12);

            opacity: 1 !important;

        }


        /* ================= HERO ================= */

        .admin-hero {

            margin: 35px 50px 30px;

            padding: 45px;

            border-radius: 20px;

            background:
                linear-gradient(
                    135deg,
                    #2196F3,
                    #1976D2
                );

            color: white;

            display: flex;

            justify-content: space-between;

            align-items: center;

            overflow: hidden;

            box-shadow:
                0 10px 30px rgba(33,150,243,0.20);

        }


        .hero-left {

            max-width: 650px;

        }


        .hero-tag {

            display: inline-block;

            background: rgba(255,255,255,0.15);

            padding: 7px 15px;

            border-radius: 20px;

            font-size: 13px;

            margin-bottom: 15px;

        }


        .admin-hero h1 {

            font-size: 38px;

            margin: 0 0 12px;

        }


        .admin-hero p {

            margin: 0;

            color: #e0f2fe;

            line-height: 1.7;

            font-size: 15px;

        }


        .hero-icon {

            font-size: 100px;

            opacity: 0.18;

            margin-right: 30px;

        }


        /* ================= DASHBOARD ================= */

        .dashboard {

            padding: 10px 50px 50px;

        }


        .section-heading {

            margin-bottom: 25px;

        }


        .section-heading h2 {

            margin: 0 0 6px;

            font-size: 25px;

            color: #0f172a;

        }


        .section-heading p {

            margin: 0;

            color: #64748b;

            font-size: 14px;

        }


        /* ================= ADMIN GRID ================= */

        .admin-grid {

            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(250px, 1fr));

            gap: 25px;

        }


        /* ================= CARD ================= */

        .admin-card {

            background: white;

            padding: 30px;

            border-radius: 16px;

            border: 1px solid #edf2f7;

            box-shadow:
                0 5px 20px rgba(15,23,42,0.06);

            transition:
                transform 0.25s,
                box-shadow 0.25s;

            position: relative;

            overflow: hidden;

        }


        .admin-card::before {

            content: "";

            position: absolute;

            top: 0;

            left: 0;

            width: 100%;

            height: 4px;

            background: #2196F3;

        }


        .admin-card:hover {

            transform: translateY(-6px);

            box-shadow:
                0 12px 30px rgba(15,23,42,0.12);

        }


        .card-icon {

            width: 55px;

            height: 55px;

            border-radius: 13px;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 26px;

            margin-bottom: 20px;

        }


        .blue-icon {

            background: #e8f3ff;

        }


        .orange-icon {

            background: #fff4df;

        }


        .green-icon {

            background: #eaf9ef;

        }


        .purple-icon {

            background: #f0eaff;

        }


        .red-icon {

            background: #ffeded;

        }


        .admin-card h2 {

            margin: 0 0 10px;

            color: #0f172a;

            font-size: 20px;

        }


        .admin-card p {

            color: #64748b;

            line-height: 1.6;

            min-height: 48px;

            font-size: 14px;

            margin-bottom: 20px;

        }


        /* ================= BUTTON ================= */

        .admin-btn {

            display: inline-block;

            padding: 11px 20px;

            border-radius: 7px;

            color: white;

            text-decoration: none;

            font-size: 13px;

            font-weight: 600;

            transition: 0.2s;

        }


        .food-btn {

            background: #2196F3;

        }


        .food-btn:hover {

            background: #1976D2;

        }


        .order-btn {

            background: #f59e0b;

        }


        .order-btn:hover {

            background: #d97706;

        }


        .user-btn {

            background: #16a34a;

        }


        .user-btn:hover {

            background: #15803d;

        }


        .sales-btn {

            background: #7c3aed;

        }


        .sales-btn:hover {

            background: #6d28d9;

        }


        .profile-btn {

            background: #ef4444;

        }


        .profile-btn:hover {

            background: #dc2626;

        }


        /* ================= QUICK INFO ================= */

        .quick-info {

            margin-top: 40px;

            background: white;

            padding: 30px;

            border-radius: 16px;

            border: 1px solid #edf2f7;

            box-shadow:
                0 5px 20px rgba(15,23,42,0.05);

        }


        .quick-info h2 {

            margin-top: 0;

            color: #0f172a;

            font-size: 21px;

        }


        .quick-info p {

            color: #64748b;

            line-height: 1.7;

            font-size: 14px;

        }


        /* ================= FOOTER ================= */

        footer {

            background: #0f172a;

            color: white;

            padding: 40px 50px 20px;

            margin-top: 20px;

        }


        .footer-container {

            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));

            gap: 35px;

        }


        .footer-box h3 {

            margin-top: 0;

            margin-bottom: 15px;

        }


        .footer-box p {

            color: #cbd5e1;

            line-height: 1.7;

            font-size: 14px;

        }


        .footer-box a {

            display: block;

            color: #cbd5e1;

            text-decoration: none;

            margin: 9px 0;

            font-size: 14px;

        }


        .footer-box a:hover {

            color: white;

        }


        footer hr {

            border: 0;

            border-top: 1px solid #334155;

            margin: 30px 0 18px;

        }


        .copyright {

            text-align: center;

            color: #94a3b8;

            font-size: 13px;

            margin: 0;

        }


        /* ================= RESPONSIVE ================= */

        @media(max-width: 750px) {

            .navbar {

                padding: 18px 20px;

            }

            .nav-links {

                gap: 12px;

            }

            .admin-hero {

                margin: 25px 20px;

                padding: 30px;

            }

            .admin-hero h1 {

                font-size: 28px;

            }

            .hero-icon {

                display: none;

            }

            .dashboard {

                padding: 10px 20px 40px;

            }

            footer {

                padding: 35px 20px 20px;

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

            <a href="SalesReportServlet">

                Sales Report

            </a>

        </li>


        <li>

            <a href="LogoutServlet"
               class="logout-btn">

                Logout

            </a>

        </li>


    </ul>

</nav>


<!-- ================= HERO ================= -->

<section class="admin-hero">


    <div class="hero-left">


        <span class="hero-tag">

            FoodExpress Administration

        </span>


        <h1>

            Welcome back,
            <%=admin.getFullName()%>

        </h1>


        <p>

            Manage your food menu, orders, customers and
            business performance from one place.

        </p>


    </div>


    <div class="hero-icon">

        ♛

    </div>


</section>


<!-- ================= DASHBOARD ================= -->

<section class="dashboard">


    <div class="section-heading">

        <h2>

            Admin Control Panel

        </h2>

        <p>

            Choose an option below to manage FoodExpress.

        </p>

    </div>


    <!-- ================= CARDS ================= -->

    <div class="admin-grid">


        <!-- MANAGE FOOD -->

        <div class="admin-card">


            <div class="card-icon blue-icon">

                🍔

            </div>


            <h2>

                Manage Food

            </h2>


            <p>

                Add new food items, view existing foods
                and manage your restaurant menu.

            </p>


            <a href="AdminFoodServlet"
               class="admin-btn food-btn">

                Manage Food →

            </a>


        </div>


        <!-- MANAGE ORDERS -->

        <div class="admin-card">


            <div class="card-icon orange-icon">

                📦

            </div>


            <h2>

                Manage Orders

            </h2>


            <p>

                View customer orders and update their
                order status from one place.

            </p>


            <a href="ManageOrderServlet"
               class="admin-btn order-btn">

                Manage Orders →

            </a>


        </div>


        <!-- VIEW USERS -->

        <div class="admin-card">


            <div class="card-icon green-icon">

                👥

            </div>


            <h2>

                View Users

            </h2>


            <p>

                View registered customers and check
                their account information.

            </p>


            <a href="ViewUsersServlet"
               class="admin-btn user-btn">

                View Users →

            </a>


        </div>


        <!-- SALES REPORT -->

        <div class="admin-card">


            <div class="card-icon purple-icon">

                📊

            </div>


            <h2>

                Sales Report

            </h2>


            <p>

                Monitor total sales, revenue, orders
                and overall business performance.

            </p>


            <a href="SalesReportServlet"
               class="admin-btn sales-btn">

                View Report →

            </a>


        </div>


        <!-- ADMIN PROFILE -->

        <div class="admin-card">


            <div class="card-icon red-icon">

                ⚙

            </div>


            <h2>

                Admin Profile

            </h2>


            <p>

                View and manage your administrator
                account information.

            </p>


            <a href="adminProfile.jsp"
               class="admin-btn profile-btn">

                My Profile →

            </a>


        </div>


    </div>


    <!-- ================= QUICK INFORMATION ================= -->

    <div class="quick-info">


        <h2>

            FoodExpress Administration

        </h2>


        <p>

            From this dashboard, you can control the major
            operations of your online food ordering system.
            Manage the restaurant menu, monitor customer
            orders, view registered users and analyze sales
            performance.

        </p>


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

                A complete administration panel for managing
                food, orders, customers and sales.

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


            <a href="SalesReportServlet">

                Sales Report

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