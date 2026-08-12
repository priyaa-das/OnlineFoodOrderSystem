<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FoodExpress | Register</title>

    <link rel="stylesheet" href="css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <div class="logo">

        FoodExpress

    </div>

    <ul class="nav-links">

        <li><a href="index.jsp">Home</a></li>

        <li><a href="menu.jsp">Menu</a></li>

        <li><a href="offers.jsp">Offers</a></li>

        <li><a href="about.jsp">About</a></li>

        <li><a href="contact.jsp">Contact</a></li>

        <li><a href="login.jsp" class="login-btn">Login</a></li>

    </ul>

</nav>

<!-- ================= PAGE BANNER ================= -->

<section class="page-banner">

    <div class="banner-content">

        <h1>Create Your Account</h1>

        <p>

            Register now to order delicious meals anytime.

        </p>

    </div>

</section>

<!-- ================= REGISTER SECTION ================= -->

<section class="register-section">

    <div class="register-box">

        <h2>Customer Registration</h2>

        <form action="RegisterServlet" method="post">

            <input
                type="text"
                name="fullName"
                placeholder="Full Name"
                required>

            <input
                type="email"
                name="email"
                placeholder="Email Address"
                required>

            <input
                type="text"
                name="phone"
                placeholder="Phone Number"
                required>

            <textarea
                name="address"
                placeholder="Full Address"
                required></textarea>

            <input
                type="password"
                name="password"
                placeholder="Password"
                required>

            <input
                type="password"
                name="confirmPassword"
                placeholder="Confirm Password"
                required>

            <button type="submit">

                Register

            </button>

        </form>

        <p>

            Already have an account?

            <a href="login.jsp">

                Login Here

            </a>

        </p>

    </div>

</section>
<!-- ================= FOOTER ================= -->

<footer>

    <div class="footer-container">

        <div class="footer-box">

            <h3>FoodExpress</h3>

            <p>

                Premium Online Food Ordering System
                serving fresh and delicious meals.

            </p>

        </div>

        <div class="footer-box">

            <h3>Quick Links</h3>

            <a href="index.jsp">Home</a>

            <a href="menu.jsp">Menu</a>

            <a href="offers.jsp">Offers</a>

            <a href="about.jsp">About</a>

            <a href="contact.jsp">Contact</a>

        </div>

        <div class="footer-box">

            <h3>Contact Us</h3>

            <p>Email : info@foodexpress.com</p>

            <p>Phone : +880 1700-123456</p>

            <p>Sylhet, Bangladesh</p>

        </div>

    </div>

    <hr>

    <p class="copyright">

        © 2026 FoodExpress. All Rights Reserved.

    </p>

</footer>

</body>

</html>