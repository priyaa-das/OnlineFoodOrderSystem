<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.foodexpress.model.User"%>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    List<User> userList =
            (List<User>) request.getAttribute("userList");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>View Users | FoodExpress</title>

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

        .logout-btn {
            background: #7dd3fc;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .container {
            width: 92%;
            margin: 40px auto;
        }

        h1 {
            color: #1e293b;
            margin-bottom: 25px;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 18px;
            background: #0891b2;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .table-container {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            overflow-x: auto;
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
            padding: 13px;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background: #f0fdfa;
        }

        .role {
            background: #bae6fd;
            color: #0369a1;
            padding: 6px 12px;
            border-radius: 15px;
            font-weight: bold;
        }

        .delete-btn {
            background: #ef4444;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }

        .delete-btn:hover {
            background: #dc2626;
        }

        .empty {
            text-align: center;
            padding: 30px;
            color: #64748b;
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
            <a href="LogoutServlet"
               class="logout-btn">
                Logout
            </a>
        </li>

    </ul>

</nav>


<div class="container">

    <h1>
        Registered Users
    </h1>


    <a href="adminDashboard.jsp"
       class="back-btn">
        ← Back to Dashboard
    </a>


    <div class="table-container">

        <% if (userList == null || userList.isEmpty()) { %>

            <div class="empty">
                No users found.
            </div>

        <% } else { %>

            <table>

                <thead>

                    <tr>

                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Role</th>
                        <th>Action</th>

                    </tr>

                </thead>


                <tbody>

                    <% for (User user : userList) { %>

                        <tr>

                            <td>
                                <%= user.getUserId() %>
                            </td>

                            <td>
                                <%= user.getFullName() %>
                            </td>

                            <td>
                                <%= user.getEmail() %>
                            </td>

                            <td>
                                <%= user.getPhone() %>
                            </td>

                            <td>
                                <%= user.getAddress() %>
                            </td>

                            <td>

                                <span class="role">
                                    <%= user.getRole() %>
                                </span>

                            </td>


                            <td>

                                <a href="DeleteUserServlet?id=<%=user.getUserId()%>"
                                   class="delete-btn"
                                   onclick="return confirm('Are you sure you want to delete this customer?');">

                                    Delete

                                </a>

                            </td>

                        </tr>

                    <% } %>

                </tbody>

            </table>

        <% } %>

    </div>

</div>

</body>

</html>