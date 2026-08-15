package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.Cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    Connection con;
    PreparedStatement pst;
    ResultSet rs;

    // =====================================================
    // ADD FOOD TO CART
    // =====================================================

    public boolean addToCart(int userId, int foodId, int quantity) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String checkSql =
                    "SELECT cart_id, quantity " +
                    "FROM cart " +
                    "WHERE user_id=? AND food_id=?";

            pst = con.prepareStatement(checkSql);

            pst.setInt(1, userId);
            pst.setInt(2, foodId);

            rs = pst.executeQuery();

            if (rs.next()) {

                int cartId = rs.getInt("cart_id");
                int oldQuantity = rs.getInt("quantity");

                int newQuantity = oldQuantity + quantity;

                rs.close();
                rs = null;

                pst.close();
                pst = null;

                String updateSql =
                        "UPDATE cart " +
                        "SET quantity=? " +
                        "WHERE cart_id=? AND user_id=?";

                pst = con.prepareStatement(updateSql);

                pst.setInt(1, newQuantity);
                pst.setInt(2, cartId);
                pst.setInt(3, userId);

                int row = pst.executeUpdate();

                if (row > 0) {
                    status = true;
                }

            } else {

                rs.close();
                rs = null;

                pst.close();
                pst = null;

                String insertSql =
                        "INSERT INTO cart " +
                        "(user_id, food_id, quantity) " +
                        "VALUES (?, ?, ?)";

                pst = con.prepareStatement(insertSql);

                pst.setInt(1, userId);
                pst.setInt(2, foodId);
                pst.setInt(3, quantity);

                int row = pst.executeUpdate();

                if (row > 0) {
                    status = true;
                }
            }

        } catch (Exception e) {

            System.out.println("ADD TO CART ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return status;
    }


    // =====================================================
    // GET CUSTOMER CART
    // =====================================================

    public List<Cart> getCartByUserId(int userId) {

        List<Cart> cartList = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql =
                    "SELECT c.cart_id, " +
                    "c.user_id, " +
                    "c.food_id, " +
                    "f.food_name, " +
                    "f.price, " +
                    "f.image_url, " +
                    "c.quantity " +
                    "FROM cart c " +
                    "JOIN food_items f " +
                    "ON c.food_id = f.food_id " +
                    "WHERE c.user_id=? " +
                    "ORDER BY c.cart_id DESC";

            pst = con.prepareStatement(sql);

            pst.setInt(1, userId);

            rs = pst.executeQuery();

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

        } catch (Exception e) {

            System.out.println("GET CART ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return cartList;
    }


    // =====================================================
    // GET CART ITEMS
    // =====================================================
    // This method is used by CheckoutServlet
    // and PlaceOrderServlet.
    // =====================================================

    public List<Cart> getCartItems(int userId) {

        return getCartByUserId(userId);
    }


    // =====================================================
    // REMOVE ONE FOOD FROM CART
    // =====================================================

    public boolean removeFromCart(int cartId, int userId) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "DELETE FROM cart " +
                    "WHERE cart_id=? " +
                    "AND user_id=?";

            pst = con.prepareStatement(sql);

            pst.setInt(1, cartId);
            pst.setInt(2, userId);

            int row = pst.executeUpdate();

            if (row > 0) {

                System.out.println(
                        "Cart Item Removed Successfully"
                );

                status = true;

            } else {

                System.out.println(
                        "Cart Item Not Found"
                );
            }

        } catch (Exception e) {

            System.out.println("REMOVE CART ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return status;
    }


    // =====================================================
    // UPDATE CART QUANTITY
    // =====================================================

    public boolean updateQuantity(
            int cartId,
            int userId,
            int quantity) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "UPDATE cart " +
                    "SET quantity=? " +
                    "WHERE cart_id=? " +
                    "AND user_id=?";

            pst = con.prepareStatement(sql);

            pst.setInt(1, quantity);
            pst.setInt(2, cartId);
            pst.setInt(3, userId);

            int row = pst.executeUpdate();

            if (row > 0) {
                status = true;
            }

        } catch (Exception e) {

            System.out.println("UPDATE CART ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return status;
    }


    // =====================================================
    // CLEAR CUSTOMER CART
    // =====================================================

    public boolean clearCart(int userId) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "DELETE FROM cart " +
                    "WHERE user_id=?";

            pst = con.prepareStatement(sql);

            pst.setInt(1, userId);

            pst.executeUpdate();

            status = true;

        } catch (Exception e) {

            System.out.println("CLEAR CART ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return status;
    }


    // =====================================================
    // CLOSE RESOURCES
    // =====================================================

    private void closeResources() {

        try {

            if (rs != null) {
                rs.close();
                rs = null;
            }

            if (pst != null) {
                pst.close();
                pst = null;
            }

            if (con != null) {
                con.close();
                con = null;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}