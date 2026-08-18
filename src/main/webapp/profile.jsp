<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String fullName = user.getFullName() != null
            && !user.getFullName().trim().isEmpty()
            ? user.getFullName()
            : "User";

    String email = user.getEmail() != null
            && !user.getEmail().trim().isEmpty()
            ? user.getEmail()
            : "Not available";

    String phone = user.getPhone() != null
            && !user.getPhone().trim().isEmpty()
            ? user.getPhone()
            : "Not provided";

    String address = user.getAddress() != null
            && !user.getAddress().trim().isEmpty()
            ? user.getAddress()
            : "No address added";

    String role = user.getRole() != null
            ? user.getRole()
            : "customer";

    String firstLetter = fullName.substring(0, 1).toUpperCase();

    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Profile - FoodExpress</title>

    <style>

        /* =========================================
           GLOBAL
        ========================================= */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f3f8fc;
            color: #243746;
        }

        /* =========================================
           NAVBAR
        ========================================= */

        .navbar {
            height: 72px;
            background: #ffffff;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 7%;

            box-shadow: 0 2px 12px rgba(74, 144, 176, 0.10);

            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo {
            font-size: 25px;
            font-weight: 800;
            color: #4a9fbd;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 28px;
        }

        .nav-links a {
            text-decoration: none;
            color: #4b5963;
            font-size: 14px;
            font-weight: 600;
            transition: 0.2s;
        }

        .nav-links a:hover {
            color: #4a9fbd;
        }

        .profile-link {
            color: #4a9fbd !important;
        }

        /* =========================================
           MAIN PAGE
        ========================================= */

        .page {
            width: 90%;
            max-width: 900px;
            margin: 45px auto 60px;
        }

        .page-title {
            text-align: center;
            margin-bottom: 28px;
        }

        .page-title h1 {
            font-size: 31px;
            color: #263b49;
            margin-bottom: 8px;
        }

        .page-title p {
            color: #7b8b95;
            font-size: 14px;
        }

        /* =========================================
           SUCCESS MESSAGE
        ========================================= */

        .success-message {
            background: #e7f6fb;
            color: #26758e;

            border: 1px solid #b9e4ef;

            padding: 13px 18px;
            border-radius: 10px;

            margin-bottom: 20px;

            text-align: center;
            font-size: 14px;
            font-weight: 600;
        }

        /* =========================================
           PROFILE CARD
        ========================================= */

        .profile-card {
            background: #ffffff;

            border-radius: 18px;

            padding: 35px;

            box-shadow:
                0 6px 25px rgba(74, 144, 176, 0.10);
        }

        /* =========================================
           PROFILE TOP
        ========================================= */

        .profile-top {
            text-align: center;

            padding-bottom: 28px;

            border-bottom: 1px solid #e4edf2;
        }

        .avatar {
            width: 88px;
            height: 88px;

            margin: auto;

            border-radius: 50%;

            background: #dff3f8;
            color: #398ca8;

            border: 3px solid #bde5ee;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 36px;
            font-weight: 700;
        }

        .profile-top h2 {
            margin-top: 15px;

            color: #263b49;

            font-size: 23px;
        }

        .role {
            display: inline-block;

            margin-top: 8px;

            padding: 6px 15px;

            border-radius: 20px;

            background: #e7f6fa;

            color: #398ca8;

            font-size: 12px;
            font-weight: 700;

            text-transform: capitalize;
        }

        /* =========================================
           SECTION TITLE
        ========================================= */

        .section-title {
            margin: 28px 0 18px;

            font-size: 18px;

            font-weight: 700;

            color: #263b49;
        }

        /* =========================================
           INFORMATION GRID
        ========================================= */

        .info-grid {
            display: grid;

            grid-template-columns: 1fr 1fr;

            gap: 17px;
        }

        .info-box {
            background: #f5fafc;

            border: 1px solid #e1edf2;

            border-radius: 12px;

            padding: 18px;

            transition: 0.2s;
        }

        .info-box:hover {
            border-color: #b9dfe9;

            box-shadow:
                0 4px 12px rgba(74, 144, 176, 0.08);
        }

        .info-box label {
            display: block;

            color: #7b8b95;

            font-size: 11px;

            margin-bottom: 8px;

            font-weight: 700;

            letter-spacing: 0.5px;
        }

        .info-box p {
            color: #304653;

            font-size: 15px;

            font-weight: 600;

            word-break: break-word;
        }

        .address-box {
            grid-column: 1 / 3;
        }

        /* =========================================
           ACTION BUTTONS
        ========================================= */

        .actions {
            display: flex;

            justify-content: center;

            gap: 12px;

            margin-top: 30px;
        }

        .btn {
            display: inline-block;

            padding: 12px 25px;

            border-radius: 9px;

            text-decoration: none;

            font-size: 14px;

            font-weight: 700;

            transition: 0.2s;
        }

        .edit-btn {
            background: #5aa9c3;

            color: #ffffff;

            border: 1px solid #5aa9c3;
        }

        .edit-btn:hover {
            background: #438fa9;

            border-color: #438fa9;
        }

        .home-btn {
            background: #edf5f8;

            color: #42606e;

            border: 1px solid #d7e7ed;
        }

        .home-btn:hover {
            background: #e1f0f5;
        }

        /* =========================================
           DELETE ACCOUNT
        ========================================= */

        .danger-zone {
            margin-top: 32px;

            padding-top: 25px;

            border-top: 1px solid #e4edf2;

            text-align: center;
        }

        .danger-zone h3 {
            color: #c75c62;

            font-size: 17px;

            margin-bottom: 7px;
        }

        .danger-zone p {
            color: #89969d;

            font-size: 13px;

            margin-bottom: 17px;
        }

        .delete-btn {
            border: 1px solid #d36b70;

            background: #ffffff;

            color: #c75c62;

            padding: 10px 20px;

            border-radius: 8px;

            font-size: 13px;

            font-weight: 700;

            cursor: pointer;

            transition: 0.2s;
        }

        .delete-btn:hover {
            background: #c75c62;

            color: #ffffff;
        }

        /* =========================================
           FOOTER
        ========================================= */

        .footer {
            text-align: center;

            color: #8a9aa3;

            font-size: 12px;

            margin-top: 35px;
        }

        /* =========================================
           MOBILE
        ========================================= */

        @media (max-width: 700px) {

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

            .profile-card {
                padding: 25px 20px;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .address-box {
                grid-column: 1;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                text-align: center;
            }
        }

    </style>

</head>

<body>


<!-- =========================================
     NAVBAR
========================================= -->

<nav class="navbar">

    <a href="userHome.jsp"
       class="logo">
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

        <a href="profile.jsp"
           class="profile-link">
            Profile
        </a>

    </div>

</nav>


<!-- =========================================
     MAIN
========================================= -->

<div class="page">


    <div class="page-title">

        <h1>
            My Profile
        </h1>

        <p>
            Manage your FoodExpress account information
        </p>

    </div>


    <% if ("1".equals(success)) { %>

        <div class="success-message">
            Profile updated successfully.
        </div>

    <% } %>


    <div class="profile-card">


        <!-- =====================================
             PROFILE HEADER
        ====================================== -->

        <div class="profile-top">

            <div class="avatar">
                <%= firstLetter %>
            </div>

            <h2>
                <%= fullName %>
            </h2>

            <span class="role">
                <%= role %>
            </span>

        </div>


        <!-- =====================================
             ACCOUNT INFORMATION
        ====================================== -->

        <h3 class="section-title">
            Account Information
        </h3>


        <div class="info-grid">


            <div class="info-box">

                <label>
                    FULL NAME
                </label>

                <p>
                    <%= fullName %>
                </p>

            </div>


            <div class="info-box">

                <label>
                    EMAIL
                </label>

                <p>
                    <%= email %>
                </p>

            </div>


            <div class="info-box">

                <label>
                    PHONE
                </label>

                <p>
                    <%= phone %>
                </p>

            </div>


            <div class="info-box">

                <label>
                    ACCOUNT TYPE
                </label>

                <p>
                    <%= role %>
                </p>

            </div>


            <div class="info-box address-box">

                <label>
                    DELIVERY ADDRESS
                </label>

                <p>
                    <%= address %>
                </p>

            </div>


        </div>


        <!-- =====================================
             ACTION BUTTONS
        ====================================== -->

        <div class="actions">

            <a href="editProfile.jsp"
               class="btn edit-btn">
                Edit Profile
            </a>


            <a href="userHome.jsp"
               class="btn home-btn">
                Back to Home
            </a>

        </div>


        <!-- =====================================
             DELETE ACCOUNT
        ====================================== -->

        <div class="danger-zone">

            <h3>
                Delete Account
            </h3>

            <p>
                Permanently delete your FoodExpress account.
                This action cannot be undone.
            </p>


            <form action="DeleteAccountServlet"
                  method="post"
                  onsubmit="return confirmDelete();">

                <button type="submit"
                        class="delete-btn">

                    Delete My Account

                </button>

            </form>

        </div>


    </div>


    <div class="footer">

        FoodExpress &copy; 2026. All rights reserved.

    </div>


</div>


<script>

function confirmDelete() {

    return confirm(
        "Are you sure you want to permanently delete your account?\n\n" +
        "This action cannot be undone."
    );

}

</script>


</body>
</html>