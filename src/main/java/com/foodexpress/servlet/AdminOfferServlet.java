package com.foodexpress.servlet;

import com.foodexpress.dao.OfferDAO;
import com.foodexpress.model.Offer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/AdminOfferServlet")
public class AdminOfferServlet extends HttpServlet {

    private final OfferDAO offerDAO = new OfferDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {

            if ("delete".equals(action)) {

                int id = Integer.parseInt(
                        request.getParameter("id")
                );

                offerDAO.deleteOffer(id);

                response.sendRedirect(
                        "AdminOfferServlet"
                );

                return;
            }

            if ("toggle".equals(action)) {

                int id = Integer.parseInt(
                        request.getParameter("id")
                );

                Offer offer = offerDAO.getOfferById(id);

                if (offer != null) {

                    String newStatus =
                            "ACTIVE".equalsIgnoreCase(
                                    offer.getStatus()
                            )
                            ? "INACTIVE"
                            : "ACTIVE";

                    offerDAO.updateOfferStatus(
                            id,
                            newStatus
                    );
                }

                response.sendRedirect(
                        "AdminOfferServlet"
                );

                return;
            }

            if ("edit".equals(action)) {

                int id = Integer.parseInt(
                        request.getParameter("id")
                );

                Offer offer =
                        offerDAO.getOfferById(id);

                request.setAttribute(
                        "offer",
                        offer
                );

                request.getRequestDispatcher(
                        "editOffer.jsp"
                ).forward(request, response);

                return;
            }

            List<Offer> offers =
                    offerDAO.getAllOffers();

            request.setAttribute(
                    "offers",
                    offers
            );

            request.getRequestDispatcher(
                    "adminOffers.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "adminOffers.jsp?error=1"
            );
        }
    }


    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String action =
                    request.getParameter("action");

            Offer offer = new Offer();

            if ("add".equals(action)) {

                offer.setOfferName(
                        request.getParameter("offerName")
                );

                offer.setDescription(
                        request.getParameter("description")
                );

                offer.setDiscountType(
                        request.getParameter("discountType")
                );

                offer.setDiscountValue(
                        Double.parseDouble(
                                request.getParameter(
                                        "discountValue"
                                )
                        )
                );

                offer.setMinimumOrder(
                        Double.parseDouble(
                                request.getParameter(
                                        "minimumOrder"
                                )
                        )
                );

                offer.setMaxDiscount(
                        Double.parseDouble(
                                request.getParameter(
                                        "maxDiscount"
                                )
                        )
                );

                String start =
                        request.getParameter("startDate");

                String end =
                        request.getParameter("endDate");

                if (start != null && !start.isEmpty()) {
                    offer.setStartDate(
                            Date.valueOf(start)
                    );
                }

                if (end != null && !end.isEmpty()) {
                    offer.setEndDate(
                            Date.valueOf(end)
                    );
                }

                offer.setStatus(
                        request.getParameter("status")
                );

                offerDAO.addOffer(offer);

            } else if ("update".equals(action)) {

                offer.setOfferId(
                        Integer.parseInt(
                                request.getParameter("offerId")
                        )
                );

                offer.setOfferName(
                        request.getParameter("offerName")
                );

                offer.setDescription(
                        request.getParameter("description")
                );

                offer.setDiscountType(
                        request.getParameter("discountType")
                );

                offer.setDiscountValue(
                        Double.parseDouble(
                                request.getParameter(
                                        "discountValue"
                                )
                        )
                );

                offer.setMinimumOrder(
                        Double.parseDouble(
                                request.getParameter(
                                        "minimumOrder"
                                )
                        )
                );

                offer.setMaxDiscount(
                        Double.parseDouble(
                                request.getParameter(
                                        "maxDiscount"
                                )
                        )
                );

                String start =
                        request.getParameter("startDate");

                String end =
                        request.getParameter("endDate");

                if (start != null && !start.isEmpty()) {
                    offer.setStartDate(
                            Date.valueOf(start)
                    );
                }

                if (end != null && !end.isEmpty()) {
                    offer.setEndDate(
                            Date.valueOf(end)
                    );
                }

                offer.setStatus(
                        request.getParameter("status")
                );

                offerDAO.updateOffer(offer);
            }

            response.sendRedirect(
                    "AdminOfferServlet"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "AdminOfferServlet?error=1"
            );
        }
    }
}