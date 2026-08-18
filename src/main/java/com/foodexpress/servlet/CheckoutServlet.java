package com.foodexpress.servlet;

import com.foodexpress.dao.CartDAO;
import com.foodexpress.dao.OfferDAO;
import com.foodexpress.model.Cart;
import com.foodexpress.model.Offer;
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

        // =====================================================
        // LOGIN CHECK
        // =====================================================

        if (user == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        int userId =
                user.getUserId();

        // =====================================================
        // GET CART
        // =====================================================

        CartDAO cartDAO =
                new CartDAO();

        List<Cart> cartList =
                cartDAO.getCartItems(userId);

        if (cartList == null ||
            cartList.isEmpty()) {

            response.sendRedirect(
                    "CartServlet"
            );

            return;
        }

        // =====================================================
        // CALCULATE SUBTOTAL
        // =====================================================

        double subtotal = 0;

        for (Cart cart : cartList) {

            subtotal +=
                    cart.getPrice()
                    * cart.getQuantity();
        }

        // =====================================================
        // GET CLAIMED OFFERS
        // =====================================================

        OfferDAO offerDAO =
                new OfferDAO();

        List<Offer> claimedOffers =
                offerDAO.getClaimedOffers(userId);

        // =====================================================
        // FIND BEST ELIGIBLE OFFER
        // =====================================================

        Offer appliedOffer = null;

        double discountAmount = 0;

        if (claimedOffers != null &&
            !claimedOffers.isEmpty()) {

            for (Offer offer : claimedOffers) {

                // -------------------------------------------------
                // CHECK STATUS
                // -------------------------------------------------

                if (!"ACTIVE".equalsIgnoreCase(
                        offer.getStatus())) {

                    continue;
                }

                // -------------------------------------------------
                // CHECK MINIMUM ORDER
                // -------------------------------------------------

                if (subtotal <
                    offer.getMinimumOrder()) {

                    continue;
                }

                // -------------------------------------------------
                // CHECK DATE
                // -------------------------------------------------

                if (offer.getStartDate() != null) {

                    java.sql.Date today =
                            new java.sql.Date(
                                    System.currentTimeMillis()
                            );

                    if (today.before(
                            offer.getStartDate())) {

                        continue;
                    }
                }

                if (offer.getEndDate() != null) {

                    java.sql.Date today =
                            new java.sql.Date(
                                    System.currentTimeMillis()
                            );

                    if (today.after(
                            offer.getEndDate())) {

                        continue;
                    }
                }

                // -------------------------------------------------
                // CALCULATE OFFER DISCOUNT
                // -------------------------------------------------

                double currentDiscount = 0;

                String discountType =
                        offer.getDiscountType();

                if (discountType != null &&
                    "PERCENTAGE".equalsIgnoreCase(
                            discountType)) {

                    currentDiscount =
                            subtotal
                            * offer.getDiscountValue()
                            / 100.0;

                } else {

                    // FIXED DISCOUNT

                    currentDiscount =
                            offer.getDiscountValue();
                }

                // -------------------------------------------------
                // APPLY MAX DISCOUNT
                // -------------------------------------------------

                if (offer.getMaxDiscount() > 0 &&
                    currentDiscount >
                    offer.getMaxDiscount()) {

                    currentDiscount =
                            offer.getMaxDiscount();
                }

                // -------------------------------------------------
                // DISCOUNT CANNOT EXCEED SUBTOTAL
                // -------------------------------------------------

                if (currentDiscount > subtotal) {

                    currentDiscount = subtotal;
                }

                // -------------------------------------------------
                // SELECT BEST OFFER
                // -------------------------------------------------

                if (currentDiscount > discountAmount) {

                    discountAmount =
                            currentDiscount;

                    appliedOffer =
                            offer;
                }
            }
        }

        // =====================================================
        // DISCOUNTED SUBTOTAL
        // =====================================================

        double discountedSubtotal =
                subtotal - discountAmount;

        // =====================================================
        // DELIVERY CHARGE
        // =====================================================

        double deliveryCharge;

        if (discountedSubtotal >= 2000) {

            deliveryCharge = 0;

        } else {

            deliveryCharge = 60;
        }

        // =====================================================
        // VAT
        // =====================================================

        double vat =
                discountedSubtotal * 0.05;

        // =====================================================
        // GRAND TOTAL
        // =====================================================

        double grandTotal =
                discountedSubtotal
                + deliveryCharge
                + vat;

        // =====================================================
        // SEND DATA TO CHECKOUT JSP
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
                "discountAmount",
                discountAmount
        );

        request.setAttribute(
                "discountedSubtotal",
                discountedSubtotal
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

        request.setAttribute(
                "appliedOffer",
                appliedOffer
        );

        request.setAttribute(
                "claimedOffers",
                claimedOffers
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