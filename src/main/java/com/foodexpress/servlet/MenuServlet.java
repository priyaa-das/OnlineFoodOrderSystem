package com.foodexpress.servlet;

import com.foodexpress.dao.FoodDAO;
import com.foodexpress.model.Food;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        FoodDAO dao = new FoodDAO();

        List<Food> foodList = dao.getAllFoods();

        System.out.println("Food Count = " + foodList.size());

        request.setAttribute("foodList", foodList);

        request.getRequestDispatcher("menu.jsp").forward(request, response);
    }
}