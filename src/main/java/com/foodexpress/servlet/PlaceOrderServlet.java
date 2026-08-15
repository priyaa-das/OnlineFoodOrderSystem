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
                "========== PLACE ORDER SERVLET CALLED =========="
        );


        // =================================================
        // GET SESSION
        // =================================================

        HttpSession session =
                request.getSession();


        User user =
                (User) session.getAttribute("user");


        if (user == null) {

            response.sendRedirect(
                    "login.jsp"
            );

            return;
        }


        System.out.println(
                "User ID = "
                + user.getUserId()
        );


        // =================================================
        // GET FORM DATA
        // =================================================

        String phone =
                request.getParameter("phone");


        String address =
                request.getParameter("address");


        String paymentMethod =
                request.getParameter(
                        "paymentMethod"
                );


        System.out.println(
                "Phone = " + phone
        );


        System.out.println(
                "Address = " + address
        );


        System.out.println(
                "Payment Method = "
                + paymentMethod
        );


        // =================================================
        // VALIDATION
        // =================================================

        if (address == null ||
            address.trim().isEmpty()) {

            response.setContentType(
                    "text/html;charset=UTF-8"
            );


            response.getWriter().println(
                    "<h2>Delivery address is required!</h2>" +
                    "<a href='CheckoutServlet'>Back to Checkout</a>"
            );


            return;
        }


        if (paymentMethod == null ||
            paymentMethod.trim().isEmpty()) {

            response.setContentType(
                    "text/html;charset=UTF-8"
            );


            response.getWriter().println(
                    "<h2>Please select a payment method!</h2>" +
                    "<a href='CheckoutServlet'>Back to Checkout</a>"
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


        System.out.println(
                "Cart size = "
                + (cartList == null
                ? "null"
                : cartList.size())
        );


        if (cartList == null ||
            cartList.isEmpty()) {

            response.setContentType(
                    "text/html;charset=UTF-8"
            );


            response.getWriter().println(
                    "<h2>Your cart is empty!</h2>" +
                    "<a href='MenuServlet'>Go to Menu</a>"
            );


            return;
        }


        // =================================================
        // CALCULATE TOTAL
        // =================================================

        double subtotal = 0;


        for (Cart cart : cartList) {

            double itemTotal =
                    cart.getPrice()
                    * cart.getQuantity();


            subtotal += itemTotal;


            System.out.println(
                    "Food = "
                    + cart.getFoodName()
                    + " | Price = "
                    + cart.getPrice()
                    + " | Qty = "
                    + cart.getQuantity()
                    + " | Total = "
                    + itemTotal
            );
        }


        // =================================================
        // DELIVERY CHARGE
        // =================================================

        double deliveryCharge;


        if (subtotal >= 2000) {

            deliveryCharge = 0;

        } else {

            deliveryCharge = 60;
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


        System.out.println(
                "Subtotal = "
                + subtotal
        );


        System.out.println(
                "Delivery = "
                + deliveryCharge
        );


        System.out.println(
                "VAT = "
                + vat
        );


        System.out.println(
                "Grand Total = "
                + grandTotal
        );


        // =================================================
        // CREATE ORDER OBJECT
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


        if (paymentMethod.equals(
                "Cash on Delivery")) {

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
        // PLACE ORDER
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
                    "<pre>" +
                    e.toString() +
                    "</pre>" +
                    "<a href='CartServlet'>Back to Cart</a>"
            );


            return;
        }


        // =================================================
        // SUCCESS
        // =================================================

        if (orderId > 0) {

            System.out.println(
                    "Order successfully placed."
            );


            response.sendRedirect(
                    "orderSuccess.jsp?orderId="
                    + orderId
            );


        } else {

            System.out.println(
                    "OrderDAO returned -1."
            );


            response.setContentType(
                    "text/html;charset=UTF-8"
            );


            response.getWriter().println(
                    "<html>" +
                    "<head>" +
                    "<title>Order Failed</title>" +
                    "</head>" +
                    "<body>" +

                    "<h2>Order Failed!</h2>" +

                    "<p>" +
                    "OrderDAO returned -1." +
                    "</p>" +

                    "<p>" +
                    "Please check NetBeans Output." +
                    "</p>" +

                    "<br>" +

                    "<a href='CartServlet'>" +
                    "Back to Cart" +
                    "</a>" +

                    "</body>" +
                    "</html>"
            );
        }
    }
}