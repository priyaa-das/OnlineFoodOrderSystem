package com.foodexpress.servlet;

import com.foodexpress.dao.CartDAO;
import com.foodexpress.model.Cart;
import com.foodexpress.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =====================================================
        // GET SESSION
        // =====================================================

        HttpSession session =
                request.getSession();

        // =====================================================
        // GET LOGGED USER
        // =====================================================

        User user =
                (User) session.getAttribute("user");

        // =====================================================
        // CHECK LOGIN
        // =====================================================

        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }

        // =====================================================
        // GET CART
        // =====================================================

        CartDAO cartDAO =
                new CartDAO();

        List<Cart> cartList =
                cartDAO.getCartItems(
                        user.getUserId()
                );

        // =====================================================
        // CHECK EMPTY CART
        // =====================================================

        if (cartList == null ||
                cartList.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/CartServlet"
            );

            return;
        }

        // =====================================================
        // CALCULATE SUBTOTAL
        // =====================================================

        double subtotal = 0;

        for (Cart cart : cartList) {

            subtotal +=
                    cart.getTotalPrice();
        }

        // =====================================================
        // DELIVERY CHARGE
        // =====================================================

        double deliveryCharge;

        if (subtotal >= 2000) {

            deliveryCharge = 0;

        } else {

            deliveryCharge = 60;
        }

        // =====================================================
        // VAT 5%
        // =====================================================

        double vat =
                subtotal * 0.05;

        // =====================================================
        // GRAND TOTAL
        // =====================================================

        double grandTotal =
                subtotal
                + deliveryCharge
                + vat;

        // =====================================================
        // SEND DATA TO JSP
        // =====================================================

        request.setAttribute(
                "cartList",
                cartList
        );

        request.setAttribute(
                "subtotal",
                subtotal
        );

        request.setAttribute(
                "deliveryCharge",
                deliveryCharge
        );

        request.setAttribute(
                "vat",
                vat
        );

        request.setAttribute(
                "grandTotal",
                grandTotal
        );

        // =====================================================
        // OPEN CHECKOUT PAGE
        // =====================================================

        request.getRequestDispatcher(
                "checkout.jsp"
        ).forward(
                request,
                response
        );
    }
}