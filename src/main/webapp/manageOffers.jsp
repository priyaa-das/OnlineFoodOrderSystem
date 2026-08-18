<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.foodexpress.model.Offer"%>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    List<Offer> offerList =
            (List<Offer>) request.getAttribute("offerList");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Manage Offers</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;
        }

        .header {
            background: #1976d2;
            color: white;
            padding: 20px 35px;
        }

        .header h1 {
            margin: 0;
        }

        .container {
            width: 92%;
            margin: 30px auto;
        }

        .top-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .top-section h2 {
            margin-top: 0;
            color: #1976d2;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        textarea {
            height: 70px;
            resize: vertical;
        }

        .full {
            grid-column: span 2;
        }

        .add-btn {
            background: #1976d2;
            color: white;
            border: none;
            padding: 11px 25px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 10px;
        }

        .add-btn:hover {
            background: #125aa0;
        }

        .table-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #1976d2;
            color: white;
            padding: 12px;
        }

        td {
            padding: 11px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        tr:hover {
            background: #f5f9ff;
        }

        .edit-btn {
            background: #ff9800;
            color: white;
            border: none;
            padding: 7px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        .delete-btn {
            background: #e53935;
            color: white;
            border: none;
            padding: 7px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            background: #555;
            color: white;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .status-active {
            color: green;
            font-weight: bold;
        }

        .status-inactive {
            color: red;
            font-weight: bold;
        }

    </style>

</head>

<body>

<div class="header">
    <h1>Manage Offers</h1>
</div>


<div class="container">

    <!-- ============================= -->
    <!-- ADD OFFER -->
    <!-- ============================= -->

    <div class="top-section">

        <h2>Add New Offer</h2>

        <form action="ManageOfferServlet"
              method="post">

            <input type="hidden"
                   name="action"
                   value="add">

            <div class="form-grid">

                <div>
                    <label>Offer Name</label>

                    <input type="text"
                           name="offerName"
                           placeholder="Example: 20% OFF"
                           required>
                </div>


                <div>
                    <label>Discount Type</label>

                    <select name="discountType"
                            required>

                        <option value="PERCENTAGE">
                            Percentage
                        </option>

                        <option value="FIXED">
                            Fixed
                        </option>

                        <option value="FREE_DELIVERY">
                            Free Delivery
                        </option>

                    </select>
                </div>


                <div class="full">

                    <label>Description</label>

                    <textarea name="description"
                              placeholder="Offer description"></textarea>

                </div>


                <div>

                    <label>Discount Value</label>

                    <input type="number"
                           name="discountValue"
                           step="0.01"
                           placeholder="Example: 20">

                </div>


                <div>

                    <label>Minimum Order</label>

                    <input type="number"
                           name="minimumOrder"
                           step="0.01"
                           placeholder="Example: 2000">

                </div>


                <div>

                    <label>Maximum Discount</label>

                    <input type="number"
                           name="maxDiscount"
                           step="0.01"
                           placeholder="Example: 500">

                </div>


                <div>

                    <label>Status</label>

                    <select name="status">

                        <option value="ACTIVE">
                            ACTIVE
                        </option>

                        <option value="INACTIVE">
                            INACTIVE
                        </option>

                    </select>

                </div>


                <div>

                    <label>Start Date</label>

                    <input type="date"
                           name="startDate">

                </div>


                <div>

                    <label>End Date</label>

                    <input type="date"
                           name="endDate">

                </div>

            </div>


            <button type="submit"
                    class="add-btn">

                Add Offer

            </button>

        </form>

    </div>


    <!-- ============================= -->
    <!-- ALL OFFERS -->
    <!-- ============================= -->

    <div class="table-section">

        <h2>All Offers</h2>

        <table>

            <thead>

                <tr>

                    <th>ID</th>
                    <th>Offer</th>
                    <th>Description</th>
                    <th>Type</th>
                    <th>Value</th>
                    <th>Minimum Order</th>
                    <th>Max Discount</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                    <th>Action</th>

                </tr>

            </thead>


            <tbody>

            <%
                if (offerList != null &&
                    !offerList.isEmpty()) {

                    for (Offer offer : offerList) {
            %>

                <tr>

                    <td>
                        <%= offer.getOfferId() %>
                    </td>

                    <td>
                        <strong>
                            <%= offer.getOfferName() %>
                        </strong>
                    </td>

                    <td>
                        <%= offer.getDescription() %>
                    </td>

                    <td>
                        <%= offer.getDiscountType() %>
                    </td>

                    <td>
                        <%= offer.getDiscountValue() %>
                    </td>

                    <td>
                        ৳ <%= offer.getMinimumOrder() %>
                    </td>

                    <td>
                        ৳ <%= offer.getMaxDiscount() %>
                    </td>

                    <td>
                        <%= offer.getStartDate() %>
                    </td>

                    <td>
                        <%= offer.getEndDate() %>
                    </td>

                    <td>

                        <%
                            if ("ACTIVE".equals(
                                    offer.getStatus())) {
                        %>

                            <span class="status-active">
                                ACTIVE
                            </span>

                        <%
                            } else {
                        %>

                            <span class="status-inactive">
                                INACTIVE
                            </span>

                        <%
                            }
                        %>

                    </td>

                    <td>

                        <!-- DELETE -->

                        <form action="ManageOfferServlet"
                              method="post"
                              style="display:inline;">

                            <input type="hidden"
                                   name="action"
                                   value="delete">

                            <input type="hidden"
                                   name="offerId"
                                   value="<%= offer.getOfferId() %>">

                            <button type="submit"
                                    class="delete-btn"
                                    onclick="return confirm('Delete this offer?');">

                                Delete

                            </button>

                        </form>

                    </td>

                </tr>

            <%
                    }

                } else {
            %>

                <tr>

                    <td colspan="11">

                        No offers available.

                    </td>

                </tr>

            <%
                }
            %>

            </tbody>

        </table>

        <a href="adminDashboard.jsp"
           class="back-btn">

            Back to Dashboard

        </a>

    </div>

</div>

</body>
</html>