<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.foodexpress.model.Offer"%>
<%@page import="com.foodexpress.dao.OfferDAO"%>

<%
    List<Offer> offers =
        (List<Offer>) request.getAttribute("offers");

    Integer userId =
        (Integer) request.getAttribute("userId");

    OfferDAO dao = new OfferDAO();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Offers - FoodExpress</title>

<style>

body {
    margin: 0;
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
    padding: 0 7%;
    box-shadow: 0 2px 12px rgba(0,0,0,.06);
}

.logo {
    color: #2196d3;
    font-size: 25px;
    font-weight: 800;
    text-decoration: none;
}

.back {
    color: #2196d3;
    text-decoration: none;
    font-weight: 600;
}

.container {
    width: 90%;
    max-width: 1100px;
    margin: 40px auto;
}

h1 {
    color: #173f57;
    margin-bottom: 8px;
}

.subtitle {
    color: #78909c;
    margin-bottom: 28px;
}

.grid {
    display: grid;
    grid-template-columns:
        repeat(auto-fit, minmax(270px, 1fr));
    gap: 20px;
}

.card {
    background: white;
    border-radius: 16px;
    padding: 25px;
    box-shadow: 0 5px 20px rgba(0,0,0,.06);
}

.offer-title {
    color: #1976b9;
    font-size: 22px;
    font-weight: 800;
}

.description {
    color: #78909c;
    margin: 12px 0;
    line-height: 1.5;
}

.minimum {
    background: #eef8ff;
    color: #1976b9;
    padding: 9px;
    border-radius: 8px;
    margin: 15px 0;
    font-weight: 600;
}

.claim-btn {
    width: 100%;
    border: none;
    background: #2196d3;
    color: white;
    padding: 12px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: bold;
}

.claim-btn:hover {
    background: #1976b9;
}

.claimed {
    background: #e4f7ec;
    color: #25834b;
    padding: 12px;
    border-radius: 8px;
    text-align: center;
    font-weight: bold;
}

</style>

</head>

<body>

<nav class="navbar">

    <a href="userHome.jsp" class="logo">
        FoodExpress
    </a>

    <a href="userHome.jsp" class="back">
        ← Home
    </a>

</nav>

<div class="container">

    <h1>Available Offers</h1>

    <p class="subtitle">
        Claim the offers available for your account.
    </p>

    <div class="grid">

    <% if (offers != null && !offers.isEmpty()) { %>

        <% for (Offer offer : offers) {

            boolean claimed =
                dao.hasClaimed(
                    userId,
                    offer.getOfferId()
                );
        %>

        <div class="card">

            <div class="offer-title">
                <%= offer.getOfferName() %>
            </div>

            <div class="description">
                <%= offer.getDescription() %>
            </div>

            <div class="minimum">
                Minimum Order:
                ৳<%= offer.getMinimumOrder() %>
            </div>

            <% if (claimed) { %>

                <div class="claimed">
                    ✓ Already Claimed
                </div>

            <% } else { %>

                <form
                    action="ClaimOfferServlet"
                    method="post">

                    <input
                        type="hidden"
                        name="offerId"
                        value="<%=offer.getOfferId()%>">

                    <button
                        type="submit"
                        class="claim-btn">

                        Claim Offer

                    </button>

                </form>

            <% } %>

        </div>

        <% } %>

    <% } else { %>

        <p>No active offers available.</p>

    <% } %>

    </div>

</div>

</body>
</html>