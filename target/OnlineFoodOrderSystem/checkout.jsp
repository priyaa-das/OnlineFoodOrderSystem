<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.foodexpress.model.User"%>

<%
    User user =
            (User) session.getAttribute("user");

    if (user == null) {

        response.sendRedirect("login.jsp");

        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Checkout | FoodExpress</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #222;
        }

        .navbar {
            background: white;
            padding: 18px 7%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,.08);
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
            color: #4f8cff;
        }

        .back {
            text-decoration: none;
            color: #555;
            font-weight: 600;
        }

        .container {
            width: 90%;
            max-width: 900px;
            margin: 40px auto;
        }

        .title {
            margin-bottom: 25px;
        }

        .title h1 {
            margin-bottom: 5px;
        }

        .title p {
            color: #777;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 18px;
            box-shadow: 0 5px 20px rgba(0,0,0,.07);
            margin-bottom: 25px;
        }

        .card h2 {
            margin-top: 0;
            color: #333;
        }

        .method-container {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }

        .method {
            flex: 1;
            border: 2px solid #ddd;
            border-radius: 15px;
            padding: 25px;
            cursor: pointer;
            transition: .2s;
        }

        .method:hover {
            border-color: #4f8cff;
        }

        .method input {
            margin-right: 10px;
        }

        .method-title {
            font-size: 18px;
            font-weight: bold;
        }

        .method-desc {
            color: #777;
            margin-top: 8px;
            font-size: 14px;
        }

        label {
            display: block;
            margin-top: 18px;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 13px;
            border: 1px solid #ddd;
            border-radius: 9px;
            font-size: 15px;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .delivery-box,
        .pickup-box {
            display: none;
            margin-top: 20px;
            padding: 20px;
            background: #f8faff;
            border-radius: 12px;
        }

        .info {
            background: #eef5ff;
            padding: 15px;
            border-radius: 10px;
            margin-top: 15px;
            color: #3f5f91;
        }

        .payment-option {
            margin-top: 12px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }

        .payment-option input {
            width: auto;
            margin-right: 8px;
        }

        .summary {
            background: #f8f9fc;
            padding: 20px;
            border-radius: 12px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
        }

        .total {
            border-top: 1px solid #ddd;
            margin-top: 10px;
            padding-top: 15px;
            font-size: 20px;
            font-weight: bold;
        }

        .place-btn {
            width: 100%;
            padding: 16px;
            border: none;
            background: #4f8cff;
            color: white;
            font-size: 17px;
            font-weight: bold;
            border-radius: 10px;
            cursor: pointer;
            margin-top: 20px;
        }

        .place-btn:hover {
            background: #3978ed;
        }

        @media(max-width:700px) {

            .method-container {
                flex-direction: column;
            }

            .container {
                width: 94%;
            }
        }

    </style>

</head>


<body>


<!-- ==========================================
     NAVBAR
========================================== -->

<div class="navbar">

    <div class="logo">
        FoodExpress
    </div>

    <a
        href="CartServlet"
        class="back">
        ← Back to Cart
    </a>

</div>



<div class="container">


    <!-- ==========================================
         TITLE
    ========================================== -->

    <div class="title">

        <h1>
            Checkout
        </h1>

        <p>
            Choose how you want to receive your order.
        </p>

    </div>



    <form
        action="PlaceOrderServlet"
        method="post"
        onsubmit="return validateCheckout();">



        <!-- ==========================================
             CONTACT INFORMATION
        ========================================== -->

        <div class="card">

            <h2>
                Contact Information
            </h2>


            <label>
                Phone Number
            </label>

            <input
                type="text"
                name="phone"
                placeholder="Enter your phone number"
                value="<%= user.getPhone() == null ? "" : user.getPhone() %>"
                required>


        </div>



        <!-- ==========================================
             DELIVERY METHOD
        ========================================== -->

        <div class="card">

            <h2>
                Receive Your Order
            </h2>


            <div class="method-container">


                <!-- PICKUP -->

                <label class="method">

                    <input
                        type="radio"
                        name="deliveryMethod"
                        value="Pickup"
                        onclick="showPickup()">

                    <span class="method-title">
                        Pickup
                    </span>

                    <div class="method-desc">

                        Pick up your order from our cafeteria.

                    </div>

                </label>



                <!-- DELIVERY -->

                <label class="method">

                    <input
                        type="radio"
                        name="deliveryMethod"
                        value="Delivery"
                        onclick="showDelivery()">

                    <span class="method-title">
                        Home Delivery
                    </span>

                    <div class="method-desc">

                        Get your food delivered to your location.

                    </div>

                </label>


            </div>



            <!-- ======================================
                 PICKUP SECTION
            ======================================= -->

            <div
                id="pickupBox"
                class="pickup-box">


                <label>
                    Select Pickup Time
                </label>


                <select
                    name="pickupTime"
                    id="pickupTime">

                    <option value="">
                        Select a time
                    </option>

                    <option value="12:00 PM - 12:30 PM">
                        12:00 PM - 12:30 PM
                    </option>

                    <option value="12:30 PM - 1:00 PM">
                        12:30 PM - 1:00 PM
                    </option>

                    <option value="1:00 PM - 1:30 PM">
                        1:00 PM - 1:30 PM
                    </option>

                    <option value="1:30 PM - 2:00 PM">
                        1:30 PM - 2:00 PM
                    </option>

                    <option value="5:00 PM - 5:30 PM">
                        5:00 PM - 5:30 PM
                    </option>

                    <option value="5:30 PM - 6:00 PM">
                        5:30 PM - 6:00 PM
                    </option>

                    <option value="6:00 PM - 6:30 PM">
                        6:00 PM - 6:30 PM
                    </option>

                    <option value="6:30 PM - 7:00 PM">
                        6:30 PM - 7:00 PM
                    </option>

                    <option value="7:00 PM - 7:30 PM">
                        7:00 PM - 7:30 PM
                    </option>

                </select>


                <div class="info">

                    Your order will be prepared before the selected pickup time.

                </div>


            </div>



            <!-- ======================================
                 DELIVERY SECTION
            ======================================= -->

            <div
                id="deliveryBox"
                class="delivery-box">


                <label>
                    Delivery Address
                </label>


                <textarea
                    name="address"
                    id="address"
                    placeholder="Enter your full delivery address"><%= user.getAddress() == null ? "" : user.getAddress() %></textarea>


                <div class="info">

                    Delivery time depends on your location.
                    Nearby locations usually receive orders faster.

                </div>


            </div>


        </div>



        <!-- ==========================================
             PAYMENT
        ========================================== -->

        <div class="card">

            <h2>
                Payment Method
            </h2>


            <label class="payment-option">

                <input
                    type="radio"
                    name="paymentMethod"
                    value="Cash on Delivery"
                    required>

                Cash on Delivery

            </label>


            <label class="payment-option">

                <input
                    type="radio"
                    name="paymentMethod"
                    value="Online Payment">

                Online Payment

            </label>


        </div>



        <!-- ==========================================
             ORDER SUMMARY
        ========================================== -->

        <div class="card">

            <h2>
                Order Summary
            </h2>


            <div class="summary">

                <div class="summary-row">

                    <span>
                        Your cart
                    </span>

                    <span>
                        Items
                    </span>

                </div>


                <div class="summary-row">

                    <span>
                        Delivery
                    </span>

                    <span>
                        Calculated at order
                    </span>

                </div>


                <div class="summary-row">

                    <span>
                        VAT
                    </span>

                    <span>
                        5%
                    </span>

                </div>


                <div class="summary-row total">

                    <span>
                        Total
                    </span>

                    <span>
                        Calculated at checkout
                    </span>

                </div>

            </div>


            <button
                type="submit"
                class="place-btn">

                Place Order

            </button>


        </div>


    </form>


</div>



<script>


    // ==========================================
    // SHOW PICKUP
    // ==========================================

    function showPickup() {

        document.getElementById(
                "pickupBox"
        ).style.display = "block";


        document.getElementById(
                "deliveryBox"
        ).style.display = "none";


        document.getElementById(
                "address"
        ).required = false;


        document.getElementById(
                "pickupTime"
        ).required = true;
    }



    // ==========================================
    // SHOW DELIVERY
    // ==========================================

    function showDelivery() {

        document.getElementById(
                "deliveryBox"
        ).style.display = "block";


        document.getElementById(
                "pickupBox"
        ).style.display = "none";


        document.getElementById(
                "address"
        ).required = true;


        document.getElementById(
                "pickupTime"
        ).required = false;
    }



    // ==========================================
    // VALIDATION
    // ==========================================

    function validateCheckout() {


        const method =
                document.querySelector(
                        'input[name="deliveryMethod"]:checked'
                );


        if (!method) {

            alert(
                    "Please select Pickup or Home Delivery."
            );

            return false;
        }


        if (method.value === "Pickup") {

            const pickup =
                    document.getElementById(
                            "pickupTime"
                    ).value;


            if (!pickup) {

                alert(
                        "Please select a pickup time."
                );

                return false;
            }
        }


        if (method.value === "Delivery") {

            const address =
                    document.getElementById(
                            "address"
                    ).value.trim();


            if (!address) {

                alert(
                        "Please enter your delivery address."
                );

                return false;
            }
        }


        return true;
    }

</script>


</body>

</html>