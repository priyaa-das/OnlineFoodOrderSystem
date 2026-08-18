<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.foodexpress.model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String orderId = request.getParameter("orderId");
    String total = request.getParameter("total");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Order Successful | FoodExpress</title>

    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap"
        rel="stylesheet">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: #f5f8fc;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .success-card {
            width: 90%;
            max-width: 600px;
            background: white;
            padding: 45px 35px;
            border-radius: 18px;
            text-align: center;
            box-shadow: 0 10px 35px rgba(0,0,0,0.10);
        }

        .success-icon {
            width: 85px;
            height: 85px;
            margin: 0 auto 20px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: #e8f5e9;
            color: #2e7d32;

            font-size: 45px;
            font-weight: 700;
        }

        h1 {
            color: #172033;
            margin-bottom: 10px;
        }

        .message {
            color: #64748b;
            line-height: 1.7;
            margin-bottom: 25px;
        }

        .order-info {
            background: #f8fafc;
            border-radius: 12px;
            padding: 18px;
            margin: 20px 0;
        }

        .order-info p {
            margin: 8px 0;
            color: #475569;
        }

        .order-info strong {
            color: #172033;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin-top: 25px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 12px 22px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
        }

        .primary-btn {
            background: #2196F3;
            color: white;
        }

        .primary-btn:hover {
            background: #1976d2;
        }

        .secondary-btn {
            background: #e3f2fd;
            color: #1976d2;
        }

        .secondary-btn:hover {
            background: #bbdefb;
        }

    </style>

</head>

<body>

    <div class="success-card">

        <div class="success-icon">
            ✓
        </div>

        <h1>
            Order Placed Successfully!
        </h1>

        <p class="message">

            Thank you, <strong><%=user.getFullName()%></strong>!

            Your order has been placed successfully.
            We will prepare your food and process it shortly.

        </p>

        <div class="order-info">

            <p>
                <strong>Order ID:</strong>
                #<%=orderId != null ? orderId : "N/A"%>
            </p>

            <% if (total != null && !total.isEmpty()) { %>

                <p>
                    <strong>Total Amount:</strong>
                    ৳<%=total%>
                </p>

            <% } %>

            <p>
                <strong>Status:</strong>
                Pending
            </p>

        </div>

        <div class="button-group">

            <a
                href="OrderHistoryServlet"
                class="btn primary-btn">

                View My Orders

            </a>

            <a
                href="MenuServlet"
                class="btn secondary-btn">

                Continue Shopping

            </a>

        </div>

    </div>

</body>

</html>