package com.foodexpress.servlet;

import com.foodexpress.dao.OfferDAO;
import com.foodexpress.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/ClaimOfferServlet")
public class ClaimOfferServlet extends HttpServlet {

    private final OfferDAO offerDAO = new OfferDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {

            User user =
                (User) session.getAttribute("user");

            int userId = user.getUserId();

            int offerId =
                Integer.parseInt(
                    request.getParameter("offerId")
                );

            boolean claimed =
                offerDAO.claimOffer(
                    userId,
                    offerId
                );

            if (claimed) {

                response.sendRedirect(
                    "OfferServlet?success=claimed"
                );

            } else {

                response.sendRedirect(
                    "OfferServlet?error=already"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "OfferServlet?error=1"
            );
        }
    }
}