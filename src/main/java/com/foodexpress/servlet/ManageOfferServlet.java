
package com.foodexpress.servlet;

import com.foodexpress.dao.OfferDAO;
import com.foodexpress.model.Offer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/ManageOfferServlet")
public class ManageOfferServlet extends HttpServlet {

    // =========================================================
    // GET - SHOW ALL OFFERS
    // =========================================================

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Admin login check
        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        try {

            OfferDAO dao = new OfferDAO();

            List<Offer> offerList =
                    dao.getAllOffers();

            request.setAttribute(
                    "offerList",
                    offerList
            );

            request.getRequestDispatcher(
                    "manageOffers.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "<h2>Error Loading Offers!</h2>"
            );

            response.getWriter().println(
                    "<p>" + e.getMessage() + "</p>"
            );

            response.getWriter().println(
                    "<a href='adminDashboard.jsp'>Back to Dashboard</a>"
            );
        }
    }


    // =========================================================
    // POST - ADD / UPDATE / DELETE OFFER
    // =========================================================

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Admin login check
        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String action =
                request.getParameter("action");

        try {

            OfferDAO dao =
                    new OfferDAO();


            // =================================================
            // ADD OFFER
            // =================================================

            if ("add".equalsIgnoreCase(action)) {

                String offerName =
                        request.getParameter("offerName");

                String description =
                        request.getParameter("description");

                String discountType =
                        request.getParameter("discountType");

                String discountValue =
                        request.getParameter("discountValue");

                String minimumOrder =
                        request.getParameter("minimumOrder");

                String maxDiscount =
                        request.getParameter("maxDiscount");

                String startDateString =
                        request.getParameter("startDate");

                String endDateString =
                        request.getParameter("endDate");

                String status =
                        request.getParameter("status");


                // ---------------------------------------------
                // CREATE OFFER OBJECT
                // ---------------------------------------------

                Offer offer =
                        new Offer();

                offer.setOfferName(
                        offerName
                );

                offer.setDescription(
                        description
                );

                offer.setDiscountType(
                        discountType
                );


                // ---------------------------------------------
                // DISCOUNT VALUE
                // ---------------------------------------------

                if (discountValue != null &&
                    !discountValue.trim().isEmpty()) {

                    offer.setDiscountValue(
                            Double.parseDouble(
                                    discountValue
                            )
                    );

                } else {

                    offer.setDiscountValue(0.0);
                }


                // ---------------------------------------------
                // MINIMUM ORDER
                // ---------------------------------------------

                if (minimumOrder != null &&
                    !minimumOrder.trim().isEmpty()) {

                    offer.setMinimumOrder(
                            Double.parseDouble(
                                    minimumOrder
                            )
                    );

                } else {

                    offer.setMinimumOrder(0.0);
                }


                // ---------------------------------------------
                // MAX DISCOUNT
                // ---------------------------------------------

                if (maxDiscount != null &&
                    !maxDiscount.trim().isEmpty()) {

                    offer.setMaxDiscount(
                            Double.parseDouble(
                                    maxDiscount
                            )
                    );

                } else {

                    offer.setMaxDiscount(0.0);
                }


                // ---------------------------------------------
                // START DATE
                // ---------------------------------------------

                offer.setStartDate(
                        convertToSqlDate(
                                startDateString
                        )
                );


                // ---------------------------------------------
                // END DATE
                // ---------------------------------------------

                offer.setEndDate(
                        convertToSqlDate(
                                endDateString
                        )
                );


                // ---------------------------------------------
                // STATUS
                // ---------------------------------------------

                if (status == null ||
                    status.trim().isEmpty()) {

                    status = "ACTIVE";
                }

                offer.setStatus(
                        status
                );


                // ---------------------------------------------
                // INSERT INTO DATABASE
                // ---------------------------------------------

                boolean added =
                        dao.addOffer(offer);


                if (added) {

                    response.sendRedirect(
                            "ManageOfferServlet?success=added"
                    );

                } else {

                    response.sendRedirect(
                            "ManageOfferServlet?error=add"
                    );
                }

                return;
            }


            // =================================================
            // UPDATE OFFER
            // =================================================

            if ("update".equalsIgnoreCase(action)) {

                String offerIdString =
                        request.getParameter("offerId");


                if (offerIdString == null ||
                    offerIdString.trim().isEmpty()) {

                    response.sendRedirect(
                            "ManageOfferServlet?error=invalid"
                    );

                    return;
                }


                int offerId =
                        Integer.parseInt(
                                offerIdString
                        );


                String offerName =
                        request.getParameter("offerName");

                String description =
                        request.getParameter("description");

                String discountType =
                        request.getParameter("discountType");

                String discountValue =
                        request.getParameter("discountValue");

                String minimumOrder =
                        request.getParameter("minimumOrder");

                String maxDiscount =
                        request.getParameter("maxDiscount");

                String startDateString =
                        request.getParameter("startDate");

                String endDateString =
                        request.getParameter("endDate");

                String status =
                        request.getParameter("status");


                // ---------------------------------------------
                // CREATE OFFER OBJECT
                // ---------------------------------------------

                Offer offer =
                        new Offer();


                offer.setOfferId(
                        offerId
                );

                offer.setOfferName(
                        offerName
                );

                offer.setDescription(
                        description
                );

                offer.setDiscountType(
                        discountType
                );


                // ---------------------------------------------
                // DISCOUNT VALUE
                // ---------------------------------------------

                if (discountValue != null &&
                    !discountValue.trim().isEmpty()) {

                    offer.setDiscountValue(
                            Double.parseDouble(
                                    discountValue
                            )
                    );

                } else {

                    offer.setDiscountValue(0.0);
                }


                // ---------------------------------------------
                // MINIMUM ORDER
                // ---------------------------------------------

                if (minimumOrder != null &&
                    !minimumOrder.trim().isEmpty()) {

                    offer.setMinimumOrder(
                            Double.parseDouble(
                                    minimumOrder
                            )
                    );

                } else {

                    offer.setMinimumOrder(0.0);
                }


                // ---------------------------------------------
                // MAX DISCOUNT
                // ---------------------------------------------

                if (maxDiscount != null &&
                    !maxDiscount.trim().isEmpty()) {

                    offer.setMaxDiscount(
                            Double.parseDouble(
                                    maxDiscount
                            )
                    );

                } else {

                    offer.setMaxDiscount(0.0);
                }


                // ---------------------------------------------
                // START DATE
                // ---------------------------------------------

                offer.setStartDate(
                        convertToSqlDate(
                                startDateString
                        )
                );


                // ---------------------------------------------
                // END DATE
                // ---------------------------------------------

                offer.setEndDate(
                        convertToSqlDate(
                                endDateString
                        )
                );


                // ---------------------------------------------
                // STATUS
                // ---------------------------------------------

                if (status == null ||
                    status.trim().isEmpty()) {

                    status = "ACTIVE";
                }

                offer.setStatus(
                        status
                );


                // ---------------------------------------------
                // UPDATE DATABASE
                // ---------------------------------------------

                boolean updated =
                        dao.updateOffer(offer);


                if (updated) {

                    response.sendRedirect(
                            "ManageOfferServlet?success=updated"
                    );

                } else {

                    response.sendRedirect(
                            "ManageOfferServlet?error=update"
                    );
                }

                return;
            }


            // =================================================
            // DELETE OFFER
            // =================================================

            if ("delete".equalsIgnoreCase(action)) {

                String offerIdString =
                        request.getParameter("offerId");


                if (offerIdString == null ||
                    offerIdString.trim().isEmpty()) {

                    response.sendRedirect(
                            "ManageOfferServlet?error=invalid"
                    );

                    return;
                }


                int offerId =
                        Integer.parseInt(
                                offerIdString
                        );


                boolean deleted =
                        dao.deleteOffer(
                                offerId
                        );


                if (deleted) {

                    response.sendRedirect(
                            "ManageOfferServlet?success=deleted"
                    );

                } else {

                    response.sendRedirect(
                            "ManageOfferServlet?error=delete"
                    );
                }

                return;
            }


            // =================================================
            // INVALID ACTION
            // =================================================

            response.sendRedirect(
                    "ManageOfferServlet?error=invalid"
            );


        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "ManageOfferServlet?error=invalid"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "ManageOfferServlet?error=database"
            );
        }
    }


    // =========================================================
    // STRING -> SQL DATE
    // =========================================================

    private Date convertToSqlDate(
            String dateString) {

        try {

            if (dateString == null ||
                dateString.trim().isEmpty()) {

                return null;
            }

            return Date.valueOf(
                    dateString
            );

        } catch (IllegalArgumentException e) {

            return null;
        }
    }
}
