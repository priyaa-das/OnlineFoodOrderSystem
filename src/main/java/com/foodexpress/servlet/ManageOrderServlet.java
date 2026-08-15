package com.foodexpress.servlet;

import com.foodexpress.dao.OrderDAO;
import com.foodexpress.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/ManageOrderServlet")
public class ManageOrderServlet extends HttpServlet {

    // =========================
    // GET - Show All Orders
    // =========================

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        try {

            OrderDAO dao = new OrderDAO();

            List<Order> orderList =
                    dao.getAllOrders();

            request.setAttribute(
                    "orderList",
                    orderList
            );

            request.getRequestDispatcher(
                    "manageOrders.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "<h2>Error Loading Orders!</h2>"
            );

            response.getWriter().println(
                    "<p>" + e.getMessage() + "</p>"
            );

            response.getWriter().println(
                    "<a href='adminDashboard.jsp'>Back to Dashboard</a>"
            );
        }
    }


    // =========================
    // POST - Update Order Status
    // =========================

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String orderIdString =
                request.getParameter("orderId");

        String orderStatus =
                request.getParameter("orderStatus");

        if (orderIdString == null ||
            orderStatus == null ||
            orderIdString.trim().isEmpty() ||
            orderStatus.trim().isEmpty()) {

            response.sendRedirect(
                    "ManageOrderServlet?error=invalid"
            );

            return;
        }

        try {

            int orderId =
                    Integer.parseInt(
                            orderIdString
                    );

            OrderDAO dao =
                    new OrderDAO();

            boolean updated =
                    dao.updateOrderStatus(
                            orderId,
                            orderStatus
                    );

            if (updated) {

                response.sendRedirect(
                        "ManageOrderServlet?success=updated"
                );

            } else {

                response.sendRedirect(
                        "ManageOrderServlet?error=update"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "ManageOrderServlet?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "ManageOrderServlet?error=database"
            );
        }
    }
}