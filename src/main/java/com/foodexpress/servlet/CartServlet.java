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
                request.getSession();

        User user =
                (User) session.getAttribute("user");


        // Login check
        if (user == null) {

            response.sendRedirect("login.jsp");
            return;
        }


        int userId =
                user.getUserId();


        System.out.println(
                "================================"
        );

        System.out.println(
                "CartServlet - User ID: "
                + userId
        );


        CartDAO dao =
                new CartDAO();


        // Get cart from DATABASE
        List<Cart> cartList =
                dao.getCartByUserId(userId);


        System.out.println(
                "Cart Items: "
                + (cartList == null
                   ? 0
                   : cartList.size())
        );


        // Send cart to JSP
        request.setAttribute(
                "cartList",
                cartList
        );


        // Open cart.jsp
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
                request.getSession();


        User user =
                (User) session.getAttribute("user");


        // Login check
        if (user == null) {

            response.sendRedirect("login.jsp");
            return;
        }


        int userId =
                user.getUserId();


        String action =
                request.getParameter("action");


        CartDAO dao =
                new CartDAO();


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
                    dao.addToCart(
                            userId,
                            foodId,
                            quantity
                    );


            if (success) {

                System.out.println(
                        "Food added to cart successfully"
                );


                /*
                 * IMPORTANT:
                 * CartServlet দিয়ে redirect করছি।
                 * সরাসরি cart.jsp নয়।
                 */
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


                dao.removeFromCart(
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
                        dao.getCartByUserId(
                                userId
                        );


                for (Cart cart : cartList) {


                    if (cart.getCartId() ==
                        cartId) {


                        int newQuantity =
                                cart.getQuantity() + 1;


                        dao.updateQuantity(
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
                        dao.getCartByUserId(
                                userId
                        );


                for (Cart cart : cartList) {


                    if (cart.getCartId() ==
                        cartId) {


                        int currentQuantity =
                                cart.getQuantity();


                        /*
                         * Quantity 1 হলে
                         * আর কমবে না
                         */

                        if (currentQuantity > 1) {


                            int newQuantity =
                                    currentQuantity - 1;


                            dao.updateQuantity(
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
        // UNKNOWN ACTION
        // =================================================

        response.sendRedirect(
                "CartServlet"
        );
    }
}