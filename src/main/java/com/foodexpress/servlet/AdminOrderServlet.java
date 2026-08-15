package com.foodexpress.servlet;

import com.foodexpress.dao.OrderDAO;
import com.foodexpress.model.Order;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminOrderServlet")
public class AdminOrderServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        String action =
                request.getParameter("action");


        try {


            // =============================================
            // DELETE
            // =============================================

            if ("delete".equals(action)) {

                int orderId =
                        Integer.parseInt(
                                request.getParameter("id")
                        );


                orderDAO.deleteOrder(orderId);


                response.sendRedirect(
                        request.getContextPath()
                        + "/AdminOrderServlet"
                );


                return;
            }


            // =============================================
            // UPDATE STATUS
            // =============================================

            if ("status".equals(action)) {

                int orderId =
                        Integer.parseInt(
                                request.getParameter("id")
                        );


                String status =
                        request.getParameter("value");


                orderDAO.updateOrderStatus(
                        orderId,
                        status
                );


                response.sendRedirect(
                        request.getContextPath()
                        + "/AdminOrderServlet"
                );


                return;
            }


            // =============================================
            // SHOW ORDERS
            // =============================================

            List<Order> orders =
                    orderDAO.getAllOrders();


            request.setAttribute(
                    "orders",
                    orders
            );


            request.getRequestDispatcher(
                    "/adminOrders.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8"
            );


            response.getWriter().println(
                    "<h2>Error loading orders!</h2>"
                    + "<pre>"
                    + e.getMessage()
                    + "</pre>"
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