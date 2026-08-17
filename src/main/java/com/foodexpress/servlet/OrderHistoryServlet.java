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

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("========== ORDER HISTORY SERVLET ==========");

        // ==============================
        // GET SESSION
        // ==============================

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ==============================
        // GET LOGGED-IN USER
        // ==============================

        User user = (User) session.getAttribute("user");

        if (user == null) {

            System.out.println("User not logged in.");

            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println(
                "Logged-in User ID = "
                + user.getUserId()
        );

        // ==============================
        // GET ORDERS
        // ==============================

        OrderDAO orderDAO = new OrderDAO();

        List<Order> orderList =
                orderDAO.getOrdersByUser(
                        user.getUserId()
                );

        System.out.println(
                "Order Count = "
                + (orderList == null
                ? "null"
                : orderList.size())
        );

        // ==============================
        // SEND DATA TO JSP
        // ==============================

        request.setAttribute(
                "orderList",
                orderList
        );

        // ==============================
        // OPEN ORDER HISTORY PAGE
        // ==============================

        request.getRequestDispatcher(
                "orderHistory.jsp"
        ).forward(request, response);
    }
}