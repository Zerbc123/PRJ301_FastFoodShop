/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class CartItemWithDetails {
     private int carti_id;
    private int product_id;
    private int quantity;
    private String productName;
    private String imageUrl;
    private double price;

    public CartItemWithDetails(int carti_id, int product_id, int quantity, String productName, String imageUrl, double price) {
        this.carti_id = carti_id;
        this.product_id = product_id;
        this.quantity = quantity;
        this.productName = productName;
        this.imageUrl = imageUrl;
        this.price = price;
    }

    // Getters and setters
    public int getCarti_id() {
        return carti_id;
    }

    public void setCarti_id(int carti_id) {
        this.carti_id = carti_id;
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

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}

