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

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

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
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
    }

    // Xử lý phương thức POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy session hiện tại
        HttpSession session = request.getSession();

        // Lấy giỏ hàng từ session
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        // Lấy phương thức thanh toán từ form
        String paymentMethod = request.getParameter("paymentMethod");  // Lấy giá trị phương thức thanh toán

        // Kiểm tra nếu giỏ hàng có sản phẩm
        if (cart != null && !cart.isEmpty()) {
            // Tạo một đối tượng Order mới
            Order order = new Order();
            order.setUser_id((int) session.getAttribute("userId"));  // Giả sử userId đã có trong session

            // Gọi phương thức calculateTotalAmount trong ProductDAO để tính tổng tiền
            ProductDAO productDAO = new ProductDAO();
            double totalAmount = productDAO.calculateTotalAmount(cart); // Tính tổng giỏ hàng từ ProductDAO
            order.setTotal_amount(totalAmount);  // Gán tổng tiền giỏ hàng vào đối tượng Order

            // Cập nhật phương thức thanh toán và trạng thái đơn hàng
            if (paymentMethod != null && paymentMethod.equals("credit_card")) {
                order.setPayment_method(1);  // 1 có thể là mã cho phương thức thanh toán (Credit Card)
            } else {
                order.setPayment_method(0);  // 0 có thể là mã cho phương thức thanh toán khác
            }
            order.setOrder_status("Pending");  // Trạng thái đơn hàng
            order.setVoucher_id(0);  // Nếu không có voucher, set là 0

            // Lưu đơn hàng vào cơ sở dữ liệu thông qua OrderDAO và lấy order_id trả về
            order = OrderDAO.saveOrder(order);  // Lưu đơn hàng và lấy order_id trả về

            // Chuyển Map thành List trước khi lưu vào CartItemDAO
            List<CartItem> cartItems = new ArrayList<>(cart.values());  // Chuyển đổi Map thành List

            // Lưu thông tin các sản phẩm vào bảng CartItem cho đơn hàng
            for (CartItem item : cartItems) {
                item.setCart_id(order.getOrder_id());  // Gán order_id cho mỗi CartItem
                CartItemDAO.saveCartItem(item);  // Lưu các sản phẩm vào bảng CartItem
            }

            // Xóa giỏ hàng khỏi session sau khi thanh toán
            session.removeAttribute("cart");

            // Chuyển hướng đến trang order.jsp và truyền thông tin đơn hàng
            request.setAttribute("order", order);
            request.getRequestDispatcher("/order.jsp").forward(request, response);
        } else {
            // Nếu giỏ hàng trống, chuyển hướng về trang giỏ hàng
            response.sendRedirect("cart.jsp");
        }
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
