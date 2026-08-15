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

    Boolean editModeObj =
            (Boolean) request.getAttribute("editMode");

    boolean editMode =
            editModeObj != null &&
            editModeObj;

    String pageTitle =
            editMode
            ? "Edit Food"
            : "Add Food";

    String buttonText =
            editMode
            ? "Update Food"
            : "Add Food";
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title><%=pageTitle%> | FoodExpress</title>

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

            gap: 20px;

            margin: 0;

            padding: 0;
        }

        .nav-links a {

            color: white;

            text-decoration: none;

            padding: 10px 16px;

            border-radius: 6px;
        }

        .dashboard {

            padding: 40px;
        }

        .form-container {

            max-width: 650px;

            margin: 20px auto;

            background: white;

            padding: 35px;

            border-radius: 12px;

            box-shadow:
                0 4px 15px rgba(0,0,0,0.08);
        }

        h1 {

            color: #1e293b;

            text-align: center;

            margin-bottom: 30px;
        }

        label {

            display: block;

            margin-bottom: 8px;

            font-weight: bold;

            color: #334155;
        }

        input,
        textarea,
        select {

            width: 100%;

            padding: 12px;

            margin-bottom: 20px;

            border: 1px solid #cbd5e1;

            border-radius: 6px;

            box-sizing: border-box;

            font-size: 15px;
        }

        textarea {

            resize: vertical;
        }

        .btn {

            display: inline-block;

            padding: 12px 25px;

            border: none;

            border-radius: 6px;

            background: #0891b2;

            color: white;

            font-size: 15px;

            cursor: pointer;
        }

        .btn:hover {

            background: #0e7490;
        }

        .cancel-btn {

            background: #64748b;

            text-decoration: none;

            margin-left: 10px;
        }

        .cancel-btn:hover {

            background: #475569;
        }

    </style>

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
                Manage Food
            </a>
        </li>

        <li>
            <a href="LogoutServlet">
                Logout
            </a>
        </li>

    </ul>

</nav>


<section class="dashboard">

    <div class="form-container">

        <h1>
            <%=pageTitle%>
        </h1>


        <form
            action="<%= editMode
                    ? "EditFoodServlet"
                    : "AddFoodServlet" %>"
            method="post">


            <% if (editMode) { %>

                <input
                    type="hidden"
                    name="foodId"
                    value="<%=food.getFoodId()%>">

            <% } %>


            <label>
                Category ID
            </label>

            <input
                type="number"
                name="categoryId"
                required
                value="<%= editMode
                        ? food.getCategoryId()
                        : "" %>">


            <label>
                Food Name
            </label>

            <input
                type="text"
                name="foodName"
                required
                value="<%= editMode
                        ? food.getFoodName()
                        : "" %>">


            <label>
                Description
            </label>

            <textarea
                name="description"
                rows="4"
                required><%= editMode
                    ? food.getDescription()
                    : "" %></textarea>


            <label>
                Price
            </label>

            <input
                type="number"
                name="price"
                step="0.01"
                min="0"
                required
                value="<%= editMode
                        ? food.getPrice()
                        : "" %>">


            <label>
                Image URL
            </label>

            <input
                type="text"
                name="imageUrl"
                placeholder="Enter image URL"
                value="<%= editMode
                        ? food.getImageUrl()
                        : "" %>">


            <label>
                Status
            </label>

            <select
                name="status"
                required>

                <option
                    value="Available"
                    <%= editMode &&
                        "Available".equals(
                            food.getStatus()
                        )
                        ? "selected"
                        : "" %>>

                    Available

                </option>

                <option
                    value="Unavailable"
                    <%= editMode &&
                        "Unavailable".equals(
                            food.getStatus()
                        )
                        ? "selected"
                        : "" %>>

                    Unavailable

                </option>

            </select>


            <button
                type="submit"
                class="btn">

                <%=buttonText%>

            </button>


            <a
                href="AdminFoodServlet"
                class="btn cancel-btn">

                Cancel

            </a>

        </form>

    </div>

</section>

</body>

</html>