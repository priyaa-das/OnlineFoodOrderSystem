<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FoodExpress | Premium Online Food Order System</title>

    <link rel="stylesheet" href="css/style.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

</head>

<body>


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
        <li><a href="adminLogin.jsp" class="adminLogin-btn">Admin Login</a></li>    
        <li><a href="register.jsp" class="register-btn">Register</a></li>

    </ul>

</nav>

<!-- ================= HERO SECTION ================= -->

<section class="hero">

    <div class="hero-text">

        <span class="tagline">

            Premium Restaurant Experience

        </span>

        <h1>

            Delicious Food <br>

            Delivered To Your Door

        </h1>

        <p>

            Order premium quality meals prepared by experienced chefs.
            Enjoy fresh food, fast delivery and exceptional service.

        </p>

        <div class="hero-buttons">

            <a href="register.jsp" class="primary-btn">

                Order Now

            </a>

            <a href="menu.jsp" class="secondary-btn">

                View Menu

            </a>

        </div>

    </div>

    <div class="hero-image">

        <img src="https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg"
             alt="Food">

    </div>

</section>

<!-- ================= FEATURED MENU ================= -->

<section class="featured">

    <h2>

        Featured Dishes

    </h2>

    <p>

        Discover some of our chef's most popular premium meals.

    </p>

    <div class="food-container">

        <div class="food-card">

            <img src="https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg"
                 alt="Burger">

            <div class="food-info">

                <h3>Classic Beef Burger</h3>

                <span class="price">৳450</span>

                <p>

                    Juicy grilled beef patty with cheese,
                    lettuce and special sauce.

                </p>

                <button>

                    Order Now

                </button>

            </div>

        </div>

        <div class="food-card">

            <img src="https://images.pexels.com/photos/825661/pexels-photo-825661.jpeg"
                 alt="Pizza">

            <div class="food-info">

                <h3>Margherita Pizza</h3>

                <span class="price">৳850</span>

                <p>

                    Authentic Italian pizza topped with
                    mozzarella cheese and fresh basil.

                </p>

                <button>

                    Order Now

                </button>

            </div>

        </div>

        <div class="food-card">

            <img src="https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg"
                 alt="Pasta">

            <div class="food-info">

                <h3>Chicken Alfredo Pasta</h3>

                <span class="price">৳780</span>

                <p>

                    Creamy Alfredo sauce served with
                    grilled chicken and parmesan cheese.

                </p>

                <button>

                    Order Now

                </button>

            </div>

        </div>

    </div>

</section>
<!-- ================= SPECIAL OFFERS ================= -->

<section class="offers">

    <div class="offer-box">

        <h2>

            Exclusive Weekend Offer

        </h2>

        <p>

            Get 20% OFF on selected premium dishes every Friday and Saturday.
            Enjoy delicious meals at special prices.

        </p>

        <a href="offers.jsp" class="primary-btn">

            Explore Offers

        </a>

    </div>

</section>



<!-- ================= WHY CHOOSE US ================= -->

<section class="why-us">

    <h2>

        Why Choose FoodExpress?

    </h2>

    <p>

        We are committed to delivering quality food with excellent customer service.

    </p>

    <div class="features">

        <div class="feature-card">

            <h3>

                Premium Quality

            </h3>

            <p>

                Fresh ingredients and premium quality food prepared by professional chefs.

            </p>

        </div>

        <div class="feature-card">

            <h3>

                Fast Delivery

            </h3>

            <p>

                Your favorite meals delivered quickly while maintaining freshness.

            </p>

        </div>

        <div class="feature-card">

            <h3>

                Easy Ordering

            </h3>

            <p>

                Browse the menu, add items to your cart and place orders easily.

            </p>

        </div>

        <div class="feature-card">

            <h3>

                Secure Payment

            </h3>

            <p>

                Multiple secure payment methods with safe online transactions.

            </p>

        </div>

    </div>

</section>



<!-- ================= CUSTOMER REVIEWS ================= -->

<section class="reviews">

    <h2>

        Customer Reviews

    </h2>

    <p>

        Here's what our customers say about FoodExpress.

    </p>

    <div class="review-container">

        <div class="review-card">

            <h3>

                Sarah Ahmed

            </h3>

            <h4>

                ★★★★★

            </h4>

            <p>

                Excellent food quality, quick delivery and outstanding customer service.

            </p>

        </div>

        <div class="review-card">

            <h3>

                John Wilson

            </h3>

            <h4>

                ★★★★★

            </h4>

            <p>

                Delicious meals with beautiful presentation. Highly recommended.

            </p>

        </div>

        <div class="review-card">

            <h3>

                Nusrat Jahan

            </h3>

            <h4>

                ★★★★★

            </h4>

            <p>

                Great experience every time. Fresh food and friendly delivery service.

            </p>

        </div>

    </div>

</section>
<!-- ================= NEWSLETTER ================= -->

<section class="newsletter">

    <div class="newsletter-content">

        <h2>

            Stay Updated

        </h2>

        <p>

            Subscribe to receive our latest menu updates, exclusive offers and seasonal discounts.

        </p>

        <form action="#" method="post">

            <input
                type="email"
                placeholder="Enter your email"
                required>

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

            <h3>

                FoodExpress

            </h3>

            <p>

                FoodExpress is a premium online food ordering platform
                that provides delicious meals with quality service
                and fast delivery.

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

            <a href="login.jsp">

                Login

            </a>

            <a href="register.jsp">

                Register

            </a>

        </div>



        <div class="footer-box">

            <h3>

                Contact Information

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