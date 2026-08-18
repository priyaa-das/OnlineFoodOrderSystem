<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // =====================================================
    // ADMIN LOGIN CHECK
    // =====================================================

    if (session == null ||
        session.getAttribute("admin") == null) {

        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Add New Food | FoodExpress</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f4faff;
            color: #263238;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            height: 72px;
            background: white;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 6%;

            box-shadow:
                0 2px 12px rgba(70,130,180,0.10);

            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo {
            text-decoration: none;
            color: #4da6d8;
            font-size: 25px;
            font-weight: 800;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .nav-links a {
            text-decoration: none;
            color: #455a64;
            font-size: 14px;
            font-weight: 600;
        }

        .nav-links a:hover {
            color: #3b9ac4;
        }

        /* ================= PAGE ================= */

        .container {
            width: 92%;
            max-width: 850px;
            margin: 45px auto 60px;
        }

        .page-header {
            margin-bottom: 25px;
        }

        .page-header h1 {
            font-size: 30px;
            color: #263238;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #78909c;
            font-size: 14px;
        }

        /* ================= FORM CARD ================= */

        .form-card {
            background: white;
            border-radius: 16px;
            padding: 35px;

            box-shadow:
                0 6px 25px rgba(70,130,180,0.10);

            border: 1px solid #e3f0f7;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        label {
            font-size: 13px;
            font-weight: 700;
            color: #455a64;
            margin-bottom: 7px;
        }

        input,
        select,
        textarea {

            width: 100%;

            border: 1px solid #cfe5ef;

            border-radius: 8px;

            padding: 12px;

            background: white;

            color: #37474f;

            font-size: 14px;

            outline: none;

            font-family: Arial, Helvetica, sans-serif;
        }

        input,
        select {
            height: 44px;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        input:focus,
        select:focus,
        textarea:focus {

            border-color: #66b9df;

            box-shadow:
                0 0 0 3px rgba(
                    102,
                    185,
                    223,
                    0.12
                );
        }

        .hint {
            margin-top: 6px;
            color: #90a4ae;
            font-size: 11px;
        }

        /* ================= ACTIONS ================= */

        .form-actions {
            margin-top: 30px;

            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn {
            border: none;
            border-radius: 8px;

            padding: 12px 24px;

            font-size: 14px;
            font-weight: 700;

            text-decoration: none;

            cursor: pointer;
        }

        .cancel-btn {
            background: #edf5f9;
            color: #4f6b78;
        }

        .cancel-btn:hover {
            background: #dfeef5;
        }

        .add-btn {
            background: #5aaed6;
            color: white;
        }

        .add-btn:hover {
            background: #4299c3;
        }

        /* ================= RESPONSIVE ================= */

        @media (max-width: 700px) {

            .navbar {
                padding: 0 20px;
            }

            .nav-links {
                gap: 12px;
            }

            .nav-links a {
                font-size: 11px;
            }

            .container {
                width: 94%;
            }

            .form-card {
                padding: 25px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group.full {
                grid-column: auto;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                text-align: center;
            }
        }

    </style>

</head>

<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <a href="adminDashboard.jsp"
       class="logo">
        FoodExpress
    </a>

    <div class="nav-links">

        <a href="adminDashboard.jsp">
            Dashboard
        </a>

        <a href="ManageOrderServlet">
            Manage Orders
        </a>

        <a href="ManageOfferServlet">
            Manage Offers
        </a>

        <a href="LogoutServlet">
            Logout
        </a>

    </div>

</nav>


<!-- ================= MAIN ================= -->

<div class="container">

    <div class="page-header">

        <h1>
            Add New Food
        </h1>

        <p>
            Add a new food item to the FoodExpress menu.
        </p>

    </div>


    <div class="form-card">

        <form
            action="AddFoodServlet"
            method="post">


            <div class="form-grid">


                <!-- ================= FOOD NAME ================= -->

                <div class="form-group">

                    <label for="foodName">
                        Food Name
                    </label>

                    <input
                        type="text"
                        id="foodName"
                        name="foodName"
                        placeholder="Enter food name"
                        required
                    >

                </div>


                <!-- ================= CATEGORY ================= -->

                <div class="form-group">

                    <label for="categoryId">
                        Category
                    </label>

                    <select
                        id="categoryId"
                        name="categoryId"
                        required
                    >

                        <option value="">
                            -- Select Category --
                        </option>

                        <option value="1">
                            🍔 Burger
                        </option>

                        <option value="2">
                            🍕 Pizza
                        </option>

                        <option value="3">
                            🍝 Pasta
                        </option>

                        <option value="4">
                            🥩 Steak
                        </option>

                        <option value="5">
                            🦞 Seafood
                        </option>

                        <option value="6">
                            🍰 Dessert
                        </option>

                        <option value="7">
                            🥤 Beverages
                        </option>

                    </select>

                </div>


                <!-- ================= PRICE ================= -->

                <div class="form-group">

                    <label for="price">
                        Price (৳)
                    </label>

                    <input
                        type="number"
                        id="price"
                        name="price"
                        placeholder="Enter price"
                        min="0"
                        step="0.01"
                        required
                    >

                </div>


                <!-- ================= STATUS ================= -->

                <div class="form-group">

                    <label for="status">
                        Status
                    </label>

                    <select
                        id="status"
                        name="status"
                        required
                    >

                        <option value="Available">
                            Available
                        </option>

                        <option value="Unavailable">
                            Unavailable
                        </option>

                    </select>

                </div>


                <!-- ================= DESCRIPTION ================= -->

                <div class="form-group full">

                    <label for="description">
                        Description
                    </label>

                    <textarea
                        id="description"
                        name="description"
                        placeholder="Write a short description of the food..."
                        required
                    ></textarea>

                </div>


                <!-- ================= IMAGE URL ================= -->

                <div class="form-group full">

                    <label for="imageUrl">
                        Image URL
                    </label>

                    <input
                        type="url"
                        id="imageUrl"
                        name="imageUrl"
                        placeholder="https://example.com/food.jpg"
                        required
                    >

                    <span class="hint">
                        Use a direct image URL.
                    </span>

                </div>


            </div>


            <!-- ================= BUTTONS ================= -->

            <div class="form-actions">

                <a
                    href="adminDashboard.jsp"
                    class="btn cancel-btn"
                >
                    Cancel
                </a>

                <button
                    type="submit"
                    class="btn add-btn"
                >
                    Add Food
                </button>

            </div>


        </form>

    </div>

</div>


</body>

</html>