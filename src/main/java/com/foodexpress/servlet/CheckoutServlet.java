package com.foodexpress.servlet;

import com.foodexpress.dao.CartDAO;
import com.foodexpress.model.Cart;
import com.foodexpress.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect("login.jsp");
            return;
        }

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

        double subtotal = 0;

        for (Cart cart : cartList) {

            subtotal +=
                    cart.getTotalPrice();
        }

        double deliveryCharge;

        if (subtotal >= 2000) {

            deliveryCharge = 0;

        } else {

            deliveryCharge = 60;
        }

        double vat =
                subtotal * 0.05;

        double grandTotal =
                subtotal +
                deliveryCharge +
                vat;

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

        request.getRequestDispatcher(
                "checkout.jsp"
        ).forward(
                request,
                response
        );
    }
}