package com.foodexpress.servlet;

import com.foodexpress.dao.CartDAO;
import com.foodexpress.dao.OrderDAO;
import com.foodexpress.model.Cart;
import com.foodexpress.model.Order;
import com.foodexpress.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        System.out.println(
                "========== PLACE ORDER =========="
        );


        // =================================================
        // SESSION
        // =================================================

        HttpSession session =
                request.getSession();


        User user =
                (User) session.getAttribute(
                        "user"
                );


        if (user == null) {

            response.sendRedirect(
                    "login.jsp"
            );

            return;
        }


        // =================================================
        // FORM DATA
        // =================================================

        String phone =
                request.getParameter(
                        "phone"
                );


        String address =
                request.getParameter(
                        "address"
                );


        String paymentMethod =
                request.getParameter(
                        "paymentMethod"
                );


        String deliveryMethod =
                request.getParameter(
                        "deliveryMethod"
                );


        String pickupTime =
                request.getParameter(
                        "pickupTime"
                );


        // =================================================
        // VALIDATION
        // =================================================

        if (deliveryMethod == null ||
                deliveryMethod.trim().isEmpty()) {

            showError(
                    response,
                    "Please select Pickup or Delivery."
            );

            return;
        }


        if (paymentMethod == null ||
                paymentMethod.trim().isEmpty()) {

            showError(
                    response,
                    "Please select a payment method."
            );

            return;
        }


        // =================================================
        // DELIVERY VALIDATION
        // =================================================

        if (deliveryMethod.equalsIgnoreCase("Delivery")) {

            if (address == null ||
                    address.trim().isEmpty()) {

                showError(
                        response,
                        "Delivery address is required."
                );

                return;
            }
        }


        // =================================================
        // PICKUP VALIDATION
        // =================================================

        if (deliveryMethod.equalsIgnoreCase("Pickup")) {

            if (pickupTime == null ||
                    pickupTime.trim().isEmpty()) {

                showError(
                        response,
                        "Please select a pickup time."
                );

                return;
            }
        }


        // =================================================
        // CART
        // =================================================

        CartDAO cartDAO =
                new CartDAO();


        List<Cart> cartList =
                cartDAO.getCartItems(
                        user.getUserId()
                );


        if (cartList == null ||
                cartList.isEmpty()) {

            showError(
                    response,
                    "Your cart is empty."
            );

            return;
        }


        // =================================================
        // CALCULATE SUBTOTAL
        // =================================================

        double subtotal = 0;


        for (Cart cart : cartList) {

            double itemTotal =
                    cart.getPrice()
                    * cart.getQuantity();


            subtotal += itemTotal;
        }


        // =================================================
        // DELIVERY CHARGE
        // =================================================

        double deliveryCharge = 0;


        if (deliveryMethod.equalsIgnoreCase(
                "Delivery")) {

            if (subtotal >= 2000) {

                deliveryCharge = 0;

            } else {

                deliveryCharge = 60;
            }
        }


        // =================================================
        // VAT
        // =================================================

        double vat =
                subtotal * 0.05;


        // =================================================
        // GRAND TOTAL
        // =================================================

        double grandTotal =
                subtotal
                + deliveryCharge
                + vat;


        // =================================================
        // ESTIMATED DELIVERY TIME
        // =================================================

        String estimatedDeliveryTime =
                null;


        if (deliveryMethod.equalsIgnoreCase(
                "Delivery")) {


            /*
             * Simple dynamic delivery estimate
             * based on address text.
             */

            String lowerAddress =
                    address.toLowerCase();


            if (lowerAddress.contains("sylhet")
                    || lowerAddress.contains("amberkhana")
                    || lowerAddress.contains("zindabazar")
                    || lowerAddress.contains("bondor")
                    || lowerAddress.contains("mirabazar")) {

                estimatedDeliveryTime =
                        "25 - 35 minutes";

            } else if (
                    lowerAddress.contains("moulvibazar")
                    || lowerAddress.contains("beanibazar")
                    || lowerAddress.contains("golapganj")) {

                estimatedDeliveryTime =
                        "45 - 60 minutes";

            } else {

                estimatedDeliveryTime =
                        "45 - 75 minutes";
            }
        }


        // =================================================
        // PAYMENT STATUS
        // =================================================

        String paymentStatus;


        if (paymentMethod.equalsIgnoreCase(
                "Cash on Delivery")) {

            paymentStatus =
                    "Pending";

        } else {

            paymentStatus =
                    "Paid";
        }


        // =================================================
        // CREATE ORDER
        // =================================================

        Order order =
                new Order();


        order.setUserId(
                user.getUserId()
        );


        order.setTotalAmount(
                grandTotal
        );


        order.setOrderStatus(
                "Pending"
        );


        order.setPaymentStatus(
                paymentStatus
        );


        order.setDeliveryAddress(
                address
        );


        // IMPORTANT
        order.setDeliveryMethod(
                deliveryMethod
        );


        if (deliveryMethod.equalsIgnoreCase(
                "Pickup")) {

            order.setPickupTime(
                    pickupTime
            );

            order.setEstimatedDeliveryTime(
                    null
            );

        } else {

            order.setPickupTime(
                    null
            );

            order.setEstimatedDeliveryTime(
                    estimatedDeliveryTime
            );
        }


        // =================================================
        // SAVE ORDER
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


            showError(
                    response,
                    "Order could not be placed. Check NetBeans Output."
            );

            return;
        }


        // =================================================
        // SUCCESS
        // =================================================

        if (orderId > 0) {

            System.out.println(
                    "Order ID = "
                    + orderId
            );


            response.sendRedirect(
                    "orderSuccess.jsp?orderId="
                    + orderId
                    + "&total="
                    + String.format(
                            "%.2f",
                            grandTotal
                    )
            );


        } else {


            showError(
                    response,
                    "Order Failed! Please try again."
            );
        }
    }


    // =====================================================
    // ERROR PAGE
    // =====================================================

    private void showError(
            HttpServletResponse response,
            String message)
            throws IOException {


        response.setContentType(
                "text/html;charset=UTF-8"
        );


        response.getWriter().println(

                "<html>" +

                "<head>" +

                "<title>Order Error</title>" +

                "<style>" +

                "body{" +
                "font-family:Arial;" +
                "background:#f5f7fb;" +
                "text-align:center;" +
                "padding-top:100px;" +
                "}" +

                ".box{" +
                "background:white;" +
                "width:500px;" +
                "margin:auto;" +
                "padding:35px;" +
                "border-radius:15px;" +
                "box-shadow:0 5px 20px rgba(0,0,0,.1);" +
                "}" +

                "a{" +
                "display:inline-block;" +
                "margin-top:20px;" +
                "padding:12px 25px;" +
                "background:#4f8cff;" +
                "color:white;" +
                "text-decoration:none;" +
                "border-radius:8px;" +
                "}" +

                "</style>" +

                "</head>" +

                "<body>" +

                "<div class='box'>" +

                "<h2>Order Error</h2>" +

                "<p>"
                + message +
                "</p>" +

                "<a href='CartServlet'>Back to Cart</a>" +

                "</div>" +

                "</body>" +

                "</html>"
        );
    }
}