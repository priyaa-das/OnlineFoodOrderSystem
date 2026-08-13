package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.Cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // ================= ADD TO CART =================

    public boolean addToCart(int userId, int foodId) {

        String checkSql =
                "SELECT cart_id, quantity " +
                "FROM cart " +
                "WHERE user_id = ? AND food_id = ?";

        String updateSql =
                "UPDATE cart SET quantity = quantity + 1 " +
                "WHERE cart_id = ?";

        String insertSql =
                "INSERT INTO cart(user_id, food_id, quantity) " +
                "VALUES (?, ?, 1)";

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                System.out.println("Database connection is NULL!");
                return false;
            }

            // Check whether food already exists
            try (PreparedStatement check =
                         con.prepareStatement(checkSql)) {

                check.setInt(1, userId);
                check.setInt(2, foodId);

                try (ResultSet rs = check.executeQuery()) {

                    if (rs.next()) {

                        // Already in cart → increase quantity

                        int cartId =
                                rs.getInt("cart_id");

                        try (PreparedStatement update =
                                     con.prepareStatement(updateSql)) {

                            update.setInt(1, cartId);

                            return update.executeUpdate() > 0;
                        }

                    } else {

                        // New food → insert

                        try (PreparedStatement insert =
                                     con.prepareStatement(insertSql)) {

                            insert.setInt(1, userId);
                            insert.setInt(2, foodId);

                            return insert.executeUpdate() > 0;
                        }
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // ================= GET CART ITEMS =================

    public List<Cart> getCartItems(int userId) {

        List<Cart> cartList = new ArrayList<>();

        String sql =
                "SELECT c.cart_id, " +
                "c.user_id, " +
                "c.food_id, " +
                "c.quantity, " +
                "f.food_name, " +
                "f.price, " +
                "f.image_url, " +
                "(c.quantity * f.price) AS total_price " +
                "FROM cart c " +
                "INNER JOIN food_items f " +
                "ON c.food_id = f.food_id " +
                "WHERE c.user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            if (con == null) {
                System.out.println("Database connection is NULL!");
                return cartList;
            }

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

                    cart.setTotalPrice(
                            rs.getDouble("total_price")
                    );

                    cartList.add(cart);
                }
            }

            System.out.println(
                    "Cart List Size = " + cartList.size()
            );

        } catch (Exception e) {

            e.printStackTrace();
        }

        return cartList;
    }


    // ================= REMOVE CART ITEM =================

    public boolean removeCartItem(int cartId) {

        String sql =
                "DELETE FROM cart WHERE cart_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst =
                     con.prepareStatement(sql)) {

            pst.setInt(1, cartId);

            return pst.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}