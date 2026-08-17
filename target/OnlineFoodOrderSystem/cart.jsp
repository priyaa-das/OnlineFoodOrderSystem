<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.foodexpress.model.User"%>
<%@page import="com.foodexpress.model.Cart"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Cart> cartList =
            (List<Cart>) request.getAttribute("cartList");

    double subtotal = 0;

    if (cartList != null) {
        for (Cart cart : cartList) {
            subtotal += cart.getPrice() * cart.getQuantity();
        }
    }

    double deliveryCharge = (subtotal >= 2000) ? 0 : 60;
    double vat = subtotal * 0.05;
    double grandTotal = subtotal + deliveryCharge + vat;
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Cart | FoodExpress</title>

    <link rel="stylesheet"
          href="css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">


    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: #f5f8fc;
            color: #1e293b;
        }


        /* ================= NAVBAR ================= */

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 55px;
            background: #2196F3;
            box-shadow: 0 4px 15px rgba(0,0,0,0.12);
        }

        .logo {
            color: white;
            font-size: 27px;
            font-weight: 700;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 25px;
            margin: 0;
            padding: 0;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
        }

        .nav-links a:hover {
            opacity: 0.8;
        }

        .nav-links .active {
            border-bottom: 2px solid white;
            padding-bottom: 4px;
        }

        .logout-btn {
            background: white;
            color: #2196F3 !important;
            padding: 8px 17px;
            border-radius: 6px;
        }


        /* ================= HERO ================= */

        .cart-hero {
            min-height: 280px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 45px 70px;

            background: linear-gradient(
                135deg,
                #e3f2fd,
                #ffffff
            );
        }

        .hero-text {
            max-width: 600px;
        }

        .tagline {
            color: #2196F3;
            font-size: 15px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .hero-text h1 {
            font-size: 42px;
            margin: 10px 0;
            color: #172554;
        }

        .hero-text p {
            color: #64748b;
            font-size: 16px;
        }

        .hero-image img {
            width: 300px;
            height: 210px;
            object-fit: cover;
            border-radius: 18px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }


        /* ================= MAIN ================= */

        .cart-section {
            padding: 50px 70px;
        }

        .cart-title {
            font-size: 28px;
            margin-bottom: 25px;
        }

        .cart-container {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 30px;
            align-items: start;
        }


        /* ================= TABLE ================= */

        .cart-table-box {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.07);
            overflow-x: auto;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
        }

        .cart-table th {
            background: #e3f2fd;
            color: #1565c0;
            padding: 15px;
            text-align: left;
            font-size: 14px;
        }

        .cart-table td {
            padding: 18px 15px;
            border-bottom: 1px solid #e5e7eb;
            vertical-align: middle;
        }

        .food-image {
            width: 75px;
            height: 75px;
            object-fit: cover;
            border-radius: 12px;
        }

        .food-name {
            font-weight: 600;
            color: #1e293b;
        }

        .price {
            font-weight: 500;
        }

        .item-total {
            color: #2196F3;
            font-weight: 700;
        }


        /* ================================================= */
        /* FOODPANDA STYLE QUANTITY SECTION                  */
        /* ================================================= */

        .food-action {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 7px;
        }


        /* Quantity outer box */

        .quantity-box {
            display: inline-flex;
            align-items: center;

            height: 38px;

            border: 1px solid #d9d9d9;
            border-radius: 20px;

            background: #ffffff;

            overflow: hidden;

            box-shadow: 0 2px 6px rgba(0,0,0,0.06);
        }


        /* Forms inside quantity */

        .quantity-box form {
            margin: 0;
            padding: 0;
        }


        /* Plus and Minus buttons */

        .qty-minus,
        .qty-plus {

            width: 38px;
            height: 38px;

            border: none;

            background: white;

            font-size: 21px;
            font-weight: 600;

            cursor: pointer;

            display: flex;
            align-items: center;
            justify-content: center;

            transition: 0.2s;
        }


        /* Minus */

        .qty-minus {
            color: #2196F3;
        }

        .qty-minus:hover {
            background: #e3f2fd;
        }


        /* Plus */

        .qty-plus {
            color: #2196F3;
        }

        .qty-plus:hover {
            background: #e3f2fd;
        }


        /* Quantity number */

        .qty-number {

            min-width: 32px;

            text-align: center;

            font-size: 14px;
            font-weight: 600;

            color: #222;
        }


        /* Remove button */

        .remove-form {
            margin: 0;
        }

        .remove-item {

            border: none;

            background: transparent;

            color: #777;

            font-size: 12px;
            font-weight: 500;

            cursor: pointer;

            padding: 2px 5px;

            transition: 0.2s;
        }

        .remove-item:hover {

            color: #e53935;

            text-decoration: underline;
        }


        /* ================= EMPTY CART ================= */

        .empty-cart {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-cart h2 {
            margin-bottom: 8px;
            color: #334155;
        }

        .empty-cart p {
            color: #64748b;
            margin-bottom: 25px;
        }


        /* ================= SUMMARY ================= */

        .summary {
            background: white;
            border-radius: 15px;
            padding: 28px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            position: sticky;
            top: 20px;
        }

        .summary h2 {
            margin-top: 0;
            margin-bottom: 25px;
            font-size: 23px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin: 15px 0;
            color: #64748b;
        }

        .summary-row span:last-child {
            color: #1e293b;
            font-weight: 500;
        }

        .summary hr {
            border: none;
            border-top: 1px solid #e5e7eb;
            margin: 20px 0;
        }

        .grand-total {
            display: flex;
            justify-content: space-between;
            font-size: 20px;
            font-weight: 700;
            color: #172554;
        }

        .grand-total span:last-child {
            color: #2196F3;
        }


        /* ================= BUTTONS ================= */

        .button-group {
            margin-top: 25px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .continue-btn,
        .checkout-btn {
            display: block;
            text-align: center;
            text-decoration: none;
            padding: 13px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: 0.2s;
        }

        .continue-btn {
            background: #e3f2fd;
            color: #1976d2;
        }

        .continue-btn:hover {
            background: #bbdefb;
        }

        .checkout-btn {
            background: #2196F3;
            color: white;
            box-shadow: 0 5px 15px rgba(33,150,243,0.25);
        }

        .checkout-btn:hover {
            background: #1976d2;
            transform: translateY(-1px);
        }


        /* ================= OFFER ================= */

        .offer {
            margin-top: 30px;
            padding: 18px;
            background: #e8f5e9;
            border-left: 4px solid #43a047;
            border-radius: 8px;
        }

        .offer strong {
            color: #2e7d32;
        }

        .offer p {
            margin: 5px 0 0;
            color: #4b5563;
            font-size: 13px;
        }


        /* ================= FOOTER ================= */

        footer {
            margin-top: 30px;
            background: #172554;
            color: white;
            padding: 45px 70px 20px;
        }

        .footer-container {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 40px;
        }

        .footer-box h3 {
            margin-top: 0;
            margin-bottom: 15px;
        }

        .footer-box p {
            color: #cbd5e1;
            line-height: 1.7;
            font-size: 14px;
        }

        .footer-box a {
            display: block;
            color: #cbd5e1;
            text-decoration: none;
            margin: 8px 0;
            font-size: 14px;
        }

        .footer-box a:hover {
            color: white;
        }

        .copyright {
            text-align: center;
            color: #94a3b8;
            margin-top: 30px;
            font-size: 13px;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 900px) {

            .cart-container {
                grid-template-columns: 1fr;
            }

            .summary {
                position: static;
            }

            .cart-hero {
                padding: 35px;
            }

            .cart-section {
                padding: 35px;
            }

            .navbar {
                padding: 18px 25px;
            }
        }


        @media (max-width: 650px) {

            .nav-links {
                gap: 10px;
                flex-wrap: wrap;
            }

            .hero-image {
                display: none;
            }

            .hero-text h1 {
                font-size: 32px;
            }

            .cart-section {
                padding: 25px 15px;
            }

            footer {
                padding: 35px 25px 20px;
            }

            .footer-container {
                grid-template-columns: 1fr;
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
            <a href="CartServlet" class="active">
                My Cart
            </a>
        </li>

        <li>
            <a href="OrderHistoryServlet">
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
               class="logout-btn">
                Logout
            </a>
        </li>

    </ul>

</nav>


<!-- ================= HERO ================= -->

<section class="cart-hero">

    <div class="hero-text">

        <span class="tagline">
            Shopping Cart
        </span>

        <h1>
            Your Cart
        </h1>

        <p>
            Review your selected meals and place your order.
        </p>

    </div>


    <div class="hero-image">

        <img
            src="https://images.pexels.com/photos/5638732/pexels-photo-5638732.jpeg"
            alt="Food Cart">

    </div>

</section>


<!-- ================= CART ================= -->

<section class="cart-section">

    <h2 class="cart-title">
        Your Selected Items
    </h2>


    <div class="cart-container">


        <!-- ================= CART ITEMS ================= -->

        <div class="cart-table-box">

            <%

                if (cartList != null &&
                    !cartList.isEmpty()) {

            %>


            <table class="cart-table">

                <thead>

                    <tr>

                        <th>
                            Image
                        </th>

                        <th>
                            Food
                        </th>

                        <th>
                            Price
                        </th>

                        <th>
                            Quantity
                        </th>

                        <th>
                            Total
                        </th>

                    </tr>

                </thead>


                <tbody>


                <%

                    for (Cart cart : cartList) {

                        double itemTotal =
                                cart.getPrice()
                                * cart.getQuantity();

                %>


                    <tr>


                        <!-- FOOD IMAGE -->

                        <td>

                            <img
                                src="<%=cart.getImageUrl()%>"
                                alt="<%=cart.getFoodName()%>"
                                class="food-image">

                        </td>


                        <!-- FOOD NAME -->

                        <td class="food-name">

                            <%=cart.getFoodName()%>

                        </td>


                        <!-- PRICE -->

                        <td class="price">

                            ৳<%=String.format(
                                "%.2f",
                                cart.getPrice())%>

                        </td>


                        <!-- QUANTITY -->

                        <td>

                            <div class="food-action">


                                <!-- QUANTITY BOX -->

                                <div class="quantity-box">


                                    <!-- MINUS -->

                                    <form
                                        action="CartServlet"
                                        method="post">

                                        <input
                                            type="hidden"
                                            name="action"
                                            value="decrease">

                                        <input
                                            type="hidden"
                                            name="cartId"
                                            value="<%=cart.getCartId()%>">

                                        <button
                                            type="submit"
                                            class="qty-minus">

                                            −

                                        </button>

                                    </form>


                                    <!-- NUMBER -->

                                    <span class="qty-number">

                                        <%=cart.getQuantity()%>

                                    </span>


                                    <!-- PLUS -->

                                    <form
                                        action="CartServlet"
                                        method="post">

                                        <input
                                            type="hidden"
                                            name="action"
                                            value="increase">

                                        <input
                                            type="hidden"
                                            name="cartId"
                                            value="<%=cart.getCartId()%>">

                                        <button
                                            type="submit"
                                            class="qty-plus">

                                            +

                                        </button>

                                    </form>


                                </div>


                                <!-- REMOVE -->

                                <form
                                    action="CartServlet"
                                    method="post"
                                    class="remove-form">

                                    <input
                                        type="hidden"
                                        name="action"
                                        value="remove">

                                    <input
                                        type="hidden"
                                        name="cartId"
                                        value="<%=cart.getCartId()%>">

                                    <button
                                        type="submit"
                                        class="remove-item">

                                        Remove

                                    </button>

                                </form>


                            </div>

                        </td>


                        <!-- ITEM TOTAL -->

                        <td class="item-total">

                            ৳<%=String.format(
                                "%.2f",
                                itemTotal)%>

                        </td>


                    </tr>


                <%

                    }

                %>


                </tbody>

            </table>


            <%

                } else {

            %>


            <!-- ================= EMPTY CART ================= -->

            <div class="empty-cart">

                <h2>
                    Your Cart is Empty
                </h2>

                <p>
                    You haven't added any food yet.
                </p>

                <a
                    href="MenuServlet"
                    class="checkout-btn">

                    Browse Menu

                </a>

            </div>


            <%

                }

            %>

        </div>


        <!-- ================= ORDER SUMMARY ================= -->

        <div class="summary">

            <h2>
                Order Summary
            </h2>


            <!-- SUBTOTAL -->

            <div class="summary-row">

                <span>
                    Subtotal
                </span>

                <span>

                    ৳<%=String.format(
                        "%.2f",
                        subtotal)%>

                </span>

            </div>


            <!-- DELIVERY -->

            <div class="summary-row">

                <span>
                    Delivery Charge
                </span>

                <span>

                    <%

                        if (deliveryCharge == 0) {

                    %>

                        FREE

                    <%

                        } else {

                    %>

                        ৳<%=String.format(
                            "%.2f",
                            deliveryCharge)%>

                    <%

                        }

                    %>

                </span>

            </div>


            <!-- VAT -->

            <div class="summary-row">

                <span>
                    VAT (5%)
                </span>

                <span>

                    ৳<%=String.format(
                        "%.2f",
                        vat)%>

                </span>

            </div>


            <hr>


            <!-- GRAND TOTAL -->

            <div class="grand-total">

                <span>
                    Grand Total
                </span>

                <span>

                    ৳<%=String.format(
                        "%.2f",
                        grandTotal)%>

                </span>

            </div>


            <%

                if (cartList != null &&
                    !cartList.isEmpty()) {

            %>


            <div class="button-group">


                <!-- CONTINUE SHOPPING -->

                <a
                    href="MenuServlet"
                    class="continue-btn">

                    Continue Shopping

                </a>


                <!-- CHECKOUT -->

                <a
                    href="CheckoutServlet"
                    class="checkout-btn">

                    Proceed to Place Order

                </a>


            </div>


            <%

                }

            %>


            <!-- OFFER -->

            <div class="offer">

                <strong>
                    Free Delivery
                </strong>

                <p>
                    Spend ৳2000 or more and enjoy
                    free delivery.
                </p>

            </div>

        </div>

    </div>

</section>


<!-- ================= FOOTER ================= -->

<footer>

    <div class="footer-container">


        <!-- FOOD EXPRESS -->

        <div class="footer-box">

            <h3>
                FoodExpress
            </h3>

            <p>
                Delicious food, fast delivery and a
                premium online food ordering experience.
            </p>

        </div>


        <!-- QUICK LINKS -->

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

            <a href="OrderHistoryServlet">
                My Orders
            </a>

        </div>


        <!-- CONTACT -->

        <div class="footer-box">

            <h3>
                Contact Us
            </h3>

            <p>
                Email: info@foodexpress.com
            </p>

            <p>
                Phone: +880 1700-123456
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