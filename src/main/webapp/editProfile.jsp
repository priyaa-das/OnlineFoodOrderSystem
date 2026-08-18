<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String fullName = user.getFullName() != null
            ? user.getFullName() : "";

    String email = user.getEmail() != null
            ? user.getEmail() : "";

    String phone = user.getPhone() != null
            ? user.getPhone() : "";

    String address = user.getAddress() != null
            ? user.getAddress() : "";

    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Profile - FoodExpress</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f9fc;
            color: #263238;
        }

        /* =========================
           NAVBAR
        ========================= */

        .navbar {
            height: 72px;
            background: white;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 7%;

            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }

        .logo {
            text-decoration: none;
            font-size: 25px;
            font-weight: 800;
            color: #48a9c5;
        }

        .nav-links {
            display: flex;
            gap: 28px;
        }

        .nav-links a {
            text-decoration: none;
            color: #455a64;
            font-size: 14px;
            font-weight: 600;
        }

        .nav-links a:hover {
            color: #48a9c5;
        }

        .profile-link {
            color: #48a9c5 !important;
        }

        /* =========================
           PAGE
        ========================= */

        .page {
            width: 90%;
            max-width: 650px;

            margin: 45px auto 60px;
        }

        .page-title {
            text-align: center;
            margin-bottom: 28px;
        }

        .page-title h1 {
            font-size: 30px;
            color: #263238;
            margin-bottom: 8px;
        }

        .page-title p {
            color: #78909c;
            font-size: 14px;
        }

        /* =========================
           CARD
        ========================= */

        .card {
            background: white;
            border-radius: 18px;

            padding: 35px;

            box-shadow: 0 5px 22px rgba(0,0,0,0.07);
        }

        /* =========================
           MESSAGE
        ========================= */

        .message {
            padding: 13px 15px;
            border-radius: 9px;
            margin-bottom: 20px;

            font-size: 14px;
            font-weight: 600;
        }

        .error {
            background: #fff0f0;
            color: #d9534f;
            border: 1px solid #f2cccc;
        }

        .success {
            background: #eef9f3;
            color: #2e7d32;
            border: 1px solid #c8e6c9;
        }

        /* =========================
           FORM
        ========================= */

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;

            font-size: 13px;
            font-weight: 700;

            color: #546e7a;

            margin-bottom: 8px;
        }

        .form-group input,
        .form-group textarea {

            width: 100%;

            padding: 13px 14px;

            border: 1px solid #d8e4e9;

            border-radius: 9px;

            font-size: 14px;

            outline: none;

            background: #fbfdfe;

            color: #263238;

            transition: 0.2s;
        }

        .form-group input:focus,
        .form-group textarea:focus {

            border-color: #48a9c5;

            background: white;

            box-shadow: 0 0 0 3px rgba(72,169,197,0.10);
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        .email-note {
            margin-top: 6px;
            color: #90a4ae;
            font-size: 11px;
        }

        /* =========================
           BUTTONS
        ========================= */

        .actions {

            display: flex;

            justify-content: center;

            gap: 12px;

            margin-top: 28px;
        }

        .btn {

            border: none;

            padding: 12px 25px;

            border-radius: 9px;

            font-size: 14px;

            font-weight: 700;

            text-decoration: none;

            cursor: pointer;

            transition: 0.2s;
        }

        .save-btn {

            background: #48a9c5;

            color: white;
        }

        .save-btn:hover {
            background: #3593ae;
        }

        .cancel-btn {

            background: #edf3f6;

            color: #455a64;
        }

        .cancel-btn:hover {
            background: #dfe9ed;
        }

        /* =========================
           MOBILE
        ========================= */

        @media(max-width:700px) {

            .navbar {
                padding: 0 20px;
            }

            .nav-links {
                gap: 12px;
            }

            .nav-links a {
                font-size: 12px;
            }

            .page {
                width: 94%;
                margin-top: 30px;
            }

            .card {
                padding: 25px 20px;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                text-align: center;
                width: 100%;
            }
        }

    </style>

</head>

<body>


<!-- =========================
     NAVBAR
========================= -->

<nav class="navbar">

    <a href="userHome.jsp" class="logo">
        FoodExpress
    </a>

    <div class="nav-links">

        <a href="userHome.jsp">
            Home
        </a>

        <a href="MenuServlet">
            Menu
        </a>

        <a href="CartServlet">
            Cart
        </a>

        <a href="OrderHistoryServlet">
            Orders
        </a>

        <a href="profile.jsp" class="profile-link">
            Profile
        </a>

    </div>

</nav>


<!-- =========================
     MAIN
========================= -->

<div class="page">

    <div class="page-title">

        <h1>Edit Profile</h1>

        <p>
            Update your FoodExpress account information
        </p>

    </div>


    <div class="card">


        <% if ("database".equals(error)) { %>

            <div class="message error">
                Unable to update your profile.
                Please check your database connection.
            </div>

        <% } else if ("email".equals(error)) { %>

            <div class="message error">
                This email address is already being used
                by another account.
            </div>

        <% } else if ("required".equals(error)) { %>

            <div class="message error">
                Full name and email are required.
            </div>

        <% } else if ("notupdated".equals(error)) { %>

            <div class="message error">
                No changes were made to your profile.
            </div>

        <% } %>


        <form action="UpdateProfileServlet"
              method="post">


            <!-- FULL NAME -->

            <div class="form-group">

                <label>
                    Full Name
                </label>

                <input
                    type="text"
                    name="fullName"
                    value="<%= fullName %>"
                    required
                    maxlength="100"
                    placeholder="Enter your full name">

            </div>


            <!-- EMAIL -->

            <div class="form-group">

                <label>
                    Email
                </label>

                <input
                    type="email"
                    name="email"
                    value="<%= email %>"
                    required
                    maxlength="100"
                    placeholder="Enter your email">

                <div class="email-note">
                    Email must be unique.
                </div>

            </div>


            <!-- PHONE -->

            <div class="form-group">

                <label>
                    Phone Number
                </label>

                <input
                    type="text"
                    name="phone"
                    value="<%= phone %>"
                    maxlength="20"
                    placeholder="Enter your phone number">

            </div>


            <!-- ADDRESS -->

            <div class="form-group">

                <label>
                    Delivery Address
                </label>

                <textarea
                    name="address"
                    maxlength="500"
                    placeholder="Enter your delivery address"><%= address %></textarea>

            </div>


            <!-- BUTTONS -->

            <div class="actions">

                <button
                    type="submit"
                    class="btn save-btn">

                    Save Changes

                </button>


                <a
                    href="profile.jsp"
                    class="btn cancel-btn">

                    Cancel

                </a>

            </div>


        </form>

    </div>

</div>

</body>

</html>