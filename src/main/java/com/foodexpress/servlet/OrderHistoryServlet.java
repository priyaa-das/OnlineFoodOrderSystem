package com.foodexpress.servlet;

import com.foodexpress.dao.OrderDAO;
import com.foodexpress.model.Order;
import com.foodexpress.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {

    // ==========================================
    // GET ORDER HISTORY
    // ==========================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        // User login check
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {

            int userId = user.getUserId();

            OrderDAO orderDAO = new OrderDAO();

            List<Order> orderList =
                    orderDAO.getOrdersByUser(userId);

            request.setAttribute(
                    "orderList",
                    orderList
            );

            request.getRequestDispatcher(
                    "orderHistory.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Unable to load order history."
            );

            request.getRequestDispatcher(
                    "orderHistory.jsp"
            ).forward(request, response);
        }
    }


    // ==========================================
    // POST
    // ==========================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}