package com.foodexpress.servlet;

import com.foodexpress.dao.OfferDAO;
import com.foodexpress.model.Offer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/OfferServlet")
public class OfferServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            OfferDAO dao = new OfferDAO();

            List<Offer> offers =
                    dao.getActiveOffers();

            request.setAttribute(
                    "offerList",
                    offers
            );

            request.getRequestDispatcher(
                    "offers.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error loading offers."
            );
        }
    }
}