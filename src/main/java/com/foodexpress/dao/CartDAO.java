package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.Cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // =====================================================
    // GET CART BY USER ID
    // =====================================================

    public List<Cart> getCartByUserId(int userId) {

        List<Cart> cartList = new ArrayList<>();

        String sql =
                "SELECT c.cart_id, c.user_id, c.food_id, c.quantity, " +
                "f.food_name, f.price, f.image_url " +
                "FROM cart c " +
                "INNER JOIN food_items f ON c.food_id = f.food_id " +
                "WHERE c.user_id=? " +
                "ORDER BY c.cart_id DESC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst = con.prepareStatement(sql)
        ) {

            pst.setInt(1, userId);

            try (ResultSet rs = pst.executeQuery()) {

                while (rs.next()) {

                    Cart cart = new Cart();

                    cart.setCartId(
                            rs.getInt("cart_id")
                    );

                    cart.setUserId(
                            rs.getInt("user_id")
                    );

                    cart.setFoodId(
                            rs.getInt("food_id")
                    );

                    cart.setFoodName(
                            rs.getString("food_name")
                    );

                    cart.setPrice(
                            rs.getDouble("price")
                    );

                    cart.setImageUrl(
                            rs.getString("image_url")
                    );

                    cart.setQuantity(
                            rs.getInt("quantity")
                    );

                    cartList.add(cart);
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "GET CART ERROR"
            );

            e.printStackTrace();
        }

        return cartList;
    }


    // =====================================================
    // GET CART ITEMS
    // =====================================================

    public List<Cart> getCartItems(int userId) {

        return getCartByUserId(userId);
    }


    // =====================================================
    // ADD TO CART - DEFAULT QUANTITY 1
    // =====================================================

    public boolean addToCart(
            int userId,
            int foodId) {

        return addToCart(
                userId,
                foodId,
                1
        );
    }


    // =====================================================
    // ADD TO CART - WITH QUANTITY
    // =====================================================

    public boolean addToCart(
            int userId,
            int foodId,
            int quantity) {

        if (quantity <= 0) {
            quantity = 1;
        }

        Connection con = null;

        try {

            con = DBConnection.getConnection();

            // =================================================
            // CHECK EXISTING CART ITEM
            // =================================================

            String checkSQL =
                    "SELECT cart_id, quantity " +
                    "FROM cart " +
                    "WHERE user_id=? AND food_id=?";

            try (
                    PreparedStatement checkPst =
                            con.prepareStatement(checkSQL)
            ) {

                checkPst.setInt(
                        1,
                        userId
                );

                checkPst.setInt(
                        2,
                        foodId
                );

                try (
                        ResultSet rs =
                                checkPst.executeQuery()
                ) {

                    if (rs.next()) {

                        int cartId =
                                rs.getInt("cart_id");

                        int oldQuantity =
                                rs.getInt("quantity");

                        int newQuantity =
                                oldQuantity + quantity;

                        // -----------------------------------------
                        // UPDATE EXISTING ITEM
                        // -----------------------------------------

                        String updateSQL =
                                "UPDATE cart " +
                                "SET quantity=? " +
                                "WHERE cart_id=? AND user_id=?";

                        try (
                                PreparedStatement updatePst =
                                        con.prepareStatement(updateSQL)
                        ) {

                            updatePst.setInt(
                                    1,
                                    newQuantity
                            );

                            updatePst.setInt(
                                    2,
                                    cartId
                            );

                            updatePst.setInt(
                                    3,
                                    userId
                            );

                            return updatePst.executeUpdate() > 0;
                        }

                    } else {

                        // -----------------------------------------
                        // INSERT NEW ITEM
                        // -----------------------------------------

                        String insertSQL =
                                "INSERT INTO cart " +
                                "(user_id, food_id, quantity) " +
                                "VALUES (?, ?, ?)";

                        try (
                                PreparedStatement insertPst =
                                        con.prepareStatement(
                                                insertSQL
                                        )
                        ) {

                            insertPst.setInt(
                                    1,
                                    userId
                            );

                            insertPst.setInt(
                                    2,
                                    foodId
                            );

                            insertPst.setInt(
                                    3,
                                    quantity
                            );

                            return insertPst.executeUpdate() > 0;
                        }
                    }
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ADD TO CART ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // UPDATE QUANTITY USING CART ID + USER ID
    // USED BY CartServlet
    // =====================================================

    public boolean updateQuantity(
            int cartId,
            int userId,
            int quantity) {

        if (quantity <= 0) {

            return removeFromCart(
                    cartId,
                    userId
            );
        }

        String sql =
                "UPDATE cart " +
                "SET quantity=? " +
                "WHERE cart_id=? AND user_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst =
                        con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    quantity
            );

            pst.setInt(
                    2,
                    cartId
            );

            pst.setInt(
                    3,
                    userId
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "UPDATE CART QUANTITY ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // UPDATE QUANTITY USING USER ID + FOOD ID
    // KEPT FOR COMPATIBILITY
    // =====================================================

    public boolean updateQuantityByFood(
            int userId,
            int foodId,
            int quantity) {

        if (quantity <= 0) {

            return removeFromCart(
                    userId,
                    foodId
            );
        }

        String sql =
                "UPDATE cart " +
                "SET quantity=? " +
                "WHERE user_id=? AND food_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst =
                        con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    quantity
            );

            pst.setInt(
                    2,
                    userId
            );

            pst.setInt(
                    3,
                    foodId
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "UPDATE CART QUANTITY BY FOOD ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // REMOVE USING CART ID + USER ID
    // USED BY CartServlet
    // =====================================================

    public boolean removeFromCart(
            int cartId,
            int userId) {

        String sql =
                "DELETE FROM cart " +
                "WHERE cart_id=? AND user_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst =
                        con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    cartId
            );

            pst.setInt(
                    2,
                    userId
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "REMOVE CART ITEM ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // REMOVE USING USER ID + FOOD ID
    // KEPT FOR COMPATIBILITY
    // =====================================================

    public boolean removeFromCart(
            int userId,
            int foodId,
            boolean byFoodId) {

        String sql =
                "DELETE FROM cart " +
                "WHERE user_id=? AND food_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst =
                        con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    userId
            );

            pst.setInt(
                    2,
                    foodId
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "REMOVE CART BY FOOD ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // REMOVE CART ITEM USING CART ID
    // =====================================================

    public boolean removeCartItem(
            int cartId) {

        String sql =
                "DELETE FROM cart " +
                "WHERE cart_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst =
                        con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    cartId
            );

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "REMOVE CART ITEM BY ID ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // CLEAR USER CART
    // =====================================================

    public boolean clearCart(
            int userId) {

        String sql =
                "DELETE FROM cart " +
                "WHERE user_id=?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement pst =
                        con.prepareStatement(sql)
        ) {

            pst.setInt(
                    1,
                    userId
            );

            pst.executeUpdate();

            return true;

        } catch (Exception e) {

            System.out.println(
                    "CLEAR CART ERROR"
            );

            e.printStackTrace();

            return false;
        }
    }
}