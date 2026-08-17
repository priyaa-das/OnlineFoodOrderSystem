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

@WebServlet("/ClaimOfferServlet")
public class ClaimOfferServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        // =============================================
        // LOGIN CHECK
        // =============================================

        User user =
                (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect("login.jsp");

            return;
        }

        // =============================================
        // GET OFFER
        // =============================================

        String offer =
                request.getParameter("offer");

        if (offer == null) {

            session.setAttribute(
                    "offerMessage",
                    "Invalid offer."
            );

            response.sendRedirect(
                    "offers.jsp"
            );

            return;
        }

        // =============================================
        // GET CURRENT CART
        // =============================================

        CartDAO cartDAO =
                new CartDAO();

        List<Cart> cartList =
                cartDAO.getCartItems(
                        user.getUserId()
                );

        double subtotal = 0;

        for (Cart cart : cartList) {

            subtotal +=
                    cart.getPrice()
                    * cart.getQuantity();
        }

        // =============================================
        // CHECK OFFER ELIGIBILITY
        // =============================================

        if (offer.equals("FOOD200")) {

            if (subtotal < 1500) {

                session.setAttribute(
                        "offerMessage",
                        "FOOD200 requires a minimum "
                        + "order of ৳1500."
                );

                response.sendRedirect(
                        "offers.jsp"
                );

                return;
            }
        }

        else if (offer.equals("FREEDELIVERY")) {

            if (subtotal < 2000) {

                session.setAttribute(
                        "offerMessage",
                        "Free Delivery requires a "
                        + "minimum order of ৳2000."
                );

                response.sendRedirect(
                        "offers.jsp"
                );

                return;
            }
        }

        else if (offer.equals("FOOD10")) {

            if (subtotal < 2500) {

                session.setAttribute(
                        "offerMessage",
                        "FOOD10 requires a "
                        + "minimum order of ৳2500."
                );

                response.sendRedirect(
                        "offers.jsp"
                );

                return;
            }
        }

        else {

            session.setAttribute(
                    "offerMessage",
                    "Invalid offer."
            );

            response.sendRedirect(
                    "offers.jsp"
            );

            return;
        }

        // =============================================
        // SAVE CLAIMED OFFER
        // =============================================

        session.setAttribute(
                "claimedOffer",
                offer
        );

        // =============================================
        // SUCCESS MESSAGE
        // =============================================

        String message;

        switch (offer) {

            case "FOOD200":

                message =
                        "Offer claimed successfully! "
                        + "৳200 discount will be applied "
                        + "at checkout.";

                break;

            case "FREEDELIVERY":

                message =
                        "Free Delivery claimed successfully! "
                        + "Delivery charge will be ৳0.";

                break;

            default:

                message =
                        "10% discount claimed successfully! "
                        + "Discount will be applied at checkout.";

                break;
        }

        session.setAttribute(
                "offerMessage",
                message
        );

        response.sendRedirect(
                "offers.jsp"
        );
    }
}