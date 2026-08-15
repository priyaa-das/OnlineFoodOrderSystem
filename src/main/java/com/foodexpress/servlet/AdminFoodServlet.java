package com.foodexpress.servlet;

import com.foodexpress.dao.FoodDAO;
import com.foodexpress.model.Food;
import com.foodexpress.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/AdminFoodServlet")
public class AdminFoodServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        User admin =
                (User) session.getAttribute("admin");

        if (admin == null ||
            !"admin".equalsIgnoreCase(admin.getRole())) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        FoodDAO dao = new FoodDAO();

        List<Food> foodList =
                dao.getAllFoods();

        request.setAttribute(
                "foodList",
                foodList
        );

        request.getRequestDispatcher(
                "manageFood.jsp"
        ).forward(request, response);
    }
}