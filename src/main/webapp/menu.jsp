<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.foodexpress.model.User"%>
<%@page import="com.foodexpress.model.Food"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Food> foodList =
            (List<Food>) request.getAttribute("foodList");

    Map<Integer, String> categoryMap =
            new LinkedHashMap<>();

    categoryMap.put(1, "🍔 Burger");
    categoryMap.put(2, "🍕 Pizza");
    categoryMap.put(3, "🍝 Pasta");
    categoryMap.put(4, "🥩 Steak");
    categoryMap.put(5, "🦞 Seafood");
    categoryMap.put(6, "🍰 Dessert");
    categoryMap.put(7, "🥤 Beverages");
%>


<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Food Menu | FoodExpress</title>

    <link rel="stylesheet"
          href="css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">


    <style>

        /* =========================================
           FOOD CONTAINER
        ========================================= */

        .food-container {

            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(280px, 1fr));

            gap: 25px;

            margin-top: 25px;
        }


        /* =========================================
           FOOD CARD
        ========================================= */

        .food-card {

            background: #ffffff;

            border-radius: 18px;

            overflow: hidden;

            box-shadow:
                0 6px 20px rgba(0, 0, 0, 0.10);

            transition:
                transform 0.3s ease,
                box-shadow 0.3s ease;

        }


        .food-card:hover {

            transform: translateY(-6px);

            box-shadow:
                0 12px 30px rgba(0, 0, 0, 0.15);

        }


        /* =========================================
           IMAGE CONTAINER
        ========================================= */

        .food-image-box {

            position: relative;

            width: 100%;

            height: 220px;

            overflow: hidden;

            background: #f5f5f5;

        }


        .food-image-box img {

            width: 100%;

            height: 100%;

            object-fit: cover;

            display: block;

            transition:
                transform 0.3s ease;

        }


        .food-card:hover
        .food-image-box img {

            transform: scale(1.04);

        }


        /* =========================================
           UNAVAILABLE OVERLAY
        ========================================= */

        .unavailable-overlay {

            position: absolute;

            top: 0;

            left: 0;

            width: 100%;

            height: 100%;

            background:
                rgba(0, 0, 0, 0.68);

            display: flex;

            justify-content: center;

            align-items: center;

            z-index: 5;

        }


        .unavailable-overlay span {

            color: white;

            font-size: 32px;

            font-weight: 700;

            letter-spacing: 0.5px;

            text-align: center;

        }


        /* =========================================
           FOOD INFO
        ========================================= */

        .food-info {

            padding: 20px;

        }


        .food-info h3 {

            margin: 0 0 8px;

            font-size: 23px;

            font-weight: 600;

            color: #222;

        }


        .food-info p {

            color: #777;

            font-size: 14px;

            line-height: 1.6;

            min-height: 45px;

            margin: 10px 0 18px;

        }


        /* =========================================
           PRICE
        ========================================= */

        .price {

            display: block;

            font-size: 21px;

            font-weight: 700;

            color: #e53935;

            margin-bottom: 15px;

        }


        /* =========================================
           ADD TO CART BUTTON
        ========================================= */

        .food-info form {

            margin: 0;

        }


        .food-info button {

            width: 100%;

            border: none;

            background: #49a7e8;

            color: white;

            padding: 12px 18px;

            border-radius: 10px;

            font-size: 16px;

            font-weight: 600;

            cursor: pointer;

            transition:
                background 0.25s ease,
                transform 0.2s ease;

        }


        .food-info button:hover {

            background: #278ed2;

            transform: translateY(-1px);

        }


        /* =========================================
           CATEGORY TITLE
        ========================================= */

        .featured h2 {

            font-size: 30px;

            margin-bottom: 10px;

        }


        /* =========================================
           NO FOOD
        ========================================= */

        .no-food {

            text-align: center;

            padding: 60px 20px;

        }


        /* =========================================
           RESPONSIVE
        ========================================= */

        @media (max-width: 700px) {

            .food-container {

                grid-template-columns: 1fr;

            }

            .food-image-box {

                height: 230px;

            }

            .unavailable-overlay span {

                font-size: 27px;

            }

        }

    </style>

