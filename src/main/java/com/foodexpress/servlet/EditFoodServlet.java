package com.foodexpress.servlet;

import com.foodexpress.dao.FoodDAO;
import com.foodexpress.model.Food;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/EditFoodServlet")
public class EditFoodServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("AdminFoodServlet");
            return;
        }

        try {

            int foodId = Integer.parseInt(id);

            FoodDAO dao = new FoodDAO();

            Food food = dao.getFoodById(foodId);

            if (food == null) {
                response.sendRedirect("AdminFoodServlet");
                return;
            }

            request.setAttribute("food", food);

            request.getRequestDispatcher(
                    "editFood.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect("AdminFoodServlet");
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int foodId = Integer.parseInt(
                    request.getParameter("foodId")
            );

            int categoryId = Integer.parseInt(
                    request.getParameter("categoryId")
            );

            String foodName =
                    request.getParameter("foodName");

            String description =
                    request.getParameter("description");

            double price = Double.parseDouble(
                    request.getParameter("price")
            );

            String imageUrl =
                    request.getParameter("imageUrl");

            String status =
                    request.getParameter("status");

            Food food = new Food();

            food.setFoodId(foodId);
            food.setCategoryId(categoryId);
            food.setFoodName(foodName);
            food.setDescription(description);
            food.setPrice(price);
            food.setImageUrl(imageUrl);
            food.setStatus(status);

            FoodDAO dao = new FoodDAO();

            boolean result = dao.updateFood(food);

            if (result) {

                response.sendRedirect(
                        "AdminFoodServlet"
                );

            } else {

                response.sendRedirect(
                        "EditFoodServlet?id=" + foodId
                        + "&error=update"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "AdminFoodServlet"
            );
        }
    }
}