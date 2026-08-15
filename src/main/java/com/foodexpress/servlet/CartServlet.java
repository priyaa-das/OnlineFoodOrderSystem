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

        int userId =
                user.getUserId();

        CartDAO dao =
                new CartDAO();

        List<Cart> cartList =
                dao.getCartByUserId(userId);

        request.setAttribute(
                "cartList",
                cartList
        );

        request.getRequestDispatcher(
                "cart.jsp"
        ).forward(
                request,
                response
        );
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}