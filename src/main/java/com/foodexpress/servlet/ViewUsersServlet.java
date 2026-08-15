package com.foodexpress.servlet;

import com.foodexpress.dao.UserDAO;
import com.foodexpress.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/ViewUsersServlet")
public class ViewUsersServlet extends HttpServlet {

    // =====================================================
    // VIEW REGISTERED CUSTOMERS
    // =====================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Create UserDAO object
        UserDAO dao = new UserDAO();

        // Get customers only
        // Admin will NOT be shown
        List<User> userList =
                dao.getAllCustomers();

        // Send customer list to JSP
        request.setAttribute(
                "userList",
                userList
        );

        // Open viewUsers.jsp
        request.getRequestDispatcher(
                "viewUsers.jsp"
        ).forward(
                request,
                response
        );
    }


    // =====================================================
    // POST REQUEST
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}