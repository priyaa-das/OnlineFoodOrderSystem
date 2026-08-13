
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Integer orderId =
            (Integer) session.getAttribute("orderId");

    Double orderTotal =
            (Double) session.getAttribute("orderTotal");

    String paymentMethod =
            (String) session.getAttribute("paymentMethod");

    if (orderId == null) {

        response.sendRedirect("userHome.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Order Successful | FoodExpress</title>

    <link rel="stylesheet"
          href="css/style.css">

</head>

<body>

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


<section class="dashboard">

    <div class="cart-summary"
         style="text-align:center;">

        <h1>
            🎉 Order Placed Successfully!
        </h1>

        <br>

        <p>
            Thank you for ordering from FoodExpress.
        </p>

        <br>

        <h2>
            Order ID: #<%=orderId%>
        </h2>

        <br>

        <p>
            <strong>Total:</strong>
            ৳<%=String.format(
                "%.2f",
                orderTotal
            )%>
        </p>

        <br>

        <p>
            <strong>Payment Method:</strong>
            <%=paymentMethod%>
        </p>

        <br>

        <p>
            <strong>Order Status:</strong>
            Pending
        </p>

        <br>

        <a href="MenuServlet"
           class="primary-btn">

            Continue Shopping

        </a>

        <a href="orderHistory.jsp"
           class="secondary-btn">

            My Orders

        </a>

    </div>

</section>

</body>

</html>

<%
    session.removeAttribute("orderId");
    session.removeAttribute("orderTotal");
    session.removeAttribute("paymentMethod");
%>