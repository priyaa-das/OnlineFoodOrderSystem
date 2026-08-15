package com.foodexpress.servlet;

import com.foodexpress.dao.SalesReportDAO;
import com.foodexpress.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/SalesReportServlet")
public class SalesReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // ==========================================
        // ADMIN LOGIN CHECK
        // ==========================================

        HttpSession session = request.getSession();

        User admin = (User) session.getAttribute("admin");

        if (admin == null) {

            response.sendRedirect("adminLogin.jsp");
            return;

        }


        // ==========================================
        // CREATE DAO
        // ==========================================

        SalesReportDAO dao = new SalesReportDAO();


        // ==========================================
        // GET SALES DATA
        // ==========================================

        int totalOrders =
                dao.getTotalOrders();

        double totalRevenue =
                dao.getTotalRevenue();

        int todayOrders =
                dao.getTodayOrders();

        double todaySales =
                dao.getTodaySales();

        int pendingOrders =
                dao.getPendingOrders();

        int preparingOrders =
                dao.getPreparingOrders();

        int deliveredOrders =
                dao.getDeliveredOrders();

        int cancelledOrders =
                dao.getCancelledOrders();


        // ==========================================
        // SEND DATA TO JSP
        // ==========================================

        request.setAttribute(
                "totalOrders",
                totalOrders
        );

        request.setAttribute(
                "totalRevenue",
                totalRevenue
        );

        request.setAttribute(
                "todayOrders",
                todayOrders
        );

        request.setAttribute(
                "todaySales",
                todaySales
        );

        request.setAttribute(
                "pendingOrders",
                pendingOrders
        );

        request.setAttribute(
                "preparingOrders",
                preparingOrders
        );

        request.setAttribute(
                "deliveredOrders",
                deliveredOrders
        );

        request.setAttribute(
                "cancelledOrders",
                cancelledOrders
        );


        // ==========================================
        // FORWARD TO SALES REPORT PAGE
        // ==========================================

        request.getRequestDispatcher(
                "salesReport.jsp"
        ).forward(request, response);

    }
}