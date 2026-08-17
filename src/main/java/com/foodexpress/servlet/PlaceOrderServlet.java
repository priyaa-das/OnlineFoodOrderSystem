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

        HttpSession session =
                request.getSession();

        // =================================================
        // LOGIN CHECK
        // =================================================

        User user =
                (User) session.getAttribute("user");

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
                request.getParameter("phone");

        String address =
                request.getParameter("address");

        String paymentMethod =
                request.getParameter("paymentMethod");

        // =================================================
        // VALIDATION
        // =================================================

        if (address == null ||
            address.trim().isEmpty()) {

            response.sendRedirect(
                    "checkout.jsp"
            );

            return;
        }

        if (paymentMethod == null ||
            paymentMethod.trim().isEmpty()) {

            response.sendRedirect(
                    "checkout.jsp"
            );

            return;
        }

        // =================================================
        // GET CART
        // =================================================

        CartDAO cartDAO =
                new CartDAO();

        List<Cart> cartList =
                cartDAO.getCartItems(
                        user.getUserId()
                );

        if (cartList == null ||
            cartList.isEmpty()) {

            response.sendRedirect(
                    "CartServlet"
            );

            return;
        }

        // =================================================
        // SUBTOTAL
        // =================================================

        double subtotal = 0;

        for (Cart cart : cartList) {

            subtotal +=
                    cart.getPrice()
                    * cart.getQuantity();
        }

        // =================================================
        // GET CLAIMED OFFER
        // =================================================

        String claimedOffer =
                (String) session.getAttribute(
                        "claimedOffer"
                );

        // =================================================
        // RESET DISCOUNT
        // =================================================

        double discount = 0;

        double deliveryCharge = 60;

        String appliedOffer = "None";

        // =================================================
        // VALIDATE AND APPLY OFFER
        // =================================================

        if ("FOOD200".equals(claimedOffer)) {

            if (subtotal >= 1500) {

                discount = 200;

                appliedOffer = "FOOD200";
            }
        }

        else if ("FREEDELIVERY".equals(
                claimedOffer)) {

            if (subtotal >= 2000) {

                deliveryCharge = 0;

                appliedOffer = "FREEDELIVERY";
            }
        }

        else if ("FOOD10".equals(
                claimedOffer)) {

            if (subtotal >= 2500) {

                discount =
                        subtotal * 0.10;

                appliedOffer = "FOOD10";
            }
        }

        // =================================================
        // FREE DELIVERY AUTOMATICALLY
        // =================================================

        /*
         * Even without claiming,
         * orders >= 2000 get normal
         * free-delivery eligibility.
         */

        if (subtotal >= 2000) {

            deliveryCharge = 0;
        }

        // =================================================
        // VAT
        // =================================================

        double discountedSubtotal =
                subtotal - discount;

        if (discountedSubtotal < 0) {
            discountedSubtotal = 0;
        }

        double vat =
                discountedSubtotal * 0.05;

        // =================================================
        // GRAND TOTAL
        // =================================================

        double grandTotal =
                discountedSubtotal
                + deliveryCharge
                + vat;

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

        // =================================================
        // PAYMENT STATUS
        // =================================================

        if ("Cash on Delivery".equals(
                paymentMethod)) {

            order.setPaymentStatus(
                    "Pending"
            );

        } else {

            order.setPaymentStatus(
                    "Paid"
            );
        }

        order.setDeliveryAddress(
                address
        );

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

            response.setContentType(
                    "text/html;charset=UTF-8"
            );

            response.getWriter().println(
                    "<h2>Order Error!</h2>" +
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );

            return;
        }

        // =================================================
        // SUCCESS
        // =================================================

        if (orderId > 0) {

            // Remove claimed offer
            session.removeAttribute(
                    "claimedOffer"
            );

            // Save order information
            session.setAttribute(
                    "lastDiscount",
                    discount
            );

            session.setAttribute(
                    "lastOffer",
                    appliedOffer
            );

            session.setAttribute(
                    "lastGrandTotal",
                    grandTotal
            );

            response.sendRedirect(
                    "orderSuccess.jsp?orderId="
                    + orderId
            );

        } else {

            response.setContentType(
                    "text/html;charset=UTF-8"
            );

            response.getWriter().println(
                    "<h2>Order Failed!</h2>" +
                    "<p>Please try again.</p>" +
                    "<a href='CartServlet'>Back to Cart</a>"
            );
        }
    }
}