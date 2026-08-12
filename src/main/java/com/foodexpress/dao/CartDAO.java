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

    // ================= Add To Cart =================

    public boolean addToCart(int userId, int foodId) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO cart(user_id,food_id,quantity) VALUES(?,?,1)";

            pst = con.prepareStatement(sql);

            pst.setInt(1, userId);
            pst.setInt(2, foodId);

            int row = pst.executeUpdate();

            if (row > 0) {

                status = true;

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;

    }

    // ================= Get Cart Items =================

    public List<Cart> getCartItems(int userId) {

        List<Cart> cartList = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql =
                    "SELECT c.cart_id, c.user_id, c.food_id, c.quantity, " +
                    "f.food_name, f.price, f.image_url " +
                    "FROM cart c " +
                    "INNER JOIN food_items f " +
                    "ON c.food_id = f.food_id " +
                    "WHERE c.user_id=?";

            pst = con.prepareStatement(sql);

            pst.setInt(1, userId);

            rs = pst.executeQuery();

            while (rs.next()) {
System.out.println("Food = " + rs.getString("food_name"));
System.out.println("Qty = " + rs.getInt("quantity"));
System.out.println("Image = " + rs.getString("image_url"));
                Cart cart = new Cart();

                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setFoodId(rs.getInt("food_id"));
                cart.setFoodName(rs.getString("food_name"));
                cart.setPrice(rs.getDouble("price"));
                cart.setImageUrl(rs.getString("image_url"));
                cart.setQuantity(rs.getInt("quantity"));

                cartList.add(cart);

            }
System.out.println("Cart List Size = " + cartList.size());
        } catch (Exception e) {

            e.printStackTrace();

        }

        return cartList;

    }

    // ================= Remove Cart Item =================

    public boolean removeCartItem(int cartId) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql = "DELETE FROM cart WHERE cart_id=?";

            pst = con.prepareStatement(sql);

            pst.setInt(1, cartId);

            int row = pst.executeUpdate();

            if (row > 0) {

                status = true;

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;

    }

}