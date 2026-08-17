<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Dashboard | FoodExpress</title>

    <link rel="stylesheet"
          href="css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
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
            padding: 18px 55px;
            background: #2196F3;
            box-shadow: 0 3px 15px rgba(0,0,0,0.12);
        }

        .logo {
            color: white;
            font-size: 25px;
            font-weight: 700;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 25px;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        .nav-links a:hover {
            opacity: 0.8;
        }

        .logout-btn {
            background: rgba(255,255,255,0.15);
            padding: 9px 17px;
            border-radius: 7px;
        }

        /* ================= HERO ================= */

        .hero {
            margin: 35px 55px;
            min-height: 300px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 45px;

            border-radius: 22px;

            background: linear-gradient(
                135deg,
                #2196F3,
                #64B5F6
            );

            color: white;

            overflow: hidden;

            box-shadow:
                0 10px 30px rgba(33,150,243,0.25);
        }

        .hero-content {
            max-width: 600px;
        }

        .hero-content h1 {
            font-size: 38px;
            margin: 10px 0;
        }

        .hero-content p {
            font-size: 16px;
            line-height: 1.7;
            opacity: 0.95;
        }

        .hero-image img {
            width: 330px;
            height: 230px;
            object-fit: cover;
            border-radius: 18px;
        }

        /* ================= BUTTON ================= */

        .hero-btn {
            display: inline-block;
            margin-top: 18px;
            padding: 12px 25px;

            background: white;
            color: #1976D2;

            text-decoration: none;

            border-radius: 8px;

            font-weight: 600;

            transition: 0.3s;
        }

        .hero-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.15);
        }

        /* ================= SECTION ================= */

        .dashboard {
            padding: 10px 55px 50px;
        }

        .section-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .section-title h2 {
            font-size: 28px;
            margin-bottom: 5px;
        }

        .section-title p {
            color: #64748b;
        }

        /* ================= CARDS ================= */

        .card-grid {
            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(250px, 1fr));

            gap: 25px;
        }

        .dashboard-card {
            background: white;

            padding: 30px;

            border-radius: 15px;

            text-align: center;

            box-shadow:
                0 5px 20px rgba(0,0,0,0.07);

            transition: 0.3s;
        }

        .dashboard-card:hover {
            transform: translateY(-6px);

            box-shadow:
                0 10px 28px rgba(0,0,0,0.12);
        }

        .card-icon {
            font-size: 42px;
            margin-bottom: 10px;
        }

        .dashboard-card h3 {
            margin: 10px 0;
        }

        .dashboard-card p {
            color: #64748b;
            line-height: 1.6;
        }

        .card-btn {
            display: inline-block;

            margin-top: 15px;

            padding: 10px 20px;

            background: #2196F3;
            color: white;

            text-decoration: none;

            border-radius: 7px;

            font-weight: 500;
        }

        .card-btn:hover {
            background: #1976D2;
        }

        /* ================= OFFER CARD ================= */

        .offer-card {
            background:
                linear-gradient(
                    135deg,
                    #ffffff,
                    #eef7ff
                );

            border: 1px solid #dbeafe;

            position: relative;
        }

        .offer-badge {
            display: inline-block;

            background: #2196F3;

            color: white;

            padding: 5px 12px;

            border-radius: 20px;

            font-size: 12px;

            font-weight: 600;

            margin-bottom: 10px;
        }

        /* ================= FOOTER ================= */

        footer {
            margin-top: 30px;
            padding: 35px 55px;
            background: #172033;
            color: white;
            text-align: center;
        }

        footer p {
            color: #cbd5e1;
            margin: 5px;
        }

        @media(max-width: 800px) {

            .navbar {
                padding: 15px 20px;
            }

            .nav-links {
                gap: 10px;
                font-size: 13px;
            }

            .hero {
                margin: 20px;
                padding: 30px;
                flex-direction: column;
                text-align: center;
            }

            .hero-image img {
                width: 100%;
                margin-top: 25px;
            }

            .dashboard {
                padding: 20px;
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
                Home
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
            <a href="LogoutServlet"
               class="logout-btn">
                Logout
            </a>
        </li>

    </ul>

</nav>


<!-- ================= HERO ================= -->

<section class="hero">

    <div class="hero-content">

        <p>
            Welcome back,
            <strong><%=user.getFullName()%></strong>
        </p>

        <h1>
            Delicious Food,
            Just One Click Away!
        </h1>

        <p>
            Explore our delicious menu, order your
            favorite meals and enjoy a premium
            FoodExpress experience.
        </p>

        <a href="MenuServlet"
           class="hero-btn">

            Explore Menu

        </a>

    </div>


    <div class="hero-image">

        <img
            src="https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg"
            alt="Food">

    </div>

</section>


<!-- ================= DASHBOARD ================= -->

<section class="dashboard">

    <div class="section-title">

        <h2>
            What would you like to do?
        </h2>

        <p>
            Manage your FoodExpress experience
            from here.
        </p>

    </div>


    <div class="card-grid">


        <!-- MENU -->

        <div class="dashboard-card">

            <div class="card-icon">
                🍔
            </div>

            <h3>
                Explore Menu
            </h3>

            <p>
                Browse delicious meals and
                choose your favorite food.
            </p>

            <a href="MenuServlet"
               class="card-btn">

                Explore Menu

            </a>

        </div>


        <!-- CART -->

        <div class="dashboard-card">

            <div class="card-icon">
                🛒
            </div>

            <h3>
                My Cart
            </h3>

            <p>
                View your selected food items
                and proceed to checkout.
            </p>

            <a href="CartServlet"
               class="card-btn">

                View Cart

            </a>

        </div>


        <!-- ORDERS -->

        <div class="dashboard-card">

            <div class="card-icon">
                📦
            </div>

            <h3>
                My Orders
            </h3>

            <p>
                Track your previous orders and
                check their current status.
            </p>

            <a href="OrderHistoryServlet"
               class="card-btn">

                View Orders

            </a>

        </div>


        <!-- CLAIM OFFER -->

        <div class="dashboard-card offer-card">

            <span class="offer-badge">
                SPECIAL OFFER
            </span>

            <div class="card-icon">
                🎁
            </div>

            <h3>
                Claim Offers
            </h3>

            <p>
                Get exclusive FoodExpress
                discounts and special rewards.
            </p>

            <a href="offers.jsp"
               class="card-btn">

                Claim Offer

            </a>

        </div>


    </div>

</section>


<!-- ================= FOOTER ================= -->

<footer>

    <h3>
        FoodExpress
    </h3>

    <p>
        Delicious food, fast delivery and
        a premium online ordering experience.
    </p>

    <p>
        © 2026 FoodExpress. All Rights Reserved.
    </p>

</footer>


</body>

</html>