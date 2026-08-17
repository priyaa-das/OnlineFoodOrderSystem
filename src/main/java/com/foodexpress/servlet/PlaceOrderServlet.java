package com.foodexpress.servlet;

import com.foodexpress.dao.CartDAO;
import com.foodexpress.dao.OrderDAO;
import com.foodexpress.model.Cart;
import com.foodexpress.model.Order;
import com.foodexpress.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    // =====================================================
    // PLACE ORDER
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println(
                "========== PLACE ORDER SERVLET CALLED =========="
        );

        // =================================================
        // GET SESSION
        // =================================================

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        // User login check
        if (user == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        int userId = user.getUserId();

        System.out.println(
                "User ID = " + userId
        );

        // =================================================
        // GET FORM DATA
        // =================================================

        String phone =
                request.getParameter("phone");

        String address =
                request.getParameter("address");

        String paymentMethod =
                request.getParameter("paymentMethod");

        System.out.println(
                "Phone = " + phone
        );

        System.out.println(
                "Address = " + address
        );

        System.out.println(
                "Payment Method = " + paymentMethod
        );

        // =================================================
        // VALIDATE ADDRESS
        // =================================================

        if (address == null ||
                address.trim().isEmpty()) {

            response.setContentType(
                    "text/html;charset=UTF-8"
            );

            response.getWriter().println(
                    "<html>" +
                    "<head>" +
                    "<title>Order Error</title>" +
                    "</head>" +
                    "<body>" +

                    "<h2>Delivery address is required!</h2>" +

                    "<a href='" +
                    request.getContextPath() +
                    "/CheckoutServlet'>" +
                    "Back to Checkout" +
                    "</a>" +

                    "</body>" +
                    "</html>"
            );

            return;
        }

        // =================================================
        // VALIDATE PAYMENT METHOD
        // =================================================

        if (paymentMethod == null ||
                paymentMethod.trim().isEmpty()) {

            response.setContentType(
                    "text/html;charset=UTF-8"
            );

            response.getWriter().println(
                    "<html>" +
                    "<head>" +
                    "<title>Order Error</title>" +
                    "</head>" +
                    "<body>" +

                    "<h2>Please select a payment method!</h2>" +

                    "<a href='" +
                    request.getContextPath() +
                    "/CheckoutServlet'>" +
                    "Back to Checkout" +
                    "</a>" +

                    "</body>" +
                    "</html>"
            );

            return;
        }

        // =================================================
        // GET CART ITEMS
        // =================================================

        CartDAO cartDAO =
                new CartDAO();

        List<Cart> cartList =
                cartDAO.getCartItems(userId);

        System.out.println(
                "Cart Size = " +
                (cartList == null
                        ? "null"
                        : cartList.size())
        );

        // =================================================
        // CHECK CART
        // =================================================

        if (cartList == null ||
                cartList.isEmpty()) {

            response.setContentType(
                    "text/html;charset=UTF-8"
            );

            response.getWriter().println(
                    "<html>" +
                    "<head>" +
                    "<title>Empty Cart</title>" +
                    "</head>" +
                    "<body>" +

                    "<h2>Your cart is empty!</h2>" +

                    "<a href='" +
                    request.getContextPath() +
                    "/MenuServlet'>" +
                    "Go to Menu" +
                    "</a>" +

                    "</body>" +
                    "</html>"
            );

            return;
        }

        // =================================================
        // CALCULATE SUBTOTAL
        // =================================================

        double subtotal = 0.0;

        for (Cart cart : cartList) {

            double price =
                    cart.getPrice();

            int quantity =
                    cart.getQuantity();

            double itemTotal =
                    price * quantity;

            subtotal += itemTotal;

            System.out.println(
                    "Food = " +
                    cart.getFoodName() +

                    " | Price = " +
                    price +

                    " | Quantity = " +
                    quantity +

                    " | Item Total = " +
                    itemTotal
            );
        }

        // =================================================
        // DELIVERY CHARGE
        // =================================================

        double deliveryCharge;

        if (subtotal >= 2000) {

            deliveryCharge = 0.0;

        } else {

            deliveryCharge = 60.0;
        }

        // =================================================
        // VAT 5%
        // =================================================

        double vat =
                subtotal * 0.05;

        // =================================================
        // GRAND TOTAL
        // =================================================

        double grandTotal =
                subtotal +
                deliveryCharge +
                vat;

        System.out.println(
                "Subtotal = " +
                subtotal
        );

        System.out.println(
                "Delivery Charge = " +
                deliveryCharge
        );

        System.out.println(
                "VAT = " +
                vat
        );

        System.out.println(
                "Grand Total = " +
                grandTotal
        );

        // =================================================
        // CREATE ORDER OBJECT
        // =================================================

        Order order =
                new Order();

        order.setUserId(userId);

        order.setTotalAmount(
                grandTotal
        );

        // Initial order status
        order.setOrderStatus(
                "Pending"
        );

        // =================================================
        // PAYMENT STATUS
        // =================================================

        if (paymentMethod.equalsIgnoreCase(
                "Cash on Delivery")) {

            order.setPaymentStatus(
                    "Pending"
            );

        } else {

            order.setPaymentStatus(
                    "Paid"
            );
        }

        // =================================================
        // DELIVERY ADDRESS
        // =================================================

        order.setDeliveryAddress(
                address.trim()
        );

        // =================================================
        // PLACE ORDER USING DAO
        // =================================================

        OrderDAO orderDAO =
                new OrderDAO();

        int orderId;

        try {

            orderId =
                    orderDAO.placeOrder(
                            order,
                            cartList,
                            paymentMethod
                    );

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8"
            );

            response.getWriter().println(
                    "<html>" +
                    "<head>" +
                    "<title>Order Error</title>" +
                    "</head>" +
                    "<body>" +

                    "<h2>Order Error!</h2>" +

                    "<p>" +
                    e.getMessage() +
                    "</p>" +

                    "<br>" +

                    "<a href='" +
                    request.getContextPath() +
                    "/CartServlet'>" +
                    "Back to Cart" +
                    "</a>" +

                    "</body>" +
                    "</html>"
            );

            return;
        }

        // =================================================
        // ORDER SUCCESS
        // =================================================

        if (orderId > 0) {

            System.out.println(
                    "================================="
            );

            System.out.println(
                    "ORDER SUCCESSFULLY PLACED"
            );

            System.out.println(
                    "Order ID = " +
                    orderId
            );

            System.out.println(
                    "User ID = " +
                    userId
            );

            System.out.println(
                    "Grand Total = " +
                    grandTotal
            );

            System.out.println(
                    "================================="
            );

            // Send order ID to success page
            response.sendRedirect(
                    request.getContextPath()
                    + "/orderSuccess.jsp?orderId="
                    + orderId
            );

        } else {

            // =================================================
            // ORDER FAILED
            // =================================================

            System.out.println(
                    "OrderDAO returned invalid Order ID: "
                    + orderId
            );

            response.setContentType(
                    "text/html;charset=UTF-8"
            );

            response.getWriter().println(
                    "<html>" +

                    "<head>" +

                    "<title>Order Failed</title>" +

                    "<style>" +

                    "body{" +
                    "font-family:Arial;" +
                    "background:#f5f7fb;" +
                    "text-align:center;" +
                    "padding-top:100px;" +
                    "}" +

                    ".box{" +
                    "background:white;" +
                    "width:450px;" +
                    "margin:auto;" +
                    "padding:40px;" +
                    "border-radius:12px;" +
                    "box-shadow:0 5px 20px rgba(0,0,0,0.1);" +
                    "}" +

                    "h2{" +
                    "color:#dc2626;" +
                    "}" +

                    "a{" +
                    "display:inline-block;" +
                    "margin-top:20px;" +
                    "padding:12px 25px;" +
                    "background:#2196F3;" +
                    "color:white;" +
                    "text-decoration:none;" +
                    "border-radius:6px;" +
                    "}" +

                    "</style>" +

                    "</head>" +

                    "<body>" +

                    "<div class='box'>" +

                    "<h2>Order Failed!</h2>" +

                    "<p>" +
                    "Unable to place your order." +
                    "</p>" +

                    "<p>" +
                    "Please try again." +
                    "</p>" +

                    "<a href='" +
                    request.getContextPath() +
                    "/CartServlet'>" +
                    "Back to Cart" +
                    "</a>" +

                    "</div>" +

                    "</body>" +

                    "</html>"
            );
        }
    }
}