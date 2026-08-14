package com.foodexpress.servlet;

import com.foodexpress.dao.UserDAO;
import com.foodexpress.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");


        if (email == null ||
            password == null ||
            email.trim().isEmpty() ||
            password.trim().isEmpty()) {

            response.sendRedirect(
                    "adminLogin.jsp?error=invalid"
            );

            return;
        }


        UserDAO dao =
                new UserDAO();


        User user =
                dao.adminLogin(
                        email.trim(),
                        password.trim()
                );


        if (user != null) {

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "admin",
                    user
            );
            session.setAttribute(
                    "role",
                    "admin"
            );

            response.sendRedirect(
                    "adminDashboard.jsp"
            );

        } else {

            response.sendRedirect(
                    "adminLogin.jsp?error=invalid"
            );
        }
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(
                "adminLogin.jsp"
        );
    }
}