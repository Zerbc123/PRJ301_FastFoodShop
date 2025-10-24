package dao;

import db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CartItem;
import model.Product;

public class ProductDAO {

    private Connection conn;

    public ProductDAO() {
        DBContext dbContext = new DBContext();
        this.conn = dbContext.getConnection();
        if (this.conn == null) {
            System.out.println("Connection is null! Cannot proceed with database operations.");
        }
    }

    // Phương thức lấy tất cả sản phẩm
    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT product_id, product_name, description, price, image_url, category_id FROM Product";
        try (PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
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
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Error in getAllProduct", ex);
        }
        return list;
    }

    // Phương thức lấy thông tin sản phẩm theo productId
    public static Product getProductById(int productId) {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        Product product = null;

        try {
            conn = new DBContext().getConnection();
            String SELECT_PRODUCT_BY_ID = "SELECT product_id, product_name, price, image_url FROM Product WHERE product_id = ?";
            psmt = conn.prepareStatement(SELECT_PRODUCT_BY_ID);
            psmt.setInt(1, productId);

            rs = psmt.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setProduct_id(rs.getInt("product_id"));
                product.setProduct_name(rs.getString("product_name"));
                product.setPrice(rs.getDouble("price"));
                product.setImage_url(rs.getString("image_url"));  // Lấy thêm URL hình ảnh
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (psmt != null) {
                    psmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return product;
    }

    // Phương thức thêm sản phẩm
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO Product (product_name, description, price, image_url, category_id, created_at) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, product.getProduct_name());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setString(4, product.getImage_url());
            stmt.setInt(5, product.getCategory_id());
            stmt.setTimestamp(6, new java.sql.Timestamp(product.getCreated_at().getTime()));

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, "Error in addProduct", e);
            return false;
        }
    }
    // Phương thức tính tổng số tiền giỏ hàng

    // Phương thức tính tổng số tiền giỏ hàng
    public double calculateTotalAmount(Map<Integer, CartItem> cart) {
        double totalAmount = 0.0;

        if (cart != null && !cart.isEmpty()) {
            // Duyệt qua giỏ hàng để tính tổng
            for (CartItem item : cart.values()) {
                Product product = ProductDAO.getProductById(item.getProduct_id()); // Lấy thông tin sản phẩm từ DB
                if (product != null) {
                    totalAmount += product.getPrice() * item.getQuantity(); // Tính tổng tiền cho mỗi sản phẩm
                }
            }
        }

        return totalAmount;
    }

}
