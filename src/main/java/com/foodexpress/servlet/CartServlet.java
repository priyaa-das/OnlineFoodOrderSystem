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

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    // =====================================================
    // GET - SHOW CART
    // =====================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        // =================================================
        // LOGIN CHECK
        // =================================================

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId =
                user.getUserId();

        System.out.println("================================");
        System.out.println(
                "CartServlet - User ID: " + userId
        );

        CartDAO cartDAO =
                new CartDAO();

        OfferDAO offerDAO =
                new OfferDAO();

        // =================================================
        // GET CART
        // =================================================

        List<Cart> cartList =
                cartDAO.getCartByUserId(userId);

        System.out.println(
                "Cart Items: "
                + (cartList == null
                        ? 0
                        : cartList.size())
        );

        // =================================================
        // CALCULATE SUBTOTAL
        // =================================================

        double subtotal = 0;

        if (cartList != null) {

            for (Cart cart : cartList) {

                subtotal +=
                        cart.getPrice()
                        * cart.getQuantity();
            }
        }

        // =================================================
        // GET ACTIVE OFFERS
        // =================================================

        List<Offer> offerList =
                offerDAO.getActiveOffers();

        // =================================================
        // GET CLAIMED OFFERS
        // =================================================

        List<Offer> claimedOffers =
                offerDAO.getClaimedOffers(userId);

        // =================================================
        // FIND BEST CLAIMED OFFER
        // =================================================

        Offer appliedOffer = null;

        double discountAmount = 0;

        if (claimedOffers != null &&
            !claimedOffers.isEmpty() &&
            subtotal > 0) {

            for (Offer offer : claimedOffers) {

                // -----------------------------------------
                // CHECK ACTIVE STATUS
                // -----------------------------------------

                if (!"ACTIVE".equalsIgnoreCase(
                        offer.getStatus())) {

                    continue;
                }

                // -----------------------------------------
                // CHECK START DATE
                // -----------------------------------------

                java.sql.Date today =
                        new java.sql.Date(
                                System.currentTimeMillis()
                        );

                if (offer.getStartDate() != null &&
                    today.before(
                            offer.getStartDate())) {

                    continue;
                }

                // -----------------------------------------
                // CHECK END DATE
                // -----------------------------------------

                if (offer.getEndDate() != null &&
                    today.after(
                            offer.getEndDate())) {

                    continue;
                }

                // -----------------------------------------
                // CHECK MINIMUM ORDER
                // -----------------------------------------

                if (subtotal <
                    offer.getMinimumOrder()) {

                    continue;
                }

                // -----------------------------------------
                // CALCULATE DISCOUNT
                // -----------------------------------------

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

                // -----------------------------------------
                // APPLY MAX DISCOUNT
                // -----------------------------------------

                if (offer.getMaxDiscount() > 0 &&
                    currentDiscount >
                    offer.getMaxDiscount()) {

                    currentDiscount =
                            offer.getMaxDiscount();
                }

                // -----------------------------------------
                // DISCOUNT CANNOT EXCEED SUBTOTAL
                // -----------------------------------------

                if (currentDiscount > subtotal) {

                    currentDiscount =
                            subtotal;
                }

                // -----------------------------------------
                // SELECT BEST OFFER
                // -----------------------------------------

                if (currentDiscount >
                    discountAmount) {

                    discountAmount =
                            currentDiscount;

                    appliedOffer =
                            offer;
                }
            }
        }

        // =================================================
        // DISCOUNTED SUBTOTAL
        // =================================================

        double discountedSubtotal =
                subtotal - discountAmount;

        if (discountedSubtotal < 0) {
            discountedSubtotal = 0;
        }

        // =================================================
        // DELIVERY CHARGE
        // =================================================

        double deliveryCharge;

        if (discountedSubtotal >= 2000) {

            deliveryCharge = 0;

        } else {

            deliveryCharge = 60;
        }

        // =================================================
        // VAT
        // =================================================

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
        // SEND DATA TO JSP
        // =================================================

        request.setAttribute(
                "cartList",
                cartList
        );

        request.setAttribute(
                "offerList",
                offerList
        );

        request.setAttribute(
                "claimedOffers",
                claimedOffers
        );

        request.setAttribute(
                "appliedOffer",
                appliedOffer
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

        // =================================================
        // CLAIM MESSAGE
        // =================================================

        String claimMessage =
                request.getParameter("claimMessage");

        String claimError =
                request.getParameter("claimError");

        if (claimMessage != null) {

            request.setAttribute(
                    "claimMessage",
                    claimMessage
            );
        }

        if (claimError != null) {

            request.setAttribute(
                    "claimError",
                    claimError
            );
        }

        // =================================================
        // OPEN CART JSP
        // =================================================

        request.getRequestDispatcher(
                "cart.jsp"
        ).forward(
                request,
                response
        );
    }


    // =====================================================
    // POST
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        // =================================================
        // LOGIN CHECK
        // =================================================

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId =
                user.getUserId();

        String action =
                request.getParameter("action");

        CartDAO cartDAO =
                new CartDAO();

        OfferDAO offerDAO =
                new OfferDAO();


        // =================================================
        // ADD TO CART
        // =================================================

        if ("add".equals(action)) {

            String foodIdParam =
                    request.getParameter("foodId");

            String quantityParam =
                    request.getParameter("quantity");

            if (foodIdParam == null ||
                foodIdParam.trim().isEmpty()) {

                response.sendRedirect(
                        "MenuServlet"
                );

                return;
            }

            int foodId =
                    Integer.parseInt(
                            foodIdParam
                    );

            int quantity = 1;

            if (quantityParam != null &&
                !quantityParam.trim().isEmpty()) {

                quantity =
                        Integer.parseInt(
                                quantityParam
                        );
            }

            if (quantity < 1) {
                quantity = 1;
            }

            boolean success =
                    cartDAO.addToCart(
                            userId,
                            foodId,
                            quantity
                    );

            if (success) {

                System.out.println(
                        "Food added to cart successfully"
                );

                response.sendRedirect(
                        "CartServlet"
                );

            } else {

                response.sendRedirect(
                        "MenuServlet?error=cart"
                );
            }

            return;
        }


        // =================================================
        // REMOVE
        // =================================================

        if ("remove".equals(action)) {

            String cartIdParam =
                    request.getParameter("cartId");

            if (cartIdParam != null &&
                !cartIdParam.trim().isEmpty()) {

                int cartId =
                        Integer.parseInt(
                                cartIdParam
                        );

                cartDAO.removeFromCart(
                        cartId,
                        userId
                );
            }

            response.sendRedirect(
                    "CartServlet"
            );

            return;
        }


        // =================================================
        // INCREASE QUANTITY
        // =================================================

        if ("increase".equals(action)) {

            String cartIdParam =
                    request.getParameter("cartId");

            if (cartIdParam != null &&
                !cartIdParam.trim().isEmpty()) {

                int cartId =
                        Integer.parseInt(
                                cartIdParam
                        );

                List<Cart> cartList =
                        cartDAO.getCartByUserId(
                                userId
                        );

                for (Cart cart : cartList) {

                    if (cart.getCartId() ==
                        cartId) {

                        int newQuantity =
                                cart.getQuantity() + 1;

                        cartDAO.updateQuantity(
                                cartId,
                                userId,
                                newQuantity
                        );

                        break;
                    }
                }
            }

            response.sendRedirect(
                    "CartServlet"
            );

            return;
        }


        // =================================================
        // DECREASE QUANTITY
        // =================================================

        if ("decrease".equals(action)) {

            String cartIdParam =
                    request.getParameter("cartId");

            if (cartIdParam != null &&
                !cartIdParam.trim().isEmpty()) {

                int cartId =
                        Integer.parseInt(
                                cartIdParam
                        );

                List<Cart> cartList =
                        cartDAO.getCartByUserId(
                                userId
                        );

                for (Cart cart : cartList) {

                    if (cart.getCartId() ==
                        cartId) {

                        int currentQuantity =
                                cart.getQuantity();

                        if (currentQuantity > 1) {

                            int newQuantity =
                                    currentQuantity - 1;

                            cartDAO.updateQuantity(
                                    cartId,
                                    userId,
                                    newQuantity
                            );
                        }

                        break;
                    }
                }
            }

            response.sendRedirect(
                    "CartServlet"
            );

            return;
        }


        // =================================================
        // CLAIM OFFER
        // =================================================

        if ("claimOffer".equals(action)) {

            String offerIdParam =
                    request.getParameter("offerId");

            if (offerIdParam == null ||
                offerIdParam.trim().isEmpty()) {

                response.sendRedirect(
                        "CartServlet?claimError=Invalid+offer"
                );

                return;
            }

            try {

                int offerId =
                        Integer.parseInt(
                                offerIdParam
                        );

                // -----------------------------------------
                // CHECK OFFER EXISTS
                // -----------------------------------------

                Offer offer =
                        offerDAO.getOfferById(
                                offerId
                        );

                if (offer == null) {

                    response.sendRedirect(
                            "CartServlet?claimError=Offer+not+found"
                    );

                    return;
                }

                // -----------------------------------------
                // CHECK ACTIVE
                // -----------------------------------------

                if (!"ACTIVE".equalsIgnoreCase(
                        offer.getStatus())) {

                    response.sendRedirect(
                            "CartServlet?claimError=Offer+is+not+active"
                    );

                    return;
                }

                // -----------------------------------------
                // CHECK ALREADY CLAIMED
                // -----------------------------------------

                boolean alreadyClaimed =
                        offerDAO.hasClaimed(
                                userId,
                                offerId
                        );

                if (alreadyClaimed) {

                    response.sendRedirect(
                            "CartServlet?claimError=Offer+already+claimed"
                    );

                    return;
                }

                // -----------------------------------------
                // CLAIM
                // -----------------------------------------

                boolean success =
                        offerDAO.claimOffer(
                                userId,
                                offerId
                        );

                if (success) {

                    System.out.println(
                            "Offer claimed successfully. "
                            + "User ID: "
                            + userId
                            + ", Offer ID: "
                            + offerId
                    );

                    response.sendRedirect(
                            "CartServlet?claimMessage=Offer+claimed+successfully"
                    );

                } else {

                    response.sendRedirect(
                            "CartServlet?claimError=Could+not+claim+offer"
                    );
                }

            } catch (NumberFormatException e) {

                e.printStackTrace();

                response.sendRedirect(
                        "CartServlet?claimError=Invalid+offer+ID"
                );
            }

            return;
        }


        // =================================================
        // UNKNOWN ACTION
        // =================================================

        response.sendRedirect(
                "CartServlet"
        );
    }
}