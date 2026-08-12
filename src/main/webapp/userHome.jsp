<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>User Dashboard | FoodExpress</title>

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
            <a href="userHome.jsp" class="active">
                Dashboard
            </a>
        </li>

        <li>
            <a href="MenuServlet">
                Menu
            </a>
        </li>

        <li>
            <a href="cart.jsp">
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

<!-- ================= HERO ================= -->

<section class="dashboard-hero">

    <div class="dashboard-left">

        <span class="tagline">
            Welcome Back 👋
        </span>

        <h1>
            Hello,
            <%= user.getFullName() %>
        </h1>

        <p>
            Manage your orders, explore delicious meals,
            check your cart and enjoy exclusive FoodExpress
            member offers.
        </p>

        <div class="hero-buttons">

            <a href="MenuServlet"
               class="primary-btn">

                Order Food

            </a>

            <a href="cart.jsp"
               class="secondary-btn">

                View Cart

            </a>

        </div>

    </div>

    <div class="dashboard-right">

        <img src="https://images.pexels.com/photos/67468/pexels-photo-67468.jpeg"
             alt="Food">

    </div>

</section>
        <!-- ================= ACCOUNT OVERVIEW ================= -->

<section class="dashboard">

    <h2>Account Overview</h2>

    <p>Your FoodExpress account summary.</p>

    <div class="dashboard-container">

        <div class="dashboard-card">

            <h3>Total Orders</h3>

            <h1>12</h1>

            <p>Orders placed so far.</p>

        </div>

        <div class="dashboard-card">

            <h3>Cart Items</h3>

            <h1>3</h1>

            <p>Ready for checkout.</p>

        </div>

        <div class="dashboard-card">

            <h3>Reward Points</h3>

            <h1>220</h1>

            <p>Earn more with every order.</p>

        </div>

        <div class="dashboard-card">

            <h3>Membership</h3>

            <h1>Gold</h1>

            <p>Premium customer benefits.</p>

        </div>

    </div>

</section>

<!-- ================= QUICK ACTIONS ================= -->

<section class="dashboard">

    <h2>Quick Actions</h2>

    <div class="dashboard-container">

        <div class="dashboard-card">

            <h3>🍽 Browse Menu</h3>

            <p>
                Explore our delicious food collection.
            </p>

            <a href="MenuServlet"
               class="primary-btn">

                Open Menu

            </a>

        </div>

        <div class="dashboard-card">

            <h3>🛒 My Cart</h3>

            <p>
                Review your selected food items before checkout.
            </p>

            <a href="cart.jsp"
               class="primary-btn">

                View Cart

            </a>

        </div>

        <div class="dashboard-card">

            <h3>📦 My Orders</h3>

            <p>
                Track current orders and previous purchases.
            </p>

            <a href="orderHistory.jsp"
               class="primary-btn">

                View Orders

            </a>

        </div>

        <div class="dashboard-card">

            <h3>👤 My Profile</h3>

            <p>
                Update your personal information.
            </p>

            <a href="profile.jsp"
               class="primary-btn">

                Edit Profile

            </a>

        </div>

    </div>

</section>

<!-- ================= RECOMMENDED FOOD ================= -->

<section class="featured">

    <h2>Recommended For You</h2>

    <p>Popular dishes loved by our customers.</p>

    <div class="food-container">

        <div class="food-card">

            <img src="https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg"
                 alt="Burger">

            <div class="food-info">

                <h3>Classic Beef Burger</h3>

                <span class="price">৳450</span>

                <p>
                    Juicy grilled beef burger with crispy fries.
                </p>

                <a href="MenuServlet"
                   class="primary-btn">

                    Order Now

                </a>

            </div>

        </div>

        <div class="food-card">

            <img src="https://images.pexels.com/photos/825661/pexels-photo-825661.jpeg"
                 alt="Pizza">

            <div class="food-info">

                <h3>Italian Pizza</h3>

                <span class="price">৳850</span>

                <p>
                    Loaded with mozzarella cheese and fresh toppings.
                </p>

                <a href="MenuServlet"
                   class="primary-btn">

                    Order Now

                </a>

            </div>

        </div>

        <div class="food-card">

            <img src="https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg"
                 alt="Pasta">

            <div class="food-info">

                <h3>Chicken Alfredo Pasta</h3>

                <span class="price">৳780</span>

                <p>
                    Creamy Alfredo pasta served with grilled chicken.
                </p>

                <a href="MenuServlet"
                   class="primary-btn">

                    Order Now

                </a>

            </div>

        </div>

    </div>

</section>
<!-- ================= TODAY'S OFFER ================= -->

<section class="offers">

    <div class="offer-box">

        <h2>
            🎉 Exclusive Member Offer
        </h2>

        <p>
            Congratulations! As a logged-in customer,
            you get an extra <strong>20% OFF</strong>
            on orders above <strong>৳1500</strong>.
        </p>

        <a href="MenuServlet"
           class="primary-btn">

            Order Now

        </a>

    </div>

</section>

<!-- ================= RECENT ORDERS ================= -->

<section class="dashboard">

    <h2>Recent Orders</h2>

    <table class="order-table">

        <tr>

            <th>Order ID</th>
            <th>Food Item</th>
            <th>Price</th>
            <th>Status</th>

        </tr>

        <tr>

            <td>#1001</td>
            <td>Chicken Alfredo Pasta</td>
            <td>৳780</td>
            <td><span class="status preparing">Preparing</span></td>

        </tr>

        <tr>

            <td>#1002</td>
            <td>Classic Beef Burger</td>
            <td>৳450</td>
            <td><span class="status delivered">Delivered</span></td>

        </tr>

        <tr>

            <td>#1003</td>
            <td>Italian Pizza</td>
            <td>৳850</td>
            <td><span class="status pending">Pending</span></td>

        </tr>

    </table>

</section>

<!-- ================= NEWSLETTER ================= -->

<section class="newsletter">

    <div class="newsletter-content">

        <h2>Stay Updated</h2>

        <p>
            Subscribe to receive exclusive offers,
            new menu updates and special discounts.
        </p>

        <form>

            <input type="email"
                   placeholder="Enter your email">

            <button type="submit">

                Subscribe

            </button>

        </form>

    </div>

</section>

<!-- ================= FOOTER ================= -->

<footer>

    <div class="footer-container">

        <div class="footer-box">

            <h3>FoodExpress</h3>

            <p>
                Premium Online Food Ordering System
                delivering fresh meals quickly and safely.
            </p>

        </div>

        <div class="footer-box">

            <h3>Quick Links</h3>

            <a href="userHome.jsp">Dashboard</a>
            <a href="MenuServlet">Menu</a>
            <a href="cart.jsp">My Cart</a>
            <a href="orderHistory.jsp">My Orders</a>
            <a href="profile.jsp">Profile</a>
            <a href="LogoutServlet">Logout</a>

        </div>

        <div class="footer-box">

            <h3>Contact</h3>

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