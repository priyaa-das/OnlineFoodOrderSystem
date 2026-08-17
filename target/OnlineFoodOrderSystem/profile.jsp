<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    HttpSession userSession = request.getSession(false);

    User user = null;

    if (userSession != null) {
        user = (User) userSession.getAttribute("user");
    }

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

    <title>My Profile | FoodExpress</title>

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

            padding: 40px;

            border-radius: 22px;

            box-shadow:
                0 10px 35px rgba(0,0,0,0.10);
        }


        .profile-icon {
            width: 90px;

            height: 90px;

            margin: 0 auto 20px;

            border-radius: 50%;

            background: #49a7e8;

            color: white;

            display: flex;

            justify-content: center;

            align-items: center;

            font-size: 38px;
        }


        .profile-title {
            text-align: center;

            color: #1677b8;

            font-size: 30px;

            margin-bottom: 30px;
        }


        .profile-item {
            padding: 15px 0;

            border-bottom:
                1px solid #eeeeee;
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


        .profile-buttons {
            text-align: center;

            margin-top: 30px;
        }


        .back-btn {
            display: inline-block;

            padding: 12px 25px;

            background: #49a7e8;

            color: white;

            text-decoration: none;

            border-radius: 10px;

            font-weight: 600;

            transition: 0.2s;
        }


        .back-btn:hover {
            background: #278ed2;
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
            <a href="orderHistory.jsp">
                My Orders
            </a>
        </li>


        <li>
            <a href="profile.jsp"
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
            My Profile
        </h2>


        <!-- NAME -->

        <div class="profile-item">

            <span class="profile-label">
                Full Name
            </span>

            <span class="profile-value">

                <%=user.getFullName()%>

            </span>

        </div>


        <!-- EMAIL -->

        <div class="profile-item">

            <span class="profile-label">
                Email
            </span>

            <span class="profile-value">

                <%=user.getEmail()%>

            </span>

        </div>


        <!-- PHONE -->

        <div class="profile-item">

            <span class="profile-label">
                Phone
            </span>

            <span class="profile-value">

                <%=user.getPhone()%>

            </span>

        </div>


        <!-- ADDRESS -->

        <div class="profile-item">

            <span class="profile-label">
                Address
            </span>

            <span class="profile-value">

                <%=user.getAddress()%>

            </span>

        </div>


        <!-- ACCOUNT TYPE -->

        <div class="profile-item">

            <span class="profile-label">
                Account Type
            </span>

            <span class="profile-value">

                Customer

            </span>

        </div>


        <!-- BACK BUTTON -->

        <div class="profile-buttons">

            <a href="userHome.jsp"
               class="back-btn">

                Back to Dashboard

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


            <a href="userHome.jsp">
                Dashboard
            </a>


            <a href="MenuServlet">
                Menu
            </a>


            <a href="CartServlet">
                My Cart
            </a>


            <a href="orderHistory.jsp">
                My Orders
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

        © 2026 FoodExpress.
        All Rights Reserved.

    </p>

</footer>


</body>

</html>