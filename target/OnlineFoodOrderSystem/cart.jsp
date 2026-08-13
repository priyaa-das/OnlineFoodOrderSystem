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

    List<Cart> cartList = (List<Cart>) request.getAttribute("cartList");

    double subtotal = 0;
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

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <div class="logo">

        FoodExpress

    </div>

    <ul class="nav-links">

        <li><a href="userHome.jsp">Dashboard</a></li>

        <li><a href="MenuServlet">Menu</a></li>

        <li><a href="CartServlet" class="active">My Cart</a></li>

        <li><a href="orderHistory.jsp">My Orders</a></li>

        <li><a href="profile.jsp">Profile</a></li>

        <li><a href="LogoutServlet" class="login-btn">Logout</a></li>

    </ul>

</nav>

<!-- ================= HERO ================= -->

<section class="dashboard-hero">

    <div class="dashboard-left">

        <span class="tagline">

            Shopping Cart

        </span>

        <h1>

            My Cart

        </h1>

        <p>

            Review your selected meals before checkout.

        </p>

    </div>

    <div class="dashboard-right">

        <img src="https://images.pexels.com/photos/5638732/pexels-photo-5638732.jpeg"
             alt="Cart">

    </div>

</section>

<!-- ================= CART TABLE ================= -->

<section class="dashboard">

    <h2>Cart Items</h2>

    <table class="order-table">

        <tr>

            <th>Image</th>
            <th>Food</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>

        </tr>
        <%
if(cartList != null && !cartList.isEmpty()){

    for(Cart cart : cartList){

        subtotal += cart.getTotalPrice();
%>

<tr>

    <td>

        <img src="<%=cart.getImageUrl()%>"
             alt="<%=cart.getFoodName()%>"
             width="80"
             height="80"
             style="border-radius:10px;">

    </td>

    <td>

        <%=cart.getFoodName()%>

    </td>

    <td>

        ৳<%=cart.getPrice()%>

    </td>

    <td>

        <%=cart.getQuantity()%>

    </td>

    <td>

        ৳<%=cart.getTotalPrice()%>

    </td>

</tr>

<%

    }

}else{

%>

<tr>

    <td colspan="5"
        style="text-align:center;padding:25px;">

        <h3>Your Cart is Empty</h3>

        <p>Add some delicious food from the menu.</p>

    </td>

</tr>

<%

}

%>

    </table>
<%
    double deliveryCharge = 60;
    double vat = subtotal * 0.05;
    double grandTotal = subtotal + deliveryCharge + vat;
%>

<!-- ================= ORDER SUMMARY ================= -->

<div class="cart-summary">

    <h2>

        Order Summary

    </h2>

    <div class="summary-row">

        <span>Subtotal</span>

        <span>৳<%=String.format("%.2f", subtotal)%></span>

    </div>

    <div class="summary-row">

        <span>Delivery Charge</span>

        <span>৳<%=String.format("%.2f", deliveryCharge)%></span>

    </div>

    <div class="summary-row">

        <span>VAT (5%)</span>

        <span>৳<%=String.format("%.2f", vat)%></span>

    </div>

    <hr>

    <div class="summary-row total">

        <span><strong>Grand Total</strong></span>

        <span><strong>৳<%=String.format("%.2f", grandTotal)%></strong></span>

    </div>

    <div class="cart-buttons">

        <a href="MenuServlet"
           class="secondary-btn">

            Continue Shopping

        </a>

        <a href="<%=request.getContextPath()%>/CheckoutServlet"
           class="primary-btn">

            Proceed to Checkout

        </a>

    </div>

</div>

</section>

<!-- ================= SPECIAL OFFER ================= -->

<section class="offers">

    <div class="offer-box">

        <h2>

            🚚 Free Delivery Offer

        </h2>

        <p>

            Spend more than <strong>৳2000</strong>
            and enjoy <strong>FREE Delivery</strong>.

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

                Delicious food, fast delivery and a premium online
                food ordering experience.

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