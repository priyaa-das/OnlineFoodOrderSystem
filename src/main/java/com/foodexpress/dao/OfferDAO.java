package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.Offer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class OfferDAO {

    // =========================================================
    // GET OFFER BY ID - ADMIN EDIT / TOGGLE
    // =========================================================

    public Offer getOfferById(int offerId) {

        Offer offer = null;

        String sql =
                "SELECT offer_id, offer_name, description, " +
                "discount_type, discount_value, minimum_order, " +
                "max_discount, start_date, end_date, status, created_at " +
                "FROM offers " +
                "WHERE offer_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setInt(1, offerId);

            try (ResultSet rs = pst.executeQuery()) {

                if (rs.next()) {

                    offer = new Offer();

                    offer.setOfferId(
                            rs.getInt("offer_id")
                    );

                    offer.setOfferName(
                            rs.getString("offer_name")
                    );

                    offer.setDescription(
                            rs.getString("description")
                    );

                    offer.setDiscountType(
                            rs.getString("discount_type")
                    );

                    offer.setDiscountValue(
                            rs.getDouble("discount_value")
                    );

                    offer.setMinimumOrder(
                            rs.getDouble("minimum_order")
                    );

                    offer.setMaxDiscount(
                            rs.getDouble("max_discount")
                    );

                    offer.setStartDate(
                            rs.getDate("start_date")
                    );

                    offer.setEndDate(
                            rs.getDate("end_date")
                    );

                    offer.setStatus(
                            rs.getString("status")
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "GET OFFER BY ID ERROR"
            );

            e.printStackTrace();
        }

        return offer;
    }


    // =========================================================
    // GET ALL OFFERS - ADMIN
    // =========================================================

    public List<Offer> getAllOffers() {

        List<Offer> offerList = new ArrayList<>();

        String sql =
                "SELECT offer_id, offer_name, description, " +
                "discount_type, discount_value, minimum_order, " +
                "max_discount, start_date, end_date, status, created_at " +
                "FROM offers " +
                "ORDER BY offer_id DESC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql);
                ResultSet rs = pst.executeQuery()
        ) {

            while (rs.next()) {

                Offer offer = new Offer();

                offer.setOfferId(
                        rs.getInt("offer_id")
                );

                offer.setOfferName(
                        rs.getString("offer_name")
                );

                offer.setDescription(
                        rs.getString("description")
                );

                offer.setDiscountType(
                        rs.getString("discount_type")
                );

                offer.setDiscountValue(
                        rs.getDouble("discount_value")
                );

                offer.setMinimumOrder(
                        rs.getDouble("minimum_order")
                );

                offer.setMaxDiscount(
                        rs.getDouble("max_discount")
                );

                offer.setStartDate(
                        rs.getDate("start_date")
                );

                offer.setEndDate(
                        rs.getDate("end_date")
                );

                offer.setStatus(
                        rs.getString("status")
                );

                offerList.add(offer);
            }

        } catch (Exception e) {

            System.out.println("GET ALL OFFERS ERROR");
            e.printStackTrace();
        }

        return offerList;
    }


    // =========================================================
    // GET ACTIVE OFFERS - USER
    // =========================================================

    public List<Offer> getActiveOffers() {

        List<Offer> offerList = new ArrayList<>();

        String sql =
                "SELECT offer_id, offer_name, description, " +
                "discount_type, discount_value, minimum_order, " +
                "max_discount, start_date, end_date, status, created_at " +
                "FROM offers " +
                "WHERE status = 'ACTIVE' " +
                "AND (start_date IS NULL OR start_date <= CURDATE()) " +
                "AND (end_date IS NULL OR end_date >= CURDATE()) " +
                "ORDER BY offer_id DESC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql);
                ResultSet rs = pst.executeQuery()
        ) {

            while (rs.next()) {

                Offer offer = new Offer();

                offer.setOfferId(
                        rs.getInt("offer_id")
                );

                offer.setOfferName(
                        rs.getString("offer_name")
                );

                offer.setDescription(
                        rs.getString("description")
                );

                offer.setDiscountType(
                        rs.getString("discount_type")
                );

                offer.setDiscountValue(
                        rs.getDouble("discount_value")
                );

                offer.setMinimumOrder(
                        rs.getDouble("minimum_order")
                );

                offer.setMaxDiscount(
                        rs.getDouble("max_discount")
                );

                offer.setStartDate(
                        rs.getDate("start_date")
                );

                offer.setEndDate(
                        rs.getDate("end_date")
                );

                offer.setStatus(
                        rs.getString("status")
                );

                offerList.add(offer);
            }

        } catch (Exception e) {

            System.out.println("GET ACTIVE OFFERS ERROR");
            e.printStackTrace();
        }

        return offerList;
    }


    // =========================================================
    // ADD OFFER
    // =========================================================

    public boolean addOffer(Offer offer) {

        String sql =
                "INSERT INTO offers " +
                "(offer_name, description, discount_type, " +
                "discount_value, minimum_order, max_discount, " +
                "start_date, end_date, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setString(
                    1,
                    offer.getOfferName()
            );

            pst.setString(
                    2,
                    offer.getDescription()
            );

            pst.setString(
                    3,
                    offer.getDiscountType()
            );

            pst.setDouble(
                    4,
                    offer.getDiscountValue()
            );

            pst.setDouble(
                    5,
                    offer.getMinimumOrder()
            );

            pst.setDouble(
                    6,
                    offer.getMaxDiscount()
            );

            if (offer.getStartDate() != null) {

                pst.setDate(
                        7,
                        offer.getStartDate()
                );

            } else {

                pst.setNull(
                        7,
                        java.sql.Types.DATE
                );
            }

            if (offer.getEndDate() != null) {

                pst.setDate(
                        8,
                        offer.getEndDate()
                );

            } else {

                pst.setNull(
                        8,
                        java.sql.Types.DATE
                );
            }

            String status = offer.getStatus();

            if (status == null ||
                status.trim().isEmpty()) {

                status = "ACTIVE";
            }

            pst.setString(
                    9,
                    status
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println("ADD OFFER ERROR");
            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // UPDATE OFFER
    // =========================================================

    public boolean updateOffer(Offer offer) {

        String sql =
                "UPDATE offers SET " +
                "offer_name=?, " +
                "description=?, " +
                "discount_type=?, " +
                "discount_value=?, " +
                "minimum_order=?, " +
                "max_discount=?, " +
                "start_date=?, " +
                "end_date=?, " +
                "status=? " +
                "WHERE offer_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setString(
                    1,
                    offer.getOfferName()
            );

            pst.setString(
                    2,
                    offer.getDescription()
            );

            pst.setString(
                    3,
                    offer.getDiscountType()
            );

            pst.setDouble(
                    4,
                    offer.getDiscountValue()
            );

            pst.setDouble(
                    5,
                    offer.getMinimumOrder()
            );

            pst.setDouble(
                    6,
                    offer.getMaxDiscount()
            );

            if (offer.getStartDate() != null) {

                pst.setDate(
                        7,
                        offer.getStartDate()
                );

            } else {

                pst.setNull(
                        7,
                        java.sql.Types.DATE
                );
            }

            if (offer.getEndDate() != null) {

                pst.setDate(
                        8,
                        offer.getEndDate()
                );

            } else {

                pst.setNull(
                        8,
                        java.sql.Types.DATE
                );
            }

            pst.setString(
                    9,
                    offer.getStatus()
            );

            pst.setInt(
                    10,
                    offer.getOfferId()
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println("UPDATE OFFER ERROR");
            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // UPDATE OFFER STATUS
    // =========================================================

    public boolean updateOfferStatus(
            int offerId,
            String status) {

        String sql =
                "UPDATE offers " +
                "SET status=? " +
                "WHERE offer_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setString(
                    1,
                    status
            );

            pst.setInt(
                    2,
                    offerId
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "UPDATE OFFER STATUS ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // DELETE OFFER
    // =========================================================

    public boolean deleteOffer(int offerId) {

        String sql =
                "DELETE FROM offers " +
                "WHERE offer_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    offerId
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "DELETE OFFER ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // CHECK WHETHER USER CLAIMED OFFER
    // =========================================================

    public boolean hasClaimed(
            int userId,
            int offerId) {

        String sql =
                "SELECT claim_id " +
                "FROM claimed_offers " +
                "WHERE user_id=? " +
                "AND offer_id=? " +
                "LIMIT 1";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    userId
            );

            pst.setInt(
                    2,
                    offerId
            );

            try (ResultSet rs = pst.executeQuery()) {

                return rs.next();
            }

        } catch (Exception e) {

            System.out.println(
                    "CHECK CLAIMED OFFER ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // CLAIM OFFER
    // =========================================================

    public boolean claimOffer(
            int userId,
            int offerId) {

        String sql =
                "INSERT INTO claimed_offers " +
                "(user_id, offer_id) " +
                "VALUES (?, ?)";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    userId
            );

            pst.setInt(
                    2,
                    offerId
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "CLAIM OFFER ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // GET CLAIMED OFFERS OF USER
    // =========================================================

    public List<Offer> getClaimedOffers(
            int userId) {

        List<Offer> offerList =
                new ArrayList<>();

        String sql =
                "SELECT o.offer_id, o.offer_name, " +
                "o.description, o.discount_type, " +
                "o.discount_value, o.minimum_order, " +
                "o.max_discount, o.start_date, " +
                "o.end_date, o.status " +
                "FROM offers o " +
                "INNER JOIN claimed_offers c " +
                "ON o.offer_id = c.offer_id " +
                "WHERE c.user_id=? " +
                "ORDER BY c.claimed_at DESC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    userId
            );

            try (ResultSet rs = pst.executeQuery()) {

                while (rs.next()) {

                    Offer offer = new Offer();

                    offer.setOfferId(
                            rs.getInt("offer_id")
                    );

                    offer.setOfferName(
                            rs.getString("offer_name")
                    );

                    offer.setDescription(
                            rs.getString("description")
                    );

                    offer.setDiscountType(
                            rs.getString("discount_type")
                    );

                    offer.setDiscountValue(
                            rs.getDouble("discount_value")
                    );

                    offer.setMinimumOrder(
                            rs.getDouble("minimum_order")
                    );

                    offer.setMaxDiscount(
                            rs.getDouble("max_discount")
                    );

                    offer.setStartDate(
                            rs.getDate("start_date")
                    );

                    offer.setEndDate(
                            rs.getDate("end_date")
                    );

                    offer.setStatus(
                            rs.getString("status")
                    );

                    offerList.add(offer);
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "GET CLAIMED OFFERS ERROR"
            );

            e.printStackTrace();
        }

        return offerList;
    }
}