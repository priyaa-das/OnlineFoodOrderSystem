<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User admin =
            (User) session.getAttribute("admin");

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

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7ff;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 40px;

            background: #2196F3;

            box-shadow:
                0 2px 10px rgba(0,0,0,0.12);
        }

        .logo {
            color: white;
            font-size: 25px;
            font-weight: bold;
        }

        .nav-links {
            list-style: none;
            display: flex;
            align-items: center;
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

        .logout-btn {
            background: #2196F3;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .logout-btn:hover {
            background: #2196F3;
            opacity: 1 !important;
        }


        /* ================= DASHBOARD ================= */

        .dashboard {
            padding: 45px;
        }

        .dashboard h1 {
            margin-bottom: 10px;
            color: #1e293b;
        }

        .welcome {
            margin-bottom: 35px;
            color: #64748b;
            font-size: 16px;
        }


        /* ================= ADMIN CARDS ================= */

        .admin-grid {

            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(230px, 1fr));

            gap: 25px;

        }


        .admin-card {

            background: white;

            padding: 30px;

            border-radius: 12px;

            box-shadow:
                0 4px 15px rgba(0,0,0,0.08);

            text-align: center;

            transition:
                transform 0.2s,
                box-shadow 0.2s;

        }


        .admin-card:hover {

            transform: translateY(-4px);

            box-shadow:
                0 8px 22px rgba(0,0,0,0.12);

        }


        .admin-card h2 {

            margin-bottom: 15px;

            color: #1e293b;

        }


        .admin-card p {

            color: #64748b;

            min-height: 40px;

            line-height: 1.5;

        }


        /* ================= BUTTON ================= */

        .admin-btn {

            display: inline-block;

            margin-top: 15px;

            padding: 11px 22px;

            background: #4f46e5;

            color: white;

            text-decoration: none;

            border-radius: 6px;

            font-weight: 500;

            transition:
                background 0.2s;

        }


        .admin-btn:hover {

            background: #4338ca;

        }


        /* Food button */

        .food-btn {

            background: #2196F3;

        }

        .food-btn:hover {

            background: #2196F3;

        }


        /* Order button */

        .order-btn {

            background: #2196F3;

        }

        .order-btn:hover {

            background: #2196F3;

        }


        /* User button */

        .user-btn {

            background: #2196F3;

        }

        .user-btn:hover {

            background: #2196F3;

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

            <a href="LogoutServlet"
               class="logout-btn">

                Logout

            </a>

        </li>

    </ul>

</nav>


<!-- ================= DASHBOARD ================= -->

<section class="dashboard">

    <h1>

        Admin Dashboard

    </h1>


    <p class="welcome">

        Welcome,

        <strong>

            <%=admin.getFullName()%>

        </strong>

    </p>


    <!-- ================= ADMIN GRID ================= -->

    <div class="admin-grid">


        <!-- ================= MANAGE FOOD ================= -->

        <div class="admin-card">

            <h2>

                Manage Food

            </h2>

            <p>

                Add,view and manage food items.

            </p>

            <a href="AdminFoodServlet"
               class="admin-btn food-btn">

                Manage Food

            </a>

        </div>


        <!-- ================= MANAGE ORDERS ================= -->

        <div class="admin-card">

            <h2>

                Manage Order

            </h2>

            <p>

                View orders and update order status.

            </p>

            <a href="ManageOrderServlet"
               class="admin-btn order-btn">

                Manage Orders

            </a>

        </div>


        <!-- ================= VIEW USERS ================= -->

        <div class="admin-card">

            <h2>

                View Users

            </h2>

            <p>

                View registered customers
                and their information.

            </p>

            <a href="ViewUsersServlet"
               class="admin-btn user-btn">

                View Users

            </a>

        </div>


    </div>

</section>


</body>

</html>