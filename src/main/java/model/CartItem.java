package model;

/**
 *
 * @author ADMIN
 */
public class CartItem {
    private int cart_id;       // ID của giỏ hàng
    private int product_id;    // ID của sản phẩm
    private int quantity;     // Số lượng sản phẩm

    public CartItem() {
    }

    public CartItem(int carti_id, int product_id, int quantity) {
        this.cart_id = carti_id;
        this.product_id = product_id;
        this.quantity = quantity;
    }

    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int carti_id) {
        this.cart_id = carti_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

   
}
