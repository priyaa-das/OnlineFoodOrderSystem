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

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("===== AddToCartServlet CALLED =====");

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {

            System.out.println("USER IS NULL");

            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println(
                "Logged User ID = " + user.getUserId()
        );

        String foodIdText =
                request.getParameter("foodId");

        System.out.println(
                "Food ID = " + foodIdText
        );

        if (foodIdText == null ||
            foodIdText.trim().isEmpty()) {

            response.getWriter().println(
                    "Food ID is missing!"
            );

            return;
        }

        try {

            int foodId =
                    Integer.parseInt(foodIdText);

            CartDAO dao =
                    new CartDAO();

            boolean result =
                    dao.addToCart(
                            user.getUserId(),
                            foodId
                    );

            System.out.println(
                    "Add To Cart Result = " + result
            );

            if (result) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/CartServlet"
                );

            } else {

                response.getWriter().println(
                        "<h2>Failed to add food to cart!</h2>"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h2>Error: "
                    + e.getMessage()
                    + "</h2>"
            );
        }
    }
}