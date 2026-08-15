/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.foodexpress.servlet;

import com.foodexpress.dao.FoodDAO;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddFoodServlet")
public class AddFoodServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int categoryId =
                Integer.parseInt(
                        request.getParameter(
                                "categoryId"
                        )
                );

        String foodName =
                request.getParameter(
                        "foodName"
                );

        String description =
                request.getParameter(
                        "description"
                );

        double price =
                Double.parseDouble(
                        request.getParameter(
                                "price"
                        )
                );

        String imageUrl =
                request.getParameter(
                        "imageUrl"
                );

        String status =
                request.getParameter(
                        "status"
                );

        FoodDAO dao =
                new FoodDAO();

        boolean result =
                dao.addFood(
                        categoryId,
                        foodName,
                        description,
                        price,
                        imageUrl,
                        status
                );

        if (result) {

            response.sendRedirect(
                    "AdminFoodServlet"
            );

        } else {

            response.getWriter().println(
                    "<h2>Food Add Failed!</h2>" +
                    "<a href='addFood.jsp'>Back</a>"
            );
        }
    }
}