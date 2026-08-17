<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User admin = (User) session.getAttribute("admin");

    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Edit Admin Profile | FoodExpress</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7ff;
        }

        .navbar {
            background: #2196F3;
            height: 85px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 45px;
            box-shadow: 0 4px 15px rgba(0,0,0,.12);
        }

        .logo {
            color: white;
            font-size: 27px;
            font-weight: bold;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            font-weight: 600;
            padding: 10px 18px;
            border-radius: 7px;
        }

        .nav-link:hover {
            background: rgba(255,255,255,.15);
        }

        .container {
            max-width: 800px;
            margin: 45px auto;
            padding: 0 25px;
        }

        .card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 35px rgba(0,0,0,.08);
        }

        .title {
            text-align: center;
            margin-bottom: 35px;
        }

        .title h1 {
            margin: 0 0 8px;
            color: #1e293b;
        }

        .title p {
            margin: 0;
            color: #64748b;
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

        .full {
            grid-column: 1 / -1;
        }

        label {
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 600;
            color: #475569;
        }

        input,
        textarea {
            width: 100%;
            padding: 13px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        input:focus,
        textarea:focus {
            border-color: #2196F3;
            box-shadow: 0 0 0 3px rgba(33,150,243,.12);
        }

        .note {
            color: #64748b;
            font-size: 12px;
            margin-top: 6px;
        }

        .buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 35px;
        }

        button,
        .cancel {
            padding: 13px 25px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            text-decoration: none;
            cursor: pointer;
        }

        .save {
            background: #2196F3;
            color: white;
        }

        .save:hover {
            background: #1976D2;
        }

        .cancel {
            background: #e2e8f0;
            color: #334155;
        }

        .cancel:hover {
            background: #cbd5e1;
        }

        @media(max-width: 650px) {

            .form-grid {
                grid-template-columns: 1fr;
            }

            .full {
                grid-column: auto;
            }

            .navbar {
                padding: 0 20px;
            }

            .card {
                padding: 25px;
            }
        }

    </style>

</head>

<body>

<nav class="navbar">

    <div class="logo">
        FoodExpress Admin
    </div>

    <a href="adminDashboard.jsp"
       class="nav-link">
        Dashboard
    </a>

</nav>


<div class="container">

    <div class="card">

        <div class="title">

            <h1>Edit Profile</h1>

            <p>
                Update your administrator information
            </p>

        </div>


        <form action="UpdateAdminProfileServlet"
              method="post">

            <div class="form-grid">


                <div class="form-group">

                    <label>Full Name</label>

                    <input type="text"
                           name="fullName"
                           value="<%= admin.getFullName() %>"
                           required>

                </div>


                <div class="form-group">

                    <label>Email</label>

                    <input type="email"
                           name="email"
                           value="<%= admin.getEmail() %>"
                           required>

                </div>


                <div class="form-group">

                    <label>Phone</label>

                    <input type="text"
                           name="phone"
                           value="<%= admin.getPhone() == null ? "" : admin.getPhone() %>">

                </div>


                <div class="form-group">

                    <label>New Password</label>

                    <input type="password"
                           name="password"
                           placeholder="Leave blank to keep current password">

                    <span class="note">
                        Leave blank if you don't want to change password.
                    </span>

                </div>


                <div class="form-group full">

                    <label>Address</label>

                    <textarea name="address"><%= admin.getAddress() == null ? "" : admin.getAddress() %></textarea>

                </div>


            </div>


            <div class="buttons">

                <button type="submit"
                        class="save">

                    Save Changes

                </button>

                <a href="adminProfile.jsp"
                   class="cancel">

                    Cancel

                </a>

            </div>

        </form>

    </div>

</div>

</body>
</html>