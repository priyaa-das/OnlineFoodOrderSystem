<%-- 
    Document   : manageFood
    Created on : Aug 14, 2026, 1:25:01 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.foodexpress.model.Food"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User admin =
            (User) session.getAttribute("admin");

    if (admin == null) {

        response.sendRedirect("adminLogin.jsp");
        return;
    }

    List<Food> foodList =
            (List<Food>) request.getAttribute(
                    "foodList"
            );
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Manage Food | FoodExpress</title>

    <link rel="stylesheet"
          href="css/style.css">

</head>

<body>

<nav class="navbar">

    <div class="logo">
        FoodExpress Admin
    </div>

    <ul class="nav-links">

        <li>
            <a href="adminDashboard.jsp">
                Dashboard
            </a>
        </li>

        <li>
            <a href="AdminFoodServlet">
                Food
            </a>
        </li>

        <li>
            <a href="AdminOrderServlet">
                Orders
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

    <h1>Manage Food</h1>

    <br>

    <a href="addFood.jsp"
       class="primary-btn">

        + Add New Food

    </a>

    <br><br>


    <table class="order-table">

        <tr>

            <th>ID</th>
            <th>Image</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Status</th>
            <th>Action</th>

        </tr>

<%
    if (foodList != null) {

        for (Food food : foodList) {
%>

        <tr>

            <td>
                <%=food.getFoodId()%>
            </td>

            <td>

                <img src="<%=food.getImageUrl()%>"
                     width="70"
                     height="70"
                     style="object-fit:cover;border-radius:10px;">

            </td>

            <td>
                <%=food.getFoodName()%>
            </td>

            <td>
                <%=food.getCategoryId()%>
            </td>

            <td>
                ৳<%=food.getPrice()%>
            </td>

            <td>
                <%=food.getStatus()%>
            </td>

            <td>

                <a href="EditFoodServlet?id=<%=food.getFoodId()%>">
                    Edit
                </a>

                |

                <a href="DeleteFoodServlet?id=<%=food.getFoodId()%>"
                   onclick="return confirm('Delete this food?');">

                    Delete

                </a>

            </td>

        </tr>

<%
        }
    }
%>

    </table>

</section>

</body>
</html>