<%-- 
    Document   : editFood
    Created on : Aug 14, 2026, 4:26:32 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.Food"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User admin =
            (User) session.getAttribute("admin");

    if (admin == null) {

        response.sendRedirect("adminLogin.jsp");

        return;
    }

    Food food =
            (Food) request.getAttribute("food");

    if (food == null) {

        response.sendRedirect("AdminFoodServlet");

        return;
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Food | FoodExpress</title>

    <style>

        body {

            margin: 0;

            font-family: Arial, sans-serif;

            background: #f4f7ff;
        }


        /* ================= NAVBAR ================= */

        .navbar {

            display: flex;

            justify-content: space-between;

            align-items: center;

            padding: 18px 40px;

            background: #0891b2;

            box-shadow:
                0 2px 10px rgba(0,0,0,0.12);
        }


        .logo {

            color: white;

            font-size: 25px;

            font-weight: bold;
        }


        .nav-links {

            list-style: none;

            display: flex;

            align-items: center;

            gap: 25px;

            margin: 0;

            padding: 0;
        }


        .nav-links a {

            color: white;

            text-decoration: none;

            font-weight: 500;
        }


        .logout-btn {

            background: #f97316;

            padding: 10px 18px;

            border-radius: 6px;
        }


        /* ================= CONTAINER ================= */

        .container {

            width: 90%;

            max-width: 700px;

            margin: 45px auto;

            background: white;

            padding: 35px;

            border-radius: 12px;

            box-shadow:
                0 4px 15px rgba(0,0,0,0.08);
        }


        h1 {

            text-align: center;

            color: #1e293b;

            margin-bottom: 30px;
        }


        /* ================= FORM ================= */

        label {

            display: block;

            margin-top: 15px;

            margin-bottom: 7px;

            color: #334155;

            font-weight: bold;
        }


        input,
        textarea,
        select {

            width: 100%;

            padding: 11px;

            border: 1px solid #cbd5e1;

            border-radius: 6px;

            box-sizing: border-box;

            font-size: 15px;
        }


        textarea {

            resize: vertical;
        }


        input:focus,
        textarea:focus,
        select:focus {

            outline: none;

            border-color: #0891b2;
        }


        /* ================= BUTTONS ================= */

        .button-area {

            margin-top: 25px;

            display: flex;

            gap: 12px;
        }


        .btn {

            padding: 11px 22px;

            border: none;

            border-radius: 6px;

            text-decoration: none;

            cursor: pointer;

            font-size: 15px;

            color: white;
        }


        .update-btn {

            background: #0891b2;
        }


        .update-btn:hover {

            background: #0e7490;
        }


        .cancel-btn {

            background: #64748b;
        }


        .cancel-btn:hover {

            background: #475569;
        }

    </style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

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

                Manage Food

            </a>

        </li>


        <li>

            <a href="LogoutServlet"
               class="logout-btn">

                Logout

            </a>

        </li>

    </ul>

</nav>


<!-- ================= EDIT FORM ================= -->

<div class="container">

    <h1>

        Edit Food

    </h1>


    <form action="EditFoodServlet"
          method="post">


        <!-- FOOD ID -->

        <input type="hidden"
               name="foodId"
               value="<%=food.getFoodId()%>">


        <!-- CATEGORY ID -->

        <label>

            Category ID

        </label>

        <input type="number"
               name="categoryId"
               value="<%=food.getCategoryId()%>"
               required>


        <!-- FOOD NAME -->

        <label>

            Food Name

        </label>

        <input type="text"
               name="foodName"
               value="<%=food.getFoodName()%>"
               required>


        <!-- DESCRIPTION -->

        <label>

            Description

        </label>

        <textarea name="description"
                  rows="4"
                  required><%=food.getDescription()%></textarea>


        <!-- PRICE -->

        <label>

            Price (৳)

        </label>

        <input type="number"
               name="price"
               step="0.01"
               value="<%=food.getPrice()%>"
               required>


        <!-- IMAGE URL -->

        <label>

            Image URL

        </label>

        <input type="text"
               name="imageUrl"
               value="<%=food.getImageUrl()%>">


        <!-- STATUS -->

        <label>

            Status

        </label>

        <select name="status"
                required>

            <option value="Available"
                <%= "Available".equals(food.getStatus())
                    ? "selected"
                    : "" %>>

                Available

            </option>


            <option value="Unavailable"
                <%= "Unavailable".equals(food.getStatus())
                    ? "selected"
                    : "" %>>

                Unavailable

            </option>

        </select>


        <!-- BUTTONS -->

        <div class="button-area">

            <button type="submit"
                    class="btn update-btn">

                Update Food

            </button>


            <a href="AdminFoodServlet"
               class="btn cancel-btn">

                Cancel

            </a>

        </div>


    </form>

</div>


</body>

</html>