</head>


<body>


<!-- =====================================================
     NAVBAR
===================================================== -->

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
            <a href="MenuServlet"
               class="active">
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
            <a href="profile.jsp">
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



<!-- =====================================================
     HERO
===================================================== -->

<section class="dashboard-hero">

    <div class="dashboard-left">

        <span class="tagline">
            Fresh & Delicious
        </span>


        <h1>
            Explore Our Menu
        </h1>


        <p>

            Choose your favorite meals prepared by
            our expert chefs.

            Fresh ingredients, premium quality and
            fast delivery.

        </p>

    </div>


    <div class="dashboard-right">

        <img
            src="https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg"
            alt="Restaurant Food">

    </div>

</section>



<!-- =====================================================
     DYNAMIC MENU
===================================================== -->

<%

    if (foodList != null &&
        !foodList.isEmpty()) {


        for (Integer categoryId :
                categoryMap.keySet()) {


            boolean hasFood = false;


            /*
             * Check whether this category
             * contains food
             */

            for (Food f : foodList) {

                if (f.getCategoryId()
                        == categoryId) {

                    hasFood = true;

                    break;
                }
            }


            if (hasFood) {

%>


<section class="featured">


    <!-- CATEGORY NAME -->

    <h2>
        <%=categoryMap.get(categoryId)%>
    </h2>


    <div class="food-container">


<%

                /*
                 * SHOW FOODS
                 */

                for (Food food : foodList) {


                    if (food.getCategoryId()
                            == categoryId) {


                        /*
                         * CHECK FOOD STATUS
                         */

                        boolean available =
                                "Available".equalsIgnoreCase(
                                        food.getStatus()
                                );

%>


<!-- =====================================================
     FOOD CARD
===================================================== -->

<div class="food-card">


    <!-- ================= IMAGE ================= -->

    <div class="food-image-box">


        <img
            src="<%=food.getImageUrl()%>"
            alt="<%=food.getFoodName()%>"
            onerror="this.src='images/default-food.jpg';">


        <%

            /*
             * IF FOOD IS UNAVAILABLE
             */

            if (!available) {

        %>


        <div class="unavailable-overlay">

            <span>
                Unavailable
            </span>

        </div>


        <%

            }

        %>


    </div>



    <!-- ================= FOOD INFO ================= -->

    <div class="food-info">


        <!-- FOOD NAME -->

        <h3>
            <%=food.getFoodName()%>
        </h3>



        <!-- PRICE -->

        <span class="price">

            ৳<%=food.getPrice()%>

        </span>



        <!-- DESCRIPTION -->

        <p>

            <%=food.getDescription()%>

        </p>



        <%

            /*
             * =========================================
             * AVAILABLE FOOD
             * SHOW ADD TO CART
             * =========================================
             */

            if (available) {

        %>


        <form
            action="<%=request.getContextPath()%>/CartServlet"
            method="post">


            <input
                type="hidden"
                name="action"
                value="add">


            <input
                type="hidden"
                name="foodId"
                value="<%=food.getFoodId()%>">


            <input
                type="hidden"
                name="quantity"
                value="1">


            <button
                type="submit">

                Add To Cart

            </button>


        </form>


        <%

            }

            /*
             * IMPORTANT:
             *
             * যদি food unavailable হয়,
             * এখানে কোনো button দেখানো হবে না।
             */

        %>


    </div>


</div>


<%

                    }

                }

%>


    </div>

</section>


<%

            }

        }


    } else {

%>



<!-- =====================================================
     NO FOOD
===================================================== -->

<section class="featured no-food">


    <h2>
        No Food Available
    </h2>


    <p>
        No food found in database.
    </p>


</section>


<%

    }

%>



<!-- =====================================================
     FOOTER
===================================================== -->

<footer>


    <div class="footer-container">


        <div class="footer-box">

            <h3>
                FoodExpress
            </h3>


            <p>

                Fresh food, fast delivery and
                premium dining experience
                at your fingertips.

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