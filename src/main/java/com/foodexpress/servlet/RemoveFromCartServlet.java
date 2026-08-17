package com.foodexpress.servlet;

import com.foodexpress.dao.CartDAO;
import com.foodexpress.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet
        extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        // Check customer login
        User user =
                (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect(
                    "login.jsp"
            );

            return;
        }

        String cartIdString =
                request.getParameter("cartId");

        if (cartIdString == null ||
            cartIdString.trim().isEmpty()) {

            response.sendRedirect(
                    "CartServlet"
            );

            return;
        }

        try {

            int cartId =
                    Integer.parseInt(
                            cartIdString
                    );

            int userId =
                    user.getUserId();

            CartDAO dao =
                    new CartDAO();

            dao.removeFromCart(
                    cartId,
                    userId
            );

            // Back to cart
            response.sendRedirect(
                    "CartServlet"
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "CartServlet"
            );
        }
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}