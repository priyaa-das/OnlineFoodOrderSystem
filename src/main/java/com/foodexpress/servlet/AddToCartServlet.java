package com.foodexpress.servlet;

import com.foodexpress.dao.CartDAO;
import com.foodexpress.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect("login.jsp");
            return;

        }

        int foodId = Integer.parseInt(request.getParameter("foodId"));

        CartDAO dao = new CartDAO();

        boolean status = dao.addToCart(user.getUserId(), foodId);

        if (status) {

            response.sendRedirect("MenuServlet");

        } else {

            response.getWriter().println("Failed to add item to cart.");

        }

    }
}