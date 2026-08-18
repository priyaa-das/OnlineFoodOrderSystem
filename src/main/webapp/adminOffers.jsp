<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.foodexpress.model.Offer"%>

<%
    List<Offer> offers =
        (List<Offer>) request.getAttribute("offers");

    if (offers == null) {
        response.sendRedirect("AdminOfferServlet");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Manage Offers - FoodExpress</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #f4faff;
    color: #263238;
}

.navbar {
    height: 70px;
    background: white;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 6%;
    box-shadow: 0 2px 12px rgba(0,0,0,.07);
}

.logo {
    font-size: 25px;
    font-weight: 800;
    color: #2196d3;
    text-decoration: none;
}

.back {
    text-decoration: none;
    color: #2196d3;
    font-weight: 600;
}

.container {
    width: 92%;
    max-width: 1200px;
    margin: 40px auto;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
}

.header h1 {
    color: #163b54;
}

.header p {
    color: #78909c;
    margin-top: 6px;
}

.add-btn {
    text-decoration: none;
    background: #2196d3;
    color: white;
    padding: 12px 20px;
    border-radius: 8px;
    font-weight: bold;
}

.table-card {
    background: white;
    border-radius: 15px;
    padding: 20px;
    box-shadow: 0 5px 20px rgba(0,0,0,.06);
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background: #eaf6fd;
    color: #176b9c;
    padding: 14px;
    text-align: left;
}

td {
    padding: 14px;
    border-bottom: 1px solid #edf1f4;
}

.offer-name {
    font-weight: bold;
    color: #173f57;
}

.type {
    color: #607d8b;
    font-size: 13px;
}

.status {
    padding: 6px 11px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
}

.active {
    background: #e4f8ed;
    color: #21864b;
}

.inactive {
    background: #fce8e8;
    color: #c62828;
}

.actions {
    display: flex;
    gap: 7px;
}

.action {
    text-decoration: none;
    padding: 7px 11px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: bold;
}

.edit {
    background: #e8f5ff;
    color: #1976b9;
}

.toggle {
    background: #eef7f0;
    color: #388e3c;
}

.delete {
    background: #fff0f0;
    color: #d32f2f;
}

.empty {
    text-align: center;
    padding: 40px;
    color: #78909c;
}

</style>

</head>

<body>

<nav class="navbar">

    <a href="adminHome.jsp" class="logo">
        FoodExpress
    </a>

    <a href="adminHome.jsp" class="back">
        ← Admin Dashboard
    </a>

</nav>

<div class="container">

    <div class="header">

        <div>
            <h1>Manage Offers</h1>
            <p>Create and control customer offers</p>
        </div>

        <a href="addOffer.jsp" class="add-btn">
            + Add New Offer
        </a>

    </div>


    <div class="table-card">

        <% if (offers.isEmpty()) { %>

            <div class="empty">
                No offers available.
            </div>

        <% } else { %>

        <table>

            <tr>
                <th>Offer</th>
                <th>Type</th>
                <th>Value</th>
                <th>Minimum Order</th>
                <th>Dates</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>

            <% for (Offer offer : offers) { %>

            <tr>

                <td>
                    <div class="offer-name">
                        <%= offer.getOfferName() %>
                    </div>

                    <div class="type">
                        <%= offer.getDescription() %>
                    </div>
                </td>

                <td>
                    <%= offer.getDiscountType() %>
                </td>

                <td>

                    <% if ("PERCENTAGE".equals(
                            offer.getDiscountType())) { %>

                        <%= offer.getDiscountValue() %>%

                    <% } else if ("FIXED".equals(
                            offer.getDiscountType())) { %>

                        ৳<%= offer.getDiscountValue() %>

                    <% } else { %>

                        Free Delivery

                    <% } %>

                </td>

                <td>
                    ৳<%= offer.getMinimumOrder() %>
                </td>

                <td>
                    <%= offer.getStartDate() %>
                    <br>
                    to
                    <br>
                    <%= offer.getEndDate() %>
                </td>

                <td>

                    <span class="status
                        <%= "ACTIVE".equals(
                                offer.getStatus())
                                ? "active"
                                : "inactive" %>">

                        <%= offer.getStatus() %>

                    </span>

                </td>

                <td>

                    <div class="actions">

                        <a class="action edit"
                           href="AdminOfferServlet?action=edit&id=<%=offer.getOfferId()%>">
                            Edit
                        </a>

                        <a class="action toggle"
                           href="AdminOfferServlet?action=toggle&id=<%=offer.getOfferId()%>">

                            <%= "ACTIVE".equals(
                                    offer.getStatus())
                                    ? "Deactivate"
                                    : "Activate" %>

                        </a>

                        <a class="action delete"
                           href="AdminOfferServlet?action=delete&id=<%=offer.getOfferId()%>"
                           onclick="return confirm('Delete this offer?');">
                            Delete
                        </a>

                    </div>

                </td>

            </tr>

            <% } %>

        </table>

        <% } %>

    </div>

</div>

</body>
</html>