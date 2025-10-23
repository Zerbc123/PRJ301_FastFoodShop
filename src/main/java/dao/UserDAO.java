/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author Dell
 */
public class UserDAO extends DBContext {

    public User login(String email, String password) {
        try {
            String query = "SELECT user_id, full_name, role_id FROM [User] WHERE email = ? AND password = ?";
            PreparedStatement st = this.getConnection().prepareStatement(query);
            st.setString(1, email);
            st.setString(2, this.hashMd5(password)); // Mã hóa mật khẩu để so sánh

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("user_id"), rs.getString("full_name"), email, null, null, null, rs.getInt("role_id"), LocalDateTime.now());
            }
        } catch (SQLException ex) {
            System.getLogger(UserDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return null;
    }

    private String hashMd5(String raw) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] mess = md.digest(raw.getBytes());

            StringBuilder sb = new StringBuilder();
            for (byte b : mess) {
                sb.append(String.format("%02x", b));
            }

            return sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        }
    }

    public int signup(String full_name, String email, String password, String phone_number, String address) {
        String sql = "INSERT INTO [User] (full_name, email, [password], phone_number, [address], role_id) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = this.getConnection().prepareStatement(sql);
            st.setString(1, full_name);
            st.setString(2, email);
            st.setString(3, this.hashMd5(password)); // Mã hóa mật khẩu
            st.setString(4, phone_number);
            st.setString(5, address);
            st.setInt(6, 2); // 2 = user thường (role_id 2)

            return st.executeUpdate(); // trả về 1 nếu thành công
        } catch (SQLException ex) {
            System.getLogger(UserDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return 0;
    }

    public boolean exists(String email) {
        String sql = "SELECT COUNT(*) FROM [User] WHERE email = ?";
        try {
            PreparedStatement st = this.getConnection().prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException ex) {
            System.getLogger(UserDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return false;
    }
}
