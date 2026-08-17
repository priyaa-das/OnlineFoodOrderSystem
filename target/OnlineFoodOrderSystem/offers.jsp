<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.foodexpress.model.User"%>
<%@page import="com.foodexpress.model.Cart"%>
<%@page import="com.foodexpress.dao.CartDAO"%>

<%
    // =====================================================
    // LOGIN CHECK
    // =====================================================

    User user =
            (User) session.getAttribute("user");

    if (user == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    // =====================================================
    // GET CART
    // =====================================================

    CartDAO cartDAO =
            new CartDAO();

    List<Cart> cartList =
            cartDAO.getCartItems(
                    user.getUserId()
            );


    // =====================================================
    // CALCULATE SUBTOTAL
    // =====================================================

    double subtotal = 0;

    for (Cart cart : cartList) {

        subtotal +=
                cart.getPrice()
                * cart.getQuantity();
    }


    // =====================================================
    // CLAIMED OFFER
    // =====================================================

    String claimedOffer =
            (String) session.getAttribute(
                    "claimedOffer"
            );


    String message =
            (String) session.getAttribute(
                    "offerMessage"
            );

    session.removeAttribute(
            "offerMessage"
    );


    // =====================================================
    // ELIGIBILITY
    // =====================================================

    boolean food200Eligible =
            subtotal >= 1500;

    boolean freeDeliveryEligible =
            subtotal >= 2000;

    boolean food10Eligible =
            subtotal >= 2500;

%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Offers | FoodExpress</title>

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

        .navbar {
            background: #2196F3;
            padding: 18px 55px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            color: white;
            font-size: 25px;
            font-weight: 700;
        }

        .nav-links {
            display: flex;
            gap: 25px;
            list-style: none;
            margin: 0;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
        }

        .hero {
            margin: 35px 55px;
            padding: 45px;
            text-align: center;

            border-radius: 20px;

            background:
                linear-gradient(
                    135deg,
                    #2196F3,
                    #64B5F6
                );

            color: white;
        }

        .hero h1 {
            font-size: 35px;
            margin: 0 0 10px;
        }

        .cart-total {
            background: white;
            color: #1976D2;

            display: inline-block;

            padding: 10px 20px;

            border-radius: 25px;

            font-weight: 600;

            margin-top: 10px;
        }

        .message {
            max-width: 750px;

            margin: 20px auto;

            padding: 15px;

            text-align: center;

            background: #dcfce7;

            color: #166534;

            border-radius: 10px;
        }

        .offers {
            padding: 10px 55px 50px;

            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(280px, 1fr));

            gap: 25px;
        }

        .offer-card {
            background: white;

            padding: 30px;

            text-align: center;

            border-radius: 18px;

            box-shadow:
                0 5px 20px rgba(0,0,0,0.08);
        }

        .offer-icon {
            font-size: 48px;
        }

        .offer-card h2 {
            color: #1976D2;
        }

        .offer-card p {
            color: #64748b;
            line-height: 1.6;
        }

        .code {
            display: inline-block;

            padding: 8px 15px;

            background: #eff6ff;

            border: 1px dashed #2196F3;

            color: #1976D2;

            border-radius: 7px;

            font-weight: 600;
        }

        .claim-btn {
            display: block;

            margin-top: 20px;

            padding: 12px;

            background: #2196F3;

            color: white;

            text-decoration: none;

            border-radius: 8px;

            font-weight: 600;
        }

        .claim-btn:hover {
            background: #1976D2;
        }

        .claimed {
            display: block;

            margin-top: 20px;

            padding: 12px;

            background: #dcfce7;

            color: #166534;

            border-radius: 8px;

            font-weight: 600;
        }

        .locked {
            display: block;

            margin-top: 20px;

            padding: 12px;

            background: #f1f5f9;

            color: #64748b;

            border-radius: 8px;
        }

        .back-btn {
            display: block;

            width: 200px;

            margin: 0 auto 50px;

            padding: 12px;

            text-align: center;

            background: #334155;

            color: white;

            text-decoration: none;

            border-radius: 8px;
        }

    </style>

</head>

<body>


<!-- NAVBAR -->

<nav class="navbar">

    <div class="logo">
        FoodExpress
    </div>

    <ul class="nav-links">

        <li>
            <a href="userHome.jsp">
                Home
            </a>
        </li>

        <li>
            <a href="MenuServlet">
                Menu
            </a>
        </li>

        <li>
            <a href="CartServlet">
                Cart
            </a>
        </li>

        <li>
            <a href="OrderHistoryServlet">
                Orders
            </a>
        </li>

        <li>
            <a href="LogoutServlet">
                Logout
            </a>
        </li>

    </ul>

</nav>


<!-- HERO -->

<section class="hero">

    <h1>
        Exclusive Offers
    </h1>

    <p>
        Hello <strong><%=user.getFullName()%></strong>,
        offers are based on your current cart.
    </p>

    <div class="cart-total">

        Current Cart:
        ৳<%=String.format("%.2f", subtotal)%>

    </div>

</section>


<!-- MESSAGE -->

<%
    if (message != null) {
%>

<div class="message">

    <%=message%>

</div>

<%
    }
%>


<!-- OFFERS -->

<section class="offers">


    <!-- FOOD200 -->

    <div class="offer-card">

        <div class="offer-icon">
            🎁
        </div>

        <h2>
            ৳200 OFF
        </h2>

        <p>
            Get ৳200 discount on orders
            above ৳1500.
        </p>

        <div class="code">
            FOOD200
        </div>

        <%
            if ("FOOD200".equals(claimedOffer)) {
        %>

            <span class="claimed">
                ✓ Claimed
            </span>

        <%
            } else if (food200Eligible) {
        %>

            <a href="ClaimOfferServlet?offer=FOOD200"
               class="claim-btn">

                Claim ৳200 OFF

            </a>

        <%
            } else {
        %>

            <span class="locked">

                🔒 Add ৳<%=
                    String.format(
                        "%.2f",
                        1500 - subtotal
                    )
                %>
                more to unlock

            </span>

        <%
            }
        %>

    </div>


    <!-- FREE DELIVERY -->

    <div class="offer-card">

        <div class="offer-icon">
            🚚
        </div>

        <h2>
            Free Delivery
        </h2>

        <p>
            Get free delivery on orders
            above ৳2000.
        </p>

        <div class="code">
            FREEDELIVERY
        </div>

        <%
            if ("FREEDELIVERY".equals(claimedOffer)) {
        %>

            <span class="claimed">
                ✓ Claimed
            </span>

        <%
            } else if (freeDeliveryEligible) {
        %>

            <a href="ClaimOfferServlet?offer=FREEDELIVERY"
               class="claim-btn">

                Claim Free Delivery

            </a>

        <%
            } else {
        %>

            <span class="locked">

                🔒 Add ৳<%=
                    String.format(
                        "%.2f",
                        2000 - subtotal
                    )
                %>
                more to unlock

            </span>

        <%
            }
        %>

    </div>


    <!-- FOOD10 -->

    <div class="offer-card">

        <div class="offer-icon">
            🍔
        </div>

        <h2>
            10% OFF
        </h2>

        <p>
            Get 10% discount on orders
            above ৳2500.
        </p>

        <div class="code">
            FOOD10
        </div>

        <%
            if ("FOOD10".equals(claimedOffer)) {
        %>

            <span class="claimed">
                ✓ Claimed
            </span>

        <%
            } else if (food10Eligible) {
        %>

            <a href="ClaimOfferServlet?offer=FOOD10"
               class="claim-btn">

                Claim 10% OFF

            </a>

        <%
            } else {
        %>

            <span class="locked">

                🔒 Add ৳<%=
                    String.format(
                        "%.2f",
                        2500 - subtotal
                    )
                %>
                more to unlock

            </span>

        <%
            }
        %>

    </div>


</section>


<a href="userHome.jsp"
   class="back-btn">

    ← Back to Dashboard

</a>


</body>

</html>