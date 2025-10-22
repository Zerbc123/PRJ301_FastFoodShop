/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 *
 * @author Dell
 */
public class ProductDAO extends DBContext {

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "select product_id, product_name, [description], price, image_url, category_id FROM Product";
        try {
            PreparedStatement st = this.getConnection().prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()){
                Product p = new Product();
                p.setProduct_id(rs.getInt("product_id"));
                p.setProduct_name(rs.getString("product_name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImage_url(rs.getString("image_url"));
                p.setCategory_id(rs.getInt("category_id"));
                list.add(p);
            }
        } catch (SQLException ex) {
            System.getLogger(ProductDAO.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        return list;
    }
}
