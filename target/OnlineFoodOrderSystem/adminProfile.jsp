<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    // Get logged-in ADMIN
    User admin = (User) session.getAttribute("admin");

    // Admin login check
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

    <title>Admin Profile | FoodExpress</title>

    <link rel="stylesheet"
          href="css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

    <style>

        body {
            background: #f5f9fc;
        }

        .profile-section {
            min-height: 75vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 20px;
        }

        .profile-card {
            width: 520px;
            background: white;
            border-radius: 22px;
            padding: 40px;
            box-shadow: 0 10px 35px rgba(0,0,0,0.10);
        }

        .profile-title {
            text-align: center;
            color: #1677b8;
            font-size: 30px;
            margin-bottom: 30px;
        }

        .profile-icon {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background: #49a7e8;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto 25px;
            font-size: 38px;
            font-weight: 600;
        }

        .profile-item {
            padding: 15px 0;
            border-bottom: 1px solid #eeeeee;
        }

        .profile-item:last-child {
            border-bottom: none;
        }

        .profile-label {
            display: block;
            color: #777;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .profile-value {
            color: #222;
            font-size: 17px;
            font-weight: 500;
        }

        .admin-badge {
            display: inline-block;
            background: #e8f5ff;
            color: #1677b8;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .profile-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }

        .profile-btn {
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 10px;
            font-weight: 600;
            transition: 0.2s;
        }

        .back-btn {
            background: #49a7e8;
            color: white;
        }

        .back-btn:hover {
            background: #278ed2;
        }

        .logout-btn {
            background: #f1f1f1;
            color: #333;
        }

        .logout-btn:hover {
            background: #ddd;
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
            <a href="adminDashboard.jsp">
                Dashboard
            </a>
        </li>

        <li>
            <a href="AdminFoodServlet">
                Manage Food
            </a>
        </li>

        <li>
            <a href="ManageOrderServlet">
                Manage Orders
            </a>
        </li>

        <li>
            <a href="ViewUsersServlet">
                View Users
            </a>
        </li>

        <li>
            <a href="adminProfile.jsp"
               class="active">
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


<!-- ================= PROFILE ================= -->

<section class="profile-section">

    <div class="profile-card">


        <div class="profile-icon">
            👤
        </div>


        <h2 class="profile-title">
            Admin Profile
        </h2>


        <!-- NAME -->

        <div class="profile-item">

            <span class="profile-label">
                Full Name
            </span>

            <span class="profile-value">
                <%=admin.getFullName()%>
            </span>

        </div>


        <!-- EMAIL -->

        <div class="profile-item">

            <span class="profile-label">
                Email
            </span>

            <span class="profile-value">
                <%=admin.getEmail()%>
            </span>

        </div>


        <!-- PHONE -->

        <div class="profile-item">

            <span class="profile-label">
                Phone
            </span>

            <span class="profile-value">
                <%=admin.getPhone()%>
            </span>

        </div>


        <!-- ADDRESS -->

        <div class="profile-item">

            <span class="profile-label">
                Address
            </span>

            <span class="profile-value">
                <%=admin.getAddress()%>
            </span>

        </div>


        <!-- ROLE -->

        <div class="profile-item">

            <span class="profile-label">
                Account Type
            </span>

            <span class="admin-badge">
                Administrator
            </span>

        </div>


        <!-- BUTTONS -->

        <div class="profile-buttons">

            <a href="adminDashboard.jsp"
               class="profile-btn back-btn">

                Back to Dashboard

            </a>


            <a href="LogoutServlet"
               class="profile-btn logout-btn">

                Logout

            </a>

        </div>


    </div>

</section>


<!-- ================= FOOTER ================= -->

<footer>

    <div class="footer-container">

        <div class="footer-box">

            <h3>
                FoodExpress
            </h3>

            <p>
                Fresh food, fast delivery and
                premium dining experience.
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