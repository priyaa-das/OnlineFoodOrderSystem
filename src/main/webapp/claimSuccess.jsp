<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {

        response.sendRedirect("login.jsp");

        return;
    }

    String offer = request.getParameter("offer");

    if (offer == null) {
        offer = "Special Offer";
    }

    String already =
            request.getParameter("already");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Offer Claimed | FoodExpress</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

    <style>

        * {
            box-sizing: border-box;
        }

        body {

            margin: 0;

            min-height: 100vh;

            display: flex;

            align-items: center;

            justify-content: center;

            font-family: 'Poppins', sans-serif;

            background:
                linear-gradient(
                    135deg,
                    #e3f2fd,
                    #f8fbff
                );
        }

        .success-box {

            width: 90%;
            max-width: 550px;

            background: white;

            padding: 50px 40px;

            border-radius: 22px;

            text-align: center;

            box-shadow:
                0 15px 45px rgba(0,0,0,0.10);
        }

        .icon {

            width: 85px;
            height: 85px;

            margin: 0 auto 25px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: #e8f5e9;

            color: #2e7d32;

            font-size: 45px;
        }

        h1 {

            margin: 0 0 15px;

            color: #172033;

            font-size: 30px;
        }

        .offer-name {

            display: inline-block;

            margin: 10px 0 20px;

            padding: 10px 20px;

            background: #e3f2fd;

            color: #1976D2;

            border-radius: 30px;

            font-weight: 600;
        }

        p {

            color: #64748b;

            line-height: 1.7;

            font-size: 14px;
        }

        .buttons {

            display: flex;

            justify-content: center;

            gap: 15px;

            margin-top: 30px;
        }

        .btn {

            padding: 12px 23px;

            border-radius: 8px;

            text-decoration: none;

            font-size: 14px;

            font-weight: 600;
        }

        .primary {

            background: #2196F3;

            color: white;
        }

        .secondary {

            background: #eef2f7;

            color: #334155;
        }

    </style>

</head>


<body>


<div class="success-box">

    <div class="icon">

        <% if ("true".equals(already)) { %>

            ✓

        <% } else { %>

            ✓

        <% } %>

    </div>


    <% if ("true".equals(already)) { %>

        <h1>
            Already Claimed!
        </h1>

        <p>
            You have already claimed this offer.
        </p>

    <% } else { %>

        <h1>
            Offer Claimed!
        </h1>

        <p>
            Congratulations,
            <strong><%=user.getFullName()%></strong>!
        </p>

        <p>
            Your offer has been successfully claimed.
        </p>

    <% } %>


    <div class="offer-name">

        <%=offer%>

    </div>


    <p>
        You can now continue shopping and
        enjoy your FoodExpress experience.
    </p>


    <div class="buttons">

        <a href="offers.jsp"
           class="btn secondary">

            View Offers

        </a>

        <a href="MenuServlet"
           class="btn primary">

            Explore Menu

        </a>

    </div>

</div>


</body>

</html>