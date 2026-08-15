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


    // =====================================================
    // GET ALL FOODS
    // =====================================================

    public List<Food> getAllFoods() {

        List<Food> list = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM food_items";

            pst = con.prepareStatement(sql);

            rs = pst.executeQuery();

            while (rs.next()) {

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

            System.out.println("GET ALL FOOD ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return list;
    }


    // =====================================================
    // GET FOOD BY ID
    // =====================================================

    public Food getFoodById(int id) {

        Food food = null;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "SELECT * FROM food_items WHERE food_id=?";

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

            System.out.println("GET FOOD BY ID ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return food;
    }


    // =====================================================
    // ADD FOOD - USING FOOD OBJECT
    // =====================================================

    public boolean addFood(Food food) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO food_items " +
                    "(category_id, food_name, description, price, image_url, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            pst = con.prepareStatement(sql);

            pst.setInt(1, food.getCategoryId());
            pst.setString(2, food.getFoodName());
            pst.setString(3, food.getDescription());
            pst.setDouble(4, food.getPrice());
            pst.setString(5, food.getImageUrl());
            pst.setString(6, food.getStatus());

            int row = pst.executeUpdate();

            if (row > 0) {

                System.out.println("Food Added Successfully");

                status = true;

            } else {

                System.out.println("Food Add Failed");
            }

        } catch (Exception e) {

            System.out.println("ADD FOOD ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return status;
    }


    // =====================================================
    // ADD FOOD - PARAMETER VERSION
    // This fixes your current AddFoodServlet error
    // =====================================================

    public boolean addFood(
            int categoryId,
            String foodName,
            String description,
            double price,
            String imageUrl,
            String status) {

        boolean result = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO food_items " +
                    "(category_id, food_name, description, price, image_url, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            pst = con.prepareStatement(sql);

            pst.setInt(1, categoryId);
            pst.setString(2, foodName);
            pst.setString(3, description);
            pst.setDouble(4, price);
            pst.setString(5, imageUrl);
            pst.setString(6, status);

            int row = pst.executeUpdate();

            if (row > 0) {

                System.out.println("Food Added Successfully");

                result = true;

            } else {

                System.out.println("Food Add Failed");
            }

        } catch (Exception e) {

            System.out.println("ADD FOOD ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return result;
    }


    // =====================================================
    // UPDATE FOOD
    // =====================================================

    public boolean updateFood(
            int foodId,
            int categoryId,
            String foodName,
            String description,
            double price,
            String imageUrl,
            String status) {

        boolean result = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "UPDATE food_items SET " +
                    "category_id=?, " +
                    "food_name=?, " +
                    "description=?, " +
                    "price=?, " +
                    "image_url=?, " +
                    "status=? " +
                    "WHERE food_id=?";

            pst = con.prepareStatement(sql);

            pst.setInt(1, categoryId);
            pst.setString(2, foodName);
            pst.setString(3, description);
            pst.setDouble(4, price);
            pst.setString(5, imageUrl);
            pst.setString(6, status);
            pst.setInt(7, foodId);

            int row = pst.executeUpdate();

            if (row > 0) {

                System.out.println("Food Updated Successfully");

                result = true;

            } else {

                System.out.println("Food Update Failed");
            }

        } catch (Exception e) {

            System.out.println("UPDATE FOOD ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return result;
    }


    // =====================================================
    // UPDATE FOOD - USING FOOD OBJECT
    // =====================================================

    public boolean updateFood(Food food) {

        return updateFood(
                food.getFoodId(),
                food.getCategoryId(),
                food.getFoodName(),
                food.getDescription(),
                food.getPrice(),
                food.getImageUrl(),
                food.getStatus()
        );
    }


    // =====================================================
    // DELETE FOOD
    // =====================================================

    public boolean deleteFood(int foodId) {

        boolean result = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                    "DELETE FROM food_items WHERE food_id=?";

            pst = con.prepareStatement(sql);

            pst.setInt(1, foodId);

            int row = pst.executeUpdate();

            if (row > 0) {

                System.out.println("Food Deleted Successfully");

                result = true;

            } else {

                System.out.println("Food Delete Failed");
            }

        } catch (Exception e) {

            System.out.println("DELETE FOOD ERROR");
            e.printStackTrace();

        } finally {

            closeResources();
        }

        return result;
    }


    // =====================================================
    // CLOSE DATABASE RESOURCES
    // =====================================================

    private void closeResources() {

        try {

            if (rs != null) {
                rs.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        try {

            if (pst != null) {
                pst.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        try {

            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        rs = null;
        pst = null;
        con = null;
    }
}