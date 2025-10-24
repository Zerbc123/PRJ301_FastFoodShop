/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import model.CartItem;

/**
 *
 * @author ADMIN
 */
public class CartItemDAO {

    public static void saveCartItem(CartItem cartItem) {
    Connection conn = null;
    PreparedStatement psmt = null;

    try {
        conn = new DBContext().getConnection();
        String sql = "INSERT INTO CartItem (cart_id, product_id, quantity) VALUES (?, ?, ?)"; // Chú ý đến câu lệnh SQL
        psmt = conn.prepareStatement(sql);

        // Gán giá trị cho các tham số trong câu lệnh SQL
        psmt.setInt(1, cartItem.getCart_id());   // cart_id
        psmt.setInt(2, cartItem.getProduct_id()); // product_id
        psmt.setInt(3, cartItem.getQuantity());   // quantity

        // Thực thi câu lệnh
        psmt.executeUpdate();  // Đảm bảo câu lệnh này được thực thi đúng
    } catch (SQLException e) {
        e.printStackTrace();  // Kiểm tra xem có lỗi gì xảy ra không
    } finally {
        try {
            if (psmt != null) psmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
}