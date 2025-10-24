/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import model.CartItem;
import model.Order;

/**
 *
 * @author ADMIN
 */
public class OrderDAO {

    private static final String INSERT_ORDER = "INSERT INTO `Order` (user_id, order_date, total_amount, payment_method, voucher_id, order_status) VALUES (?, ?, ?, ?, ?, ?)";
    
    private static final String SELECT_ORDER_BY_ID = "SELECT * FROM `Order` WHERE order_id = ?";

    // Hàm lưu đơn hàng vào cơ sở dữ liệu và trả về Order đã lưu (bao gồm cả order_id)
    public static Order saveOrder(Order order) {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        
        try {
            // Kết nối đến cơ sở dữ liệu
            conn = new DBContext().getConnection();
            psmt = conn.prepareStatement(INSERT_ORDER, Statement.RETURN_GENERATED_KEYS);  // Trả về generated keys để lấy ID của đơn hàng vừa tạo
            
            // Cài đặt các tham số cho câu lệnh SQL
            psmt.setInt(1, order.getUser_id());  // user_id
            psmt.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis()));  // order_date
            psmt.setDouble(3, order.getTotal_amount());  // total_amount
            psmt.setInt(4, order.getPayment_method());  // payment_method
            psmt.setInt(5, order.getVoucher_id());  // voucher_id
            psmt.setString(6, order.getOrder_status());  // order_status
            
            // Thực thi câu lệnh SQL
            psmt.executeUpdate();
            
            // Lấy ID của đơn hàng vừa được tạo
            rs = psmt.getGeneratedKeys();
            if (rs.next()) {
                order.setOrder_id(rs.getInt(1));  // Set order_id cho đối tượng Order
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Đảm bảo đóng kết nối
            try {
                if (rs != null) rs.close();
                if (psmt != null) psmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return order;  // Trả về order đã được thêm vào cơ sở dữ liệu (bao gồm order_id)
    }

    // Hàm lấy thông tin đơn hàng từ DB
    public static Order getOrderById(int orderId) {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        Order order = null;
        
        try {
            conn = new DBContext().getConnection();
            psmt = conn.prepareStatement(SELECT_ORDER_BY_ID);
            psmt.setInt(1, orderId);
            rs = psmt.executeQuery();
            
            if (rs.next()) {
                order = new Order();
                order.setOrder_id(rs.getInt("order_id"));
                order.setUser_id(rs.getInt("user_id"));
                order.setOrder_date(rs.getDate("order_date"));
                order.setTotal_amount(rs.getDouble("total_amount"));
                order.setPayment_method(rs.getInt("payment_method"));
                order.setVoucher_id(rs.getInt("voucher_id"));
                order.setOrder_status(rs.getString("order_status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (psmt != null) psmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return order;
    }
}