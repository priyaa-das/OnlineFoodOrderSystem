<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Login | FoodExpress</title>

    <link rel="stylesheet"
          href="css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <div class="logo">
        FoodExpress
    </div>

    <ul class="nav-links">

        <li>
            <a href="index.jsp">
                Home
            </a>
        </li>

        <li>
            <a href="menu.jsp">
                Menu
            </a>
        </li>

        <li>
            <a href="offers.jsp">
                Offers
            </a>
        </li>

        <li>
            <a href="about.jsp">
                About
            </a>
        </li>

        <li>
            <a href="contact.jsp">
                Contact
            </a>
        </li>

        <li>
            <a href="login.jsp">
                Login
            </a>
        </li>

        <li>
            <a href="register.jsp">
                Register
            </a>
        </li>

    </ul>

</nav>


<!-- ================= ADMIN LOGIN ================= -->

<section class="login-section">

    <div class="login-container">

        <div class="login-box">

            <div class="login-header">

                <h2>
                    
                    Admin Login
                    
                </h2>

            </div>


            <%
                String error =
                        request.getParameter("error");

                if ("invalid".equals(error)) {
            %>

                <p style="color:red;
                          text-align:center;
                          margin-bottom:15px;">

                    Invalid admin email or password.

                </p>

            <%
                }

                if ("access".equals(error)) {
            %>

                <p style="color:red;
                          text-align:center;
                          margin-bottom:15px;">

                    Access denied. Admin account required.

                </p>

            <%
                }
            %>


            <form action="AdminLoginServlet"
                  method="post">

                <div class="form-group">

                    <label>
                        Email
                    </label>

                    <input type="email"
                           name="email"
                           placeholder="Enter admin email"
                           required>

                </div>


                <div class="form-group">

                    <label>
                        Password
                    </label>

                    <input type="password"
                           name="password"
                           placeholder="Enter admin password"
                           required>

                </div>


                <button type="submit"
                        class="primary-btn">

                    Admin Login

                </button>

            </form>


            <div style="text-align:center;
                        margin-top:20px;">

                <p>
                    Not an admin?
                    <a href="login.jsp">
                        Customer Login
                    </a>
                </p>

            </div>

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
                Delicious food, fast delivery and
                premium online food ordering experience.
            </p>

        </div>


        <div class="footer-box">

            <h3>
                Quick Links
            </h3>

            <a href="index.jsp">
                Home
            </a>

            <a href="login.jsp">
                Customer Login
            </a>

            <a href="register.jsp">
                Register
            </a>

            <a href="adminLogin.jsp">
                Admin Login
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