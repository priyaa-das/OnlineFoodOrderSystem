package com.foodexpress.servlet;

import com.foodexpress.dao.UserDAO;
import com.foodexpress.model.User;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();

        User user = dao.loginUser(email, password);

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("user", user);

            session.setAttribute("name", user.getFullName());

            response.sendRedirect("userHome.jsp");

        } else {

            response.getWriter().println("<h2>Invalid Email or Password!</h2>");
            response.getWriter().println("<a href='login.jsp'>Try Again</a>");

        }

    }

}