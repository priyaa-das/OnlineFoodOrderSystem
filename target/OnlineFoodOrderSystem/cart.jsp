<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="com.foodexpress.model.Cart"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User user =
            (User) session.getAttribute("user");

    if (user == null) {

        response.sendRedirect("login.jsp");
        return;
    }

    List<Cart> cartList =
            (List<Cart>) request.getAttribute("cartList");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Cart | FoodExpress</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7ff;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 40px;
            background: #0891b2;
        }

        .logo {
            color: white;
            font-size: 25px;
            font-weight: bold;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 25px;
            margin: 0;
            padding: 0;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .container {
            width: 90%;
            margin: 40px auto;
        }

        h1 {
            color: #1e293b;
            margin-bottom: 30px;
        }

        .cart-container {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow:
                0 4px 15px
                rgba(0,0,0,0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #0891b2;
            color: white;
            padding: 14px;
            text-align: left;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }

        .food-image {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
        }

        .quantity {
            font-weight: bold;
            font-size: 17px;
        }

        .remove-btn {
            background: #ef4444;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
        }

        .remove-btn:hover {
            background: #dc2626;
        }

        .empty {
            text-align: center;
            padding: 50px;
            color: #64748b;
            font-size: 18px;
        }

        .total-section {
            margin-top: 25px;
            text-align: right;
            font-size: 22px;
            font-weight: bold;
            color: #1e293b;
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
            <a href="<%=request.getContextPath()%>/userHome.jsp">
                Home
            </a>
        </li>

        <li>
            <a href="<%=request.getContextPath()%>/menu.jsp">
                Menu
            </a>
        </li>

        <li>
            <a href="<%=request.getContextPath()%>/LogoutServlet">
                Logout
            </a>
        </li>

    </ul>

</nav>

<!-- ================= CART ================= -->

<div class="container">

    <h1>
        My Cart
    </h1>

    <div class="cart-container">

        <% if (cartList == null ||
               cartList.isEmpty()) { %>

            <div class="empty">

                <h2>
                    Your cart is empty
                </h2>

                <p>
                    Add some delicious food from the menu.
                </p>

            </div>

        <% } else { %>

            <table>

                <thead>

                    <tr>

                        <th>
                            Food
                        </th>

                        <th>
                            Name
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

                        <th>
                            Action
                        </th>

                    </tr>

                </thead>

                <tbody>

                <%
                    double grandTotal = 0;

                    for (Cart cart : cartList) {

                        double total =
                                cart.getTotalPrice();

                        grandTotal += total;
                %>

                    <tr>

                        <td>

                            <%
                                if (cart.getImageUrl() != null &&
                                    !cart.getImageUrl().isEmpty()) {
                            %>

                                <img
                                    src="<%=cart.getImageUrl()%>"
                                    class="food-image"
                                    alt="Food">

                            <%
                                }
                            %>

                        </td>

                        <td>
                            <%=cart.getFoodName()%>
                        </td>

                        <td>
                            ৳ <%=cart.getPrice()%>
                        </td>

                        <td>

                            <span class="quantity">
                                <%=cart.getQuantity()%>
                            </span>

                        </td>

                        <td>
                            ৳ <%=total%>
                        </td>

                        <td>

                            <a
                                href="RemoveFromCartServlet?cartId=<%=cart.getCartId()%>"
                                class="remove-btn"
                                onclick="return confirm('Are you sure you want to remove this item from your cart?');">

                                Remove

                            </a>

                        </td>

                    </tr>

                <%
                    }
                %>

                </tbody>

            </table>

            <!-- GRAND TOTAL -->

            <div class="total-section">

                Grand Total:
                ৳ <%=grandTotal%>

            </div>

        <% } %>

    </div>

</div>

</body>

</html>