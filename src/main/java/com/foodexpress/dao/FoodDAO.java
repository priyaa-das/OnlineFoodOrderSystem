package com.foodexpress.dao;

import com.foodexpress.db.DBConnection;
import com.foodexpress.model.Food;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FoodDAO {

    Connection con;
    PreparedStatement pst;
    ResultSet rs;

    // Get All Foods
 public List<Food> getAllFoods() {

    List<Food> list = new ArrayList<>();

    try {

        con = DBConnection.getConnection();

        System.out.println("Connection Object = " + con);

        String sql = "SELECT * FROM food_items";

        pst = con.prepareStatement(sql);

        rs = pst.executeQuery();

        while (rs.next()) {

            System.out.println("Food = " + rs.getString("food_name"));

            Food food = new Food();

            food.setFoodId(rs.getInt("food_id"));
            food.setCategoryId(rs.getInt("category_id"));
            food.setFoodName(rs.getString("food_name"));
            food.setDescription(rs.getString("description"));
            food.setPrice(rs.getDouble("price"));
            food.setImageUrl(rs.getString("image_url"));
            food.setStatus(rs.getString("status"));

            list.add(food);
        }

        System.out.println("Total Food = " + list.size());

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}

    // Get Food By ID
    public Food getFoodById(int id) {

        Food food = null;

        try {

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM food_items WHERE food_id=?";

            pst = con.prepareStatement(sql);

            pst.setInt(1, id);

            rs = pst.executeQuery();

            if (rs.next()) {

                food = new Food();

                food.setFoodId(rs.getInt("food_id"));
                food.setCategoryId(rs.getInt("category_id"));
                food.setFoodName(rs.getString("food_name"));
                food.setDescription(rs.getString("description"));
                food.setPrice(rs.getDouble("price"));
                food.setImageUrl(rs.getString("image_url"));
                food.setStatus(rs.getString("status"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return food;
    }
}