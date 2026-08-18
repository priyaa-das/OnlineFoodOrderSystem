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

    // =========================================================
    // GET - SHOW ALL ORDERS
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // =====================================================
        // ADMIN LOGIN CHECK
        // =====================================================

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        try {

            OrderDAO dao =
                    new OrderDAO();

            List<Order> orderList =
                    dao.getAllOrders();

            request.setAttribute(
                    "orderList",
                    orderList
            );

            request.getRequestDispatcher(
                    "manageOrders.jsp"
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
                    "<h2>Error Loading Orders!</h2>"
            );

            response.getWriter().println(
                    "<p>"
                    + e.getMessage()
                    + "</p>"
            );

            response.getWriter().println(
                    "<a href='adminDashboard.jsp'>"
                    + "Back to Dashboard"
                    + "</a>"
            );
        }
    }


    // =========================================================
    // POST - UPDATE ORDER
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // =====================================================
        // ADMIN LOGIN CHECK
        // =====================================================

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String orderIdString =
                request.getParameter("orderId");

        String orderStatus =
                request.getParameter("orderStatus");

        String estimatedDeliveryTime =
                request.getParameter(
                        "estimatedDeliveryTime"
                );


        // =====================================================
        // VALIDATE ORDER ID
        // =====================================================

        if (orderIdString == null ||
            orderIdString.trim().isEmpty()) {

            response.sendRedirect(
                    "ManageOrderServlet?error=invalid"
            );

            return;
        }


        // =====================================================
        // DEFAULT ORDER STATUS
        // =====================================================

        if (orderStatus == null ||
            orderStatus.trim().isEmpty()) {

            orderStatus = "Pending";
        }


        // =====================================================
        // DEFAULT DELIVERY TIME
        // =====================================================

        if (estimatedDeliveryTime == null) {

            estimatedDeliveryTime = "";
        }


        try {

            int orderId =
                    Integer.parseInt(
                            orderIdString
                    );


            // =================================================
            // VALID ORDER STATUS
            // =================================================

            if (!orderStatus.equals("Pending") &&
                !orderStatus.equals("Preparing") &&
                !orderStatus.equals("Delivered") &&
                !orderStatus.equals("Cancelled")) {

                response.sendRedirect(
                        "ManageOrderServlet?error=invalidStatus"
                );

                return;
            }


            // =================================================
            // GET EXISTING ORDER
            // =================================================
            // Delivery Method and Pickup Time will be taken
            // from database, NOT from admin form.
            // =================================================

            OrderDAO dao =
                    new OrderDAO();

            List<Order> orderList =
                    dao.getAllOrders();

            Order existingOrder = null;

            for (Order order : orderList) {

                if (order.getOrderId() == orderId) {

                    existingOrder = order;

                    break;
                }
            }


            // =================================================
            // ORDER NOT FOUND
            // =================================================

            if (existingOrder == null) {

                response.sendRedirect(
                        "ManageOrderServlet?error=notfound"
                );

                return;
            }


            // =================================================
            // KEEP CUSTOMER'S DELIVERY METHOD
            // =================================================

            String deliveryMethod =
                    existingOrder.getDeliveryMethod();


            if (deliveryMethod == null ||
                deliveryMethod.trim().isEmpty()) {

                deliveryMethod = "Delivery";
            }


            // =================================================
            // KEEP CUSTOMER'S PICKUP TIME
            // =================================================

            String pickupTime =
                    existingOrder.getPickupTime();


            if (pickupTime == null) {

                pickupTime = "";
            }


            // =================================================
            // PICKUP ORDER
            // =================================================
            // Pickup order does not need estimated delivery
            // time. Keep it empty.
            // =================================================

            if ("Pickup".equalsIgnoreCase(
                    deliveryMethod)) {

                estimatedDeliveryTime = "";

            }


            // =================================================
            // DELIVERY ORDER
            // =================================================
            // Admin can update estimated delivery time.
            // =================================================

            if ("Delivery".equalsIgnoreCase(
                    deliveryMethod)) {

                if (estimatedDeliveryTime == null) {

                    estimatedDeliveryTime = "";
                }
            }


            // =================================================
            // UPDATE ORDER
            // =================================================

            boolean updated =
                    dao.updateOrderDetails(
                            orderId,
                            orderStatus,
                            deliveryMethod,
                            pickupTime,
                            estimatedDeliveryTime
                    );


            // =================================================
            // RESULT
            // =================================================

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