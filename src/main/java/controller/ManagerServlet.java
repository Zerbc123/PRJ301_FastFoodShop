/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.CartItem;
import model.CartItemWithDetails;
import model.Product;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ManagerServlet", urlPatterns = {"/manager"})
public class ManagerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String view = request.getParameter("view");
        if (view == null) {
            view = "foodshop";
        }

        switch (view) {
            case "order":
                handleOrder(request, response);
                break;
            case "product":
                handleProduct(request, response);
                break;
            case "cart":
                handleCart(request, response);
                break;
            case "admin":
                handleAdmin(request, response);
                break;
            default:
                response.sendRedirect("404.jsp");
                break;
        }
    }

    private void handleOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderDetails = "Thông tin đơn hàng";
        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("/WEB-INF/view/order.jsp").forward(request, response);
    }

    private void handleProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getAllProduct();
        if (products != null && !products.isEmpty()) {
            request.setAttribute("products", products);
        } else {
            request.setAttribute("message", "Không có sản phẩm nào.");
        }
        request.getRequestDispatcher("/WEB-INF/view/product.jsp").forward(request, response);
    }

   private void handleCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

    if (cart == null || cart.isEmpty()) {
        request.setAttribute("message", "Giỏ hàng của bạn đang trống.");
    } else {
        // Lấy thông tin sản phẩm từ DB và thêm vào CartItem
        ProductDAO productDAO = new ProductDAO();
        List<CartItemWithDetails> cartWithDetails = new ArrayList<>();

        for (CartItem item : cart.values()) {
            Product product = productDAO.getProductById(item.getProduct_id());
            if (product != null) {
                // Tạo CartItemWithDetails chứa thông tin sản phẩm
                CartItemWithDetails itemWithDetails = new CartItemWithDetails(item.getCart_id(), item.getProduct_id(), item.getQuantity(), product.getProduct_name(), product.getImage_url(), product.getPrice());
                cartWithDetails.add(itemWithDetails);
            }
        }

        // Gửi thông tin giỏ hàng với sản phẩm vào JSP
        request.setAttribute("cart", cartWithDetails);
    }

    request.getRequestDispatcher("/WEB-INF/view/cart.jsp").forward(request, response);
}

    private void handleAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String adminDetails = "Thông tin quản lý admin";
        request.setAttribute("admin", adminDetails);
        request.getRequestDispatcher("/WEB-INF/view/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }

        switch (action) {
            case "addToCart":
                addToCart(request, cart);
                break;
            case "removeFromCart":
                removeFromCart(request, cart);
                break;
            case "decreaseQuantity":
                updateQuantity(request, cart, false);
                break;
            case "increaseQuantity":
                updateQuantity(request, cart, true);
                break;
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("manager?view=cart");
    }

    private void addToCart(HttpServletRequest request, Map<Integer, CartItem> cart) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        if (product != null) {
            if (cart.containsKey(productId)) {
                CartItem existingItem = cart.get(productId);
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
            } else {
                CartItem item = new CartItem(0, productId, quantity);
                cart.put(productId, item);
            }
        }
    }

    private void removeFromCart(HttpServletRequest request, Map<Integer, CartItem> cart) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        cart.remove(productId);
    }

    private void updateQuantity(HttpServletRequest request, Map<Integer, CartItem> cart, boolean increase) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        CartItem item = cart.get(productId);

        if (item != null) {
            int newQuantity = increase ? item.getQuantity() + 1 : item.getQuantity() - 1;
            if (newQuantity > 0) {
                item.setQuantity(newQuantity);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "ManagerServlet handles cart and product management";
    }
}