<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>FoodExpress | Login</title>

    <link rel="stylesheet"
          href="css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">


    <style>

        /* =====================================================
           LOGIN PAGE BACKGROUND
        ===================================================== */

        body {
            margin: 0;
            background: #f1f8ff;
            overflow-x: hidden;
        }


        /* =====================================================
           PAGE BANNER
        ===================================================== */

        .page-banner {
            position: relative;

            height: 350px;

            display: flex;

            justify-content: center;

            align-items: flex-start;

            text-align: center;

            overflow: hidden;

            background:
                linear-gradient(
                    135deg,
                    #168bea 0%,
                    #28a8ed 45%,
                    #51c9df 100%
                );

            color: white;

            padding-top: 55px;

            box-sizing: border-box;
        }


        /* Large floating circles */

        .page-banner::before {

            content: "";

            position: absolute;

            width: 280px;
            height: 280px;

            left: -100px;
            top: 20px;

            border-radius: 50%;

            background: rgba(255,255,255,0.10);

        }


        .page-banner::after {

            content: "";

            position: absolute;

            width: 300px;
            height: 300px;

            right: -100px;
            top: -120px;

            border-radius: 50%;

            background: rgba(255,255,255,0.12);

        }


        /* =====================================================
           DOT PATTERN
        ===================================================== */

        .banner-content::before {

            content: "• • • • • • •\A• • • • • • •\A• • • • • • •";

            white-space: pre;

            position: absolute;

            left: 12%;

            top: 105px;

            line-height: 25px;

            font-size: 18px;

            letter-spacing: 7px;

            color: rgba(255,255,255,0.35);

        }


        .banner-content::after {

            content: "• • • • • • •\A• • • • • • •\A• • • • • • •";

            white-space: pre;

            position: absolute;

            right: 10%;

            top: 120px;

            line-height: 25px;

            font-size: 18px;

            letter-spacing: 7px;

            color: rgba(255,255,255,0.30);

        }


        /* =====================================================
           BANNER TEXT
        ===================================================== */

        .banner-content {

            position: relative;

            z-index: 5;

            width: 100%;
        }


        .banner-content h1 {

            margin: 0;

            font-size: 52px;

            font-weight: 700;

            letter-spacing: 1px;

            text-shadow:
                0 4px 15px rgba(0,0,0,0.10);

        }


        .banner-content p {

            margin-top: 18px;

            font-size: 20px;

            font-weight: 400;

            opacity: 0.96;

        }


        /* =====================================================
           CURVED WHITE / LIGHT AREA
        ===================================================== */

        .page-banner {

            clip-path: ellipse(85% 75% at 50% 20%);

        }


        /* =====================================================
           LOGIN SECTION
        ===================================================== */

        .register-section {

            position: relative;

            margin-top: -80px;

            min-height: 570px;

            padding: 70px 20px 100px;

            display: flex;

            justify-content: center;

            align-items: flex-start;

            background:

                radial-gradient(
                    circle at 10% 70%,
                    rgba(84,177,241,0.12) 0,
                    rgba(84,177,241,0.12) 80px,
                    transparent 81px
                ),

                radial-gradient(
                    circle at 90% 30%,
                    rgba(84,177,241,0.10) 0,
                    rgba(84,177,241,0.10) 110px,
                    transparent 111px
                ),

                linear-gradient(
                    135deg,
                    #f8fcff,
                    #eef8ff,
                    #f7fbff
                );

            overflow: hidden;
        }


        /* Decorative floating circles */

        .register-section::before {

            content: "";

            position: absolute;

            width: 170px;
            height: 170px;

            left: -70px;
            bottom: 40px;

            border-radius: 50%;

            background:
                linear-gradient(
                    135deg,
                    rgba(75,168,235,0.15),
                    rgba(74,199,220,0.05)
                );

            animation: floatOne 5s ease-in-out infinite;

        }


        .register-section::after {

            content: "";

            position: absolute;

            width: 220px;
            height: 220px;

            right: -90px;
            bottom: -40px;

            border-radius: 50%;

            background:
                linear-gradient(
                    135deg,
                    rgba(75,168,235,0.12),
                    rgba(74,199,220,0.04)
                );

            animation: floatTwo 6s ease-in-out infinite;

        }


        @keyframes floatOne {

            0%,100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-20px);
            }

        }


        @keyframes floatTwo {

            0%,100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(20px);
            }

        }


        /* =====================================================
           LOGIN BOX
        ===================================================== */

        .register-box {

            position: relative;

            z-index: 10;

            width: 510px;

            max-width: 100%;

            background: rgba(255,255,255,0.96);

            padding: 45px 45px 40px;

            border-radius: 22px;

            box-shadow:
                0 20px 55px rgba(28,100,150,0.14);

            border: 1px solid rgba(255,255,255,0.9);

            transition:
                transform 0.3s ease,
                box-shadow 0.3s ease;

            box-sizing: border-box;

        }


        .register-box:hover {

            transform: translateY(-5px);

            box-shadow:
                0 25px 65px rgba(28,100,150,0.20);

        }


        /* =====================================================
           LOGIN TITLE
        ===================================================== */

        .register-box h2 {

            text-align: center;

            margin: 0 0 35px;

            color: #123f68;

            font-size: 30px;

            font-weight: 700;

        }


        /* =====================================================
           INPUTS
        ===================================================== */

        .register-box form {

            width: 100%;

        }


        .register-box input {

            width: 100%;

            height: 60px;

            padding: 0 18px;

            margin-bottom: 20px;

            border: 1px solid #d2d9df;

            border-radius: 10px;

            outline: none;

            font-family: 'Poppins', sans-serif;

            font-size: 16px;

            color: #333;

            background: #ffffff;

            box-sizing: border-box;

            transition:
                border-color 0.25s ease,
                box-shadow 0.25s ease,
                transform 0.25s ease;

        }


        .register-box input::placeholder {

            color: #777;

        }


        .register-box input:hover {

            border-color: #8fc8ed;

        }


        .register-box input:focus {

            border-color: #299fe7;

            box-shadow:
                0 0 0 4px rgba(41,159,231,0.12);

            transform: translateY(-1px);

        }


        /* =====================================================
           LOGIN BUTTON
        ===================================================== */

        .register-box button {

            width: 100%;

            height: 60px;

            border: none;

            border-radius: 10px;

            background:
                linear-gradient(
                    135deg,
                    #299fe7,
                    #38aee8
                );

            color: white;

            font-family: 'Poppins', sans-serif;

            font-size: 18px;

            font-weight: 500;

            cursor: pointer;

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease,
                background 0.25s ease;

        }


        .register-box button:hover {

            background:
                linear-gradient(
                    135deg,
                    #168ed8,
                    #26a4df
                );

            transform: translateY(-2px);

            box-shadow:
                0 10px 22px rgba(41,159,231,0.28);

        }


        .register-box button:active {

            transform: scale(0.98);

        }


        /* =====================================================
           REGISTER TEXT
        ===================================================== */

        .register-box > p {

            text-align: center;

            margin-top: 25px;

            margin-bottom: 0;

            color: #222;

            font-size: 16px;

        }


        .register-box > p a {

            color: #299fe7;

            text-decoration: none;

            font-weight: 600;

            transition: color 0.2s ease;

        }


        .register-box > p a:hover {

            color: #087fc7;

            text-decoration: underline;

        }


        /* =====================================================
           RESPONSIVE
        ===================================================== */

        @media (max-width: 768px) {

            .page-banner {

                height: 310px;

                padding-top: 45px;

            }


            .banner-content h1 {

                font-size: 40px;

            }


            .banner-content p {

                font-size: 16px;

                padding: 0 20px;

            }


            .register-section {

                margin-top: -60px;

                padding-top: 50px;

            }


            .register-box {

                padding: 35px 25px;

            }

        }


        @media (max-width: 480px) {

            .page-banner {

                height: 280px;

            }


            .banner-content h1 {

                font-size: 32px;

            }


            .banner-content p {

                font-size: 14px;

            }


            .register-box h2 {

                font-size: 25px;

            }


            .register-box input,
            .register-box button {

                height: 55px;

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
            <a href="login.jsp"
               class="login-btn">

                Login

            </a>
        </li>


        <li>
            <a href="register.jsp"
               class="register-btn">

                Register

            </a>
        </li>

    </ul>

</nav>


<!-- ================= PAGE BANNER ================= -->

<section class="page-banner">

    <div class="banner-content">

        <h1>
            Welcome Back
        </h1>

        <p>
            Login to continue ordering your favorite meals.
        </p>

    </div>

</section>


<!-- ================= LOGIN SECTION ================= -->

<section class="register-section">


    <div class="register-box">


        <h2>
            Customer Login
        </h2>


        <form action="LoginServlet"
              method="post">


            <input
                type="email"
                name="email"
                placeholder="Email Address"
                required>


            <input
                type="password"
                name="password"
                placeholder="Password"
                required>


            <button type="submit">

                Login

            </button>


        </form>


        <p>

            Don't have an account?

            <a href="register.jsp">

                Register Here

            </a>

        </p>


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

                Premium Online Food Ordering System serving fresh,
                delicious meals with fast delivery and quality service.

            </p>

        </div>



        <div class="footer-box">

            <h3>

                Quick Links

            </h3>


            <a href="index.jsp">

                Home

            </a>


            <a href="menu.jsp">

                Menu

            </a>


            <a href="offers.jsp">

                Offers

            </a>


            <a href="about.jsp">

                About

            </a>


            <a href="contact.jsp">

                Contact

            </a>


            <a href="register.jsp">

                Register

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

                Address : Sylhet, Bangladesh

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