package com.foodexpress.servlet;

import com.foodexpress.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {

            response.sendRedirect("ViewUsersServlet");
            return;
        }

        try {

            int userId = Integer.parseInt(id);

            UserDAO dao = new UserDAO();

            boolean deleted = dao.deleteUser(userId);

            if (deleted) {

                response.sendRedirect(
                        "ViewUsersServlet?message=deleted"
                );

            } else {

                response.sendRedirect(
                        "ViewUsersServlet?message=failed"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "ViewUsersServlet?message=invalid"
            );
        }
    }
}