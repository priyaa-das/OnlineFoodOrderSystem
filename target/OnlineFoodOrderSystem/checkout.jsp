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
    // CART
    // =====================================================

    CartDAO cartDAO =
            new CartDAO();

    List<Cart> cartList =
            cartDAO.getCartItems(
                    user.getUserId()
            );


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


    double discount = 0;

    double deliveryCharge = 60;

    String offerText =
            "No offer applied";


    // =====================================================
    // APPLY OFFER
    // =====================================================

    if ("FOOD200".equals(claimedOffer)
            && subtotal >= 1500) {

        discount = 200;

        offerText =
                "FOOD200 - ৳200 OFF";
    }

    else if ("FREEDELIVERY".equals(
            claimedOffer)
            && subtotal >= 2000) {

        deliveryCharge = 0;

        offerText =
                "FREEDELIVERY";
    }

    else if ("FOOD10".equals(
            claimedOffer)
            && subtotal >= 2500) {

        discount =
                subtotal * 0.10;

        offerText =
                "FOOD10 - 10% OFF";
    }


    // =====================================================
    // AUTOMATIC FREE DELIVERY
    // =====================================================

    if (subtotal >= 2000) {

        deliveryCharge = 0;
    }


    double discountedSubtotal =
            subtotal - discount;

    if (discountedSubtotal < 0) {
        discountedSubtotal = 0;
    }


    double vat =
            discountedSubtotal * 0.05;


    double grandTotal =
            discountedSubtotal
            + deliveryCharge
            + vat;

%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Checkout | FoodExpress</title>

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

        .navbar a {

            color: white;

            text-decoration: none;
        }

        .container {

            max-width: 1100px;

            margin: 40px auto;

            padding: 20px;

            display: grid;

            grid-template-columns:
                1.3fr 0.7fr;

            gap: 30px;
        }

        .box {

            background: white;

            padding: 30px;

            border-radius: 15px;

            box-shadow:
                0 5px 20px rgba(0,0,0,0.08);
        }

        h1 {

            margin-top: 0;
        }

        label {

            display: block;

            margin-top: 18px;

            margin-bottom: 6px;

            font-weight: 500;
        }

        input,
        textarea,
        select {

            width: 100%;

            padding: 12px;

            border: 1px solid #cbd5e1;

            border-radius: 7px;

            font-family: inherit;
        }

        textarea {

            min-height: 100px;

            resize: vertical;
        }

        .summary-row {

            display: flex;

            justify-content: space-between;

            padding: 10px 0;

            color: #475569;
        }

        .discount {

            color: #16a34a;

            font-weight: 600;
        }

        .offer {

            padding: 12px;

            background: #eff6ff;

            color: #1976D2;

            border-radius: 8px;

            margin-bottom: 15px;

            font-size: 14px;
        }

        hr {

            border: none;

            border-top: 1px solid #e2e8f0;

            margin: 15px 0;
        }

        .total {

            font-size: 20px;

            color: #1976D2;

            font-weight: 700;
        }

        button {

            width: 100%;

            margin-top: 25px;

            padding: 13px;

            border: none;

            border-radius: 8px;

            background: #2196F3;

            color: white;

            font-size: 16px;

            font-weight: 600;

            cursor: pointer;
        }

        button:hover {

            background: #1976D2;
        }

        .back {

            display: block;

            margin-top: 15px;

            text-align: center;

            color: #1976D2;

            text-decoration: none;
        }

        @media(max-width:800px) {

            .container {

                grid-template-columns: 1fr;
            }

            .navbar {

                padding: 15px 20px;
            }
        }

    </style>

</head>

<body>


<!-- NAVBAR -->

<nav class="navbar">

    <div class="logo">
        FoodExpress
    </div>

    <a href="CartServlet">
        ← Back to Cart
    </a>

</nav>


<div class="container">


    <!-- =========================================
         CUSTOMER INFORMATION
         ========================================= -->

    <div class="box">

        <h1>
            Checkout
        </h1>

        <p>
            Complete your information to place
            your FoodExpress order.
        </p>


        <form action="PlaceOrderServlet"
              method="post">


            <label>
                Phone Number
            </label>

            <input type="text"
                   name="phone"
                   value="<%=user.getPhone()%>"
                   required>


            <label>
                Delivery Address
            </label>

            <textarea name="address"
                      placeholder="Enter your delivery address"
                      required></textarea>


            <label>
                Payment Method
            </label>

            <select name="paymentMethod"
                    required>

                <option value="">
                    Select Payment Method
                </option>

                <option value="Cash on Delivery">
                    Cash on Delivery
                </option>

                <option value="Online Payment">
                    Online Payment
                </option>

            </select>


            <button type="submit">

                Place Order -
                ৳<%=String.format(
                    "%.2f",
                    grandTotal
                )%>

            </button>

        </form>

    </div>


    <!-- =========================================
         ORDER SUMMARY
         ========================================= -->

    <div class="box">

        <h2>
            Order Summary
        </h2>


        <div class="offer">

            <strong>
                Applied Offer:
            </strong>

            <br>

            <%=offerText%>

        </div>


        <div class="summary-row">

            <span>
                Subtotal
            </span>

            <span>
                ৳<%=String.format(
                    "%.2f",
                    subtotal
                )%>
            </span>

        </div>


        <div class="summary-row discount">

            <span>
                Discount
            </span>

            <span>
                - ৳<%=String.format(
                    "%.2f",
                    discount
                )%>
            </span>

        </div>


        <div class="summary-row">

            <span>
                Delivery
            </span>

            <span>

                <%
                    if (deliveryCharge == 0) {
                %>

                    <strong>
                        FREE
                    </strong>

                <%
                    } else {
                %>

                    ৳<%=String.format(
                        "%.2f",
                        deliveryCharge
                    )%>

                <%
                    }
                %>

            </span>

        </div>


        <div class="summary-row">

            <span>
                VAT (5%)
            </span>

            <span>
                ৳<%=String.format(
                    "%.2f",
                    vat
                )%>
            </span>

        </div>


        <hr>


        <div class="summary-row total">

            <span>
                Grand Total
            </span>

            <span>
                ৳<%=String.format(
                    "%.2f",
                    grandTotal
                )%>
            </span>

        </div>


    </div>

</div>

</body>

</html>