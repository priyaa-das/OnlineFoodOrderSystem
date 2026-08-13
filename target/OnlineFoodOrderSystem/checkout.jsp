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

    Double subtotal =
            (Double) request.getAttribute("subtotal");

    Double deliveryCharge =
            (Double) request.getAttribute("deliveryCharge");

    Double vat =
            (Double) request.getAttribute("vat");

    Double grandTotal =
            (Double) request.getAttribute("grandTotal");

    if (subtotal == null) subtotal = 0.0;
    if (deliveryCharge == null) deliveryCharge = 0.0;
    if (vat == null) vat = 0.0;
    if (grandTotal == null) grandTotal = 0.0;
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Checkout | FoodExpress</title>

    <link rel="stylesheet"
          href="css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

    <style>

        .checkout-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
        }

        .checkout-box {
            background: white;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .checkout-box h1 {
            margin-bottom: 30px;
        }

        .checkout-box h2 {
            margin-top: 25px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            font-weight: 500;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
        }

        .payment-option {
            display: block;
            padding: 15px;
            margin-bottom: 12px;
            border: 1px solid #ddd;
            border-radius: 10px;
            cursor: pointer;
        }

        .payment-option:hover {
            background: #f8f8f8;
        }

        .payment-option input {
            margin-right: 10px;
        }

        .summary {
            margin-top: 30px;
            padding: 20px;
            background: #f8f8f8;
            border-radius: 10px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin: 12px 0;
        }

        .grand-total {
            font-size: 20px;
            font-weight: bold;
        }

        .place-order-btn {
            width: 100%;
            padding: 15px;
            margin-top: 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
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
            <a href="LogoutServlet"
               class="login-btn">
                Logout
            </a>
        </li>

    </ul>

</nav>


<!-- ================= CHECKOUT ================= -->

<section class="checkout-container">

    <div class="checkout-box">

        <h1>Checkout</h1>


        <!-- ================= DELIVERY INFORMATION ================= -->

        <h2>Delivery Information</h2>

        <form action="PlaceOrderServlet"
              method="post">

            <div class="form-group">

                <label>Full Name</label>

                <input type="text"
                       value="<%=user.getFullName()%>"
                       readonly>

            </div>


            <div class="form-group">

                <label>Email</label>

                <input type="email"
                       value="<%=user.getEmail()%>"
                       readonly>

            </div>


            <div class="form-group">

                <label>Phone</label>

                <input type="text"
                       name="phone"
                       value="<%=user.getPhone()%>"
                       required>

            </div>


            <div class="form-group">

                <label>Delivery Address</label>

                <textarea name="address"
                          rows="4"
                          required><%=user.getAddress() == null ? "" : user.getAddress()%></textarea>

            </div>


            <!-- ================= PAYMENT ================= -->

            <h2>Payment Method</h2>


            <label class="payment-option">

                <input type="radio"
                       name="paymentMethod"
                       value="Cash on Delivery"
                       required>

                💵 Cash on Delivery

            </label>


            <label class="payment-option">

                <input type="radio"
                       name="paymentMethod"
                       value="Bkash">

                📱 Bkash

            </label>


            <label class="payment-option">

                <input type="radio"
                       name="paymentMethod"
                       value="Nagad">

                📱 Nagad

            </label>


            <label class="payment-option">

                <input type="radio"
                       name="paymentMethod"
                       value="Rocket">

                📱 Rocket

            </label>


            <label class="payment-option">

                <input type="radio"
                       name="paymentMethod"
                       value="Card">

                💳 Card

            </label>


            <!-- ================= CARD INFORMATION ================= -->

            <div id="cardSection"
                 style="display:none; margin-top:20px;">

                <h3>Card Information</h3>

                <div class="form-group">

                    <label>Card Number</label>

                    <input type="text"
                           name="cardNumber"
                           placeholder="Enter card number"
                           maxlength="19">

                </div>


                <div class="form-group">

                    <label>Card Holder Name</label>

                    <input type="text"
                           name="cardHolder"
                           placeholder="Card holder name">

                </div>


                <div class="form-group">

                    <label>Expiry Date</label>

                    <input type="text"
                           name="expiry"
                           placeholder="MM/YY"
                           maxlength="5">

                </div>


                <div class="form-group">

                    <label>CVV</label>

                    <input type="password"
                           name="cvv"
                           placeholder="CVV"
                           maxlength="4">

                </div>

            </div>


            <!-- ================= ORDER SUMMARY ================= -->

            <h2>Order Summary</h2>

            <div class="summary">

                <div class="summary-row">

                    <span>Subtotal</span>

                    <span>
                        ৳<%=String.format("%.2f", subtotal)%>
                    </span>

                </div>


                <div class="summary-row">

                    <span>Delivery Charge</span>

                    <span>
                        ৳<%=String.format("%.2f", deliveryCharge)%>
                    </span>

                </div>


                <div class="summary-row">

                    <span>VAT (5%)</span>

                    <span>
                        ৳<%=String.format("%.2f", vat)%>
                    </span>

                </div>


                <hr>


                <div class="summary-row grand-total">

                    <span>Grand Total</span>

                    <span>
                        ৳<%=String.format("%.2f", grandTotal)%>
                    </span>

                </div>

            </div>


            <button type="submit"
                    class="primary-btn place-order-btn">

                Place Order

            </button>

        </form>

    </div>

</section>


<!-- ================= CARD JAVASCRIPT ================= -->

<script>

    const paymentMethods =
        document.querySelectorAll(
            'input[name="paymentMethod"]'
        );

    const cardSection =
        document.getElementById(
            "cardSection"
        );


    paymentMethods.forEach(function(method) {

        method.addEventListener(
            "change",
            function() {

                if (this.value === "Card") {

                    cardSection.style.display =
                        "block";

                } else {

                    cardSection.style.display =
                        "none";

                }

            }
        );

    });

</script>

</body>

</html>