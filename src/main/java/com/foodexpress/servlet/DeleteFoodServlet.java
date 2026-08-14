package com.foodexpress.servlet;

import com.foodexpress.dao.FoodDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/DeleteFoodServlet")
public class DeleteFoodServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Check admin login
        if (session.getAttribute("admin") == null) {

            response.sendRedirect("adminLogin.jsp");

            return;
        }

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {

            response.sendRedirect("AdminFoodServlet");

            return;
        }

        try {

            int foodId = Integer.parseInt(id);

            FoodDAO dao = new FoodDAO();

            boolean deleted =
                    dao.deleteFood(foodId);

            if (deleted) {

                response.sendRedirect(
                        "AdminFoodServlet?message=deleted"
                );

            } else {

                response.sendRedirect(
                        "AdminFoodServlet?message=failed"
                );
            }

        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "AdminFoodServlet?message=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "AdminFoodServlet?message=error"
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