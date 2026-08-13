<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.foodexpress.model.User"%>
<%@page import="com.foodexpress.model.Food"%>

<%
    User user = (User) session.getAttribute("user");

    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
    List<Food> foodList = (List<Food>) request.getAttribute("foodList");

    Map<Integer, String> categoryMap = new HashMap<>();

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

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <div class="logo">
        FoodExpress
    </div>

    <ul class="nav-links">

        <li><a href="userHome.jsp">Dashboard</a></li>
        <li><a href="MenuServlet" class="active">Menu</a></li>
        <li><a href="cart.jsp">My Cart</a></li>
        <li><a href="orderHistory.jsp">My Orders</a></li>
        <li><a href="profile.jsp">Profile</a></li>
        <li><a href="LogoutServlet" class="login-btn">Logout</a></li>

    </ul>

</nav>

<!-- ================= HERO ================= -->

<section class="dashboard-hero">

    <div class="dashboard-left">

        <span class="tagline">
            Fresh & Delicious
        </span>

        <h1>
            Explore Our Menu
        </h1>

        <p>
            Choose your favorite meals prepared by our expert chefs.
            Fresh ingredients, premium quality and fast delivery.
        </p>

    </div>

    <div class="dashboard-right">

        <img src="https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg"
             alt="Restaurant Food">

    </div>

</section>
<!-- ================= DYNAMIC MENU ================= -->

<%
if(foodList != null && !foodList.isEmpty()){

    for(Integer categoryId : categoryMap.keySet()){

        boolean hasFood = false;

        for(Food f : foodList){

            if(f.getCategoryId() == categoryId){

                hasFood = true;
                break;

            }

        }

        if(hasFood){
%>

<section class="featured">

    <h2><%=categoryMap.get(categoryId)%></h2>

    <div class="food-container">

<%

        for(Food food : foodList){

            if(food.getCategoryId() == categoryId){

%>

<div class="food-card">

    <img src="<%=food.getImageUrl()%>"
         alt="<%=food.getFoodName()%>">

    <div class="food-info">

        <h3><%=food.getFoodName()%></h3>

        <span class="price">
            ৳<%=food.getPrice()%>
        </span>

        <p>
            <%=food.getDescription()%>
        </p>

        <form action="<%=request.getContextPath()%>/AddToCartServlet"
              method="post">

            <input type="hidden"
                   name="foodId"
                   value="<%=food.getFoodId()%>">

            <button type="submit">

                Add To Cart

            </button>

        </form>

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

}else{

%>

<section class="featured">

    <h2>No Food Available</h2>

    <p>No food found in database.</p>

</section>

<%

}

%>
<!-- ================= FOOTER ================= -->

<footer>

    <div class="footer-container">

        <div class="footer-box">

            <h3>FoodExpress</h3>

            <p>
                Fresh food, fast delivery and premium dining
                experience at your fingertips.
            </p>

        </div>

        <div class="footer-box">

            <h3>Quick Links</h3>

            <a href="userHome.jsp">Dashboard</a>
            <a href="MenuServlet">Menu</a>
            <a href="cart.jsp">My Cart</a>
            <a href="orderHistory.jsp">My Orders</a>

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