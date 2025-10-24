<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Order" %>
<%@ page import="model.CartItem" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin đơn hàng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .order-details {
            margin: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .order-header {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .order-info {
            margin-bottom: 20px;
        }
        .order-info p {
            margin: 5px 0;
        }
        .product-list {
            margin-top: 20px;
            border-collapse: collapse;
            width: 100%;
        }
        .product-list th, .product-list td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .total-price {
            font-size: 18px;
            font-weight: bold;
            text-align: right;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="order-details">
        <div class="order-header">
            Thông tin đơn hàng
        </div>

        <!-- Hiển thị thông tin đơn hàng -->
        <div class="order-info">
            <p><strong>Mã đơn hàng:</strong> ${order.order_id}</p>
            <p><strong>Ngày đặt:</strong> ${order.order_date}</p>
            <p><strong>Tổng số tiền:</strong> <fmt:formatNumber value="${order.total_amount}" type="currency" currencySymbol="₫" /></p>
            <p><strong>Phương thức thanh toán:</strong> ${order.payment_method}</p>
            <p><strong>Trạng thái đơn hàng:</strong> ${order.order_status}</p>
        </div>

        <!-- Hiển thị danh sách sản phẩm trong đơn hàng -->
        <div class="order-info">
            <h3>Danh sách sản phẩm trong đơn hàng:</h3>
            <table class="product-list">
                <thead>
                    <tr>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Giá mỗi sản phẩm</th>
                        <th>Tổng tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // Lấy thông tin sản phẩm từ giỏ hàng (cartItems)
                        List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
                        if (cartItems != null) {
                            for (CartItem item : cartItems) {
                    %>
                    <tr>
                        <td>${item.product_name}</td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" /></td>
                        <td><fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="₫" /></td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4">Không có sản phẩm nào trong đơn hàng này.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="total-price">
            Tổng cộng: <fmt:formatNumber value="${order.total_amount}" type="currency" currencySymbol="₫" />
        </div>
    </div>

</body>
</html>
