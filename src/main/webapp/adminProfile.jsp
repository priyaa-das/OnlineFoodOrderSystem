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

    <title>Admin Profile | FoodExpress</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7ff;
            color: #1e293b;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            height: 90px;
            background: #2196F3;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 45px;

            box-shadow: 0 4px 15px rgba(0,0,0,0.12);
        }

        .logo {
            color: white;
            font-size: 28px;
            font-weight: bold;
        }

        .nav-right {
            display: flex;
            gap: 12px;
        }

        .nav-btn {
            text-decoration: none;
            color: white;

            padding: 11px 18px;

            border-radius: 7px;

            font-weight: 600;

            transition: 0.2s;
        }

        .nav-btn:hover {
            background: rgba(255,255,255,0.15);
        }

        /* ================= PAGE ================= */

        .page-container {
            max-width: 1000px;

            margin: 45px auto;

            padding: 0 25px;
        }

        /* ================= PROFILE CARD ================= */

        .profile-card {

            background: white;

            border-radius: 20px;

            padding: 45px;

            box-shadow:
                0 10px 35px rgba(0,0,0,0.08);
        }

        /* ================= HEADER ================= */

        .profile-header {

            text-align: center;

            margin-bottom: 40px;
        }

        .avatar {

            width: 110px;
            height: 110px;

            margin: 0 auto 18px;

            border-radius: 50%;

            background: #2196F3;

            display: flex;
            align-items: center;
            justify-content: center;

            color: white;

            font-size: 48px;
            font-weight: bold;

            box-shadow:
                0 8px 20px rgba(33,150,243,0.3);
        }

        .profile-header h1 {

            margin: 5px 0;

            font-size: 32px;
        }

        .profile-header p {

            margin: 8px 0;

            color: #64748b;

            font-size: 16px;
        }

        /* ================= INFO GRID ================= */

        .info-grid {

            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 22px;
        }

        .info-box {

            background: #f8fafc;

            border: 1px solid #e2e8f0;

            border-radius: 12px;

            padding: 22px;

            transition: 0.2s;
        }

        .info-box:hover {

            transform: translateY(-2px);

            box-shadow:
                0 5px 15px rgba(0,0,0,0.06);
        }

        .label {

            display: block;

            color: #64748b;

            font-size: 14px;

            margin-bottom: 8px;
        }

        .value {

            font-size: 18px;

            font-weight: 600;

            color: #0f172a;

            word-break: break-word;
        }

        /* ================= ROLE ================= */

        .role-badge {

            display: inline-block;

            background: #e0f2fe;

            color: #0284c7;

            padding: 7px 14px;

            border-radius: 20px;

            font-size: 14px;

            font-weight: bold;
        }

        /* ================= BUTTONS ================= */

        .action-buttons {

            display: flex;

            justify-content: center;

            gap: 15px;

            margin-top: 40px;

            flex-wrap: wrap;
        }

        .btn {

            display: inline-block;

            text-decoration: none;

            border: none;

            cursor: pointer;

            padding: 13px 25px;

            border-radius: 8px;

            font-size: 15px;

            font-weight: 600;

            transition: 0.2s;
        }

        .edit-btn {

            background: #2196F3;

            color: white;
        }

        .edit-btn:hover {

            background: #1976D2;

            transform: translateY(-2px);
        }

        .back-btn {

            background: #e2e8f0;

            color: #334155;
        }

        .back-btn:hover {

            background: #cbd5e1;
        }

        .logout-btn {

            background: #ef4444;

            color: white;
        }

        .logout-btn:hover {

            background: #dc2626;
        }

        /* ================= RESPONSIVE ================= */

        @media(max-width: 700px) {

            .navbar {

                padding: 0 20px;
            }

            .logo {

                font-size: 22px;
            }

            .info-grid {

                grid-template-columns: 1fr;
            }

            .profile-card {

                padding: 25px;
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

    <div class="nav-right">

        <a href="adminDashboard.jsp"
           class="nav-btn">
            Dashboard
        </a>

        <a href="LogoutServlet"
           class="nav-btn">
            Logout
        </a>

    </div>

</nav>


<!-- ================= PAGE ================= -->

<div class="page-container">

    <div class="profile-card">


        <!-- ================= PROFILE HEADER ================= -->

        <div class="profile-header">

            <div class="avatar">
                <%= admin.getFullName().substring(0,1).toUpperCase() %>
            </div>

            <h1>
                <%= admin.getFullName() %>
            </h1>

            <p>
                FoodExpress Administrator
            </p>

        </div>


        <!-- ================= INFORMATION ================= -->

        <div class="info-grid">


            <div class="info-box">

                <span class="label">
                    Full Name
                </span>

                <div class="value">
                    <%= admin.getFullName() %>
                </div>

            </div>


            <div class="info-box">

                <span class="label">
                    Email
                </span>

                <div class="value">
                    <%= admin.getEmail() %>
                </div>

            </div>


            <div class="info-box">

                <span class="label">
                    Phone
                </span>

                <div class="value">

                    <%
                        String phone = admin.getPhone();

                        if (phone == null ||
                            phone.trim().isEmpty()) {
                    %>

                        Not Provided

                    <%
                        } else {
                    %>

                        <%= phone %>

                    <%
                        }
                    %>

                </div>

            </div>


            <div class="info-box">

                <span class="label">
                    Role
                </span>

                <div class="value">

                    <span class="role-badge">
                        Administrator
                    </span>

                </div>

            </div>


            <div class="info-box"
                 style="grid-column: 1 / -1;">

                <span class="label">
                    Address
                </span>

                <div class="value">

                    <%
                        String address = admin.getAddress();

                        if (address == null ||
                            address.trim().isEmpty()) {
                    %>

                        Not Provided

                    <%
                        } else {
                    %>

                        <%= address %>

                    <%
                        }
                    %>

                </div>

            </div>


        </div>


        <!-- ================= BUTTONS ================= -->

        <div class="action-buttons">


            <!-- NEW EDIT BUTTON -->

            <a href="editAdminProfile.jsp"
               class="btn edit-btn">

                Edit Profile

            </a>


            <a href="adminDashboard.jsp"
               class="btn back-btn">

                Back to Dashboard

            </a>


            <a href="LogoutServlet"
               class="btn logout-btn">

                Logout

            </a>

        </div>


    </div>

</div>


</body>

</html>