/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartItemDAO;
import dao.OrderDAO;
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
import java.util.List;
import java.util.Map;
import model.CartItem;
import model.Order;
import model.Product;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/order"})
public class OrderServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    // Lấy giỏ hàng từ session
    HttpSession session = request.getSession();
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("cart.jsp");  // Nếu giỏ hàng trống, chuyển về giỏ hàng
        return;
    }

    // Tính tổng giá trị đơn hàng
    double totalAmount = 0;
    List<CartItem> cartItems = new ArrayList<>();
    for (CartItem item : cart.values()) {
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(item.getProduct_id());
        if (product != null) {
            totalAmount += product.getPrice() * item.getQuantity();
            // Lưu thông tin sản phẩm vào danh sách cartItems
            cartItems.add(item);
        }
    }

    // Tạo đối tượng Order
    Order order = new Order();
    order.setUser_id(1);  // Ví dụ, dùng userId tạm thời
    order.setTotal_amount(totalAmount);
    order.setPayment_method(1);  // Giả sử thanh toán bằng tiền mặt (COD)
    order.setVoucher_id(0);  // Giả sử không sử dụng voucher
    order.setOrder_status("Processing");

    // Lưu đơn hàng vào cơ sở dữ liệu
    OrderDAO orderDAO = new OrderDAO();
    Order savedOrder = orderDAO.saveOrder(order);  // Lưu đơn hàng và nhận lại order với order_id

    // Lưu thông tin sản phẩm của đơn hàng vào cơ sở dữ liệu (CartItem)
    for (CartItem item : cartItems) {
        CartItemDAO.saveCartItem(item);  // Lưu từng CartItem vào cơ sở dữ liệu
    }

    // Chuyển thông tin đơn hàng sang order.jsp
    request.setAttribute("order", savedOrder);
    request.setAttribute("cartItems", cartItems);  // Lưu thông tin sản phẩm vào request
    request.getRequestDispatcher("/WEB-INF/view/order.jsp").forward(request, response);

    // Xóa giỏ hàng khỏi session sau khi đặt hàng
    session.removeAttribute("cart");
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
