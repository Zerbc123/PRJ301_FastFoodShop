<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Duy Le Food</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="assets/css/sign-in.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"> <!-- Font Awesome -->
        <style>
            /* Banner style */
            .banner {
                width: 100%;
                height: 300px;
                background-image: url('<%= request.getContextPath()%>/assets/banner/banner.jpg');
                background-size: cover;
                background-position: center;
                display: flex;
                justify-content: center;
                align-items: center;
                color: white;
                font-size: 2.5rem;
                text-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);
                margin-bottom: 30px;
            }

            .banner-text {
                text-align: center;
                font-weight: bold;
                text-transform: uppercase;
            }

            /* Phóng to hình ảnh khi di chuột vào */
            .product-image-container {
                position: relative;
                overflow: hidden;
                transition: transform 0.3s ease-in-out;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Bóng đổ nhẹ cho khung sản phẩm */
            }

            .product-image-container img {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .product-image-container:hover img {
                transform: scale(1.1);  /* Phóng to hình ảnh */
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15); /* Hiệu ứng bóng đổ khi hover */
            }

            /* Nút thêm giỏ hàng đẹp hơn với icon */
            .btn-add-to-cart {
                background-color: #28a745;
                color: white;
                border-radius: 25px;
                padding: 12px 30px;
                font-size: 16px;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
                width: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .btn-add-to-cart i {
                margin-right: 10px;
            }

            .btn-add-to-cart:hover {
                background-color: #218838;
                transform: scale(1.05);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            .btn-add-to-cart:focus {
                outline: none;
            }

            /* Nút xem chi tiết */
            .btn-view-details {
                background-color: #007bff;
                color: white;
                border-radius: 50%;
                padding: 12px;
                font-size: 20px;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                margin-top: 10px;
            }

            .btn-view-details:hover {
                background-color: #0056b3;
                transform: scale(1.1);
            }

            .btn-view-details:focus {
                outline: none;
            }

            /* Cải thiện bố cục sản phẩm */
            .container {
                margin-top: 50px;
            }

            /* Cải thiện khoảng cách giữa các sản phẩm */
            .product-container {
                padding: 20px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            /* Tạo hiệu ứng hover cho các khung sản phẩm */
            .product-container:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            }

            .product-name {
                font-size: 1.1rem;
                font-weight: bold;
                color: #333;
            }

            .product-description {
                font-size: 0.9rem;
                color: #777;
                margin-top: 10px;
            }

            .row {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .col-md-4 {
                width: 30%;
                margin-bottom: 20px;
            }

            @media screen and (max-width: 768px) {
                .col-md-4 {
                    width: 45%;
                }
            }

            @media screen and (max-width: 480px) {
                .col-md-4 {
                    width: 100%;
                }
            }

            /* Modal/Popup Styling */
            .modal-content {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .modal-header {
                font-size: 1.5rem;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .modal-body {
                font-size: 1rem;
                color: #555;
            }

            .modal-footer {
                text-align: center;
            }
        </style>
    </head>
    <body>

       <%-- Kiểm tra nếu có thông báo trong session và hiển thị nó --%>
        <% String message = (String) session.getAttribute("message"); %>
        <% if (message != null) { %>
            <div class="alert alert-success">
                <%= message %>
            </div>
            <% session.removeAttribute("message"); %> <!-- Xóa thông báo sau khi hiển thị -->
        <% } %>

        <%@ include file="/WEB-INF/includes/header.jsp" %>

        <!-- Banner Section -->
        <div class="banner">
            <div class="banner-text">
                <h1>Welcome to Duy Le Food</h1>
                <p>Enjoy delicious meals and great deals!</p>
            </div>
        </div>

        <div style="margin-top: 50px;">
            <h2 class="text-center mb-4">🍔 Danh sách sản phẩm</h2>
            <div class="container">
                <div class="row">
                    <%
                        List<Product> products = (List<Product>) request.getAttribute("products");
                        if (products != null && !products.isEmpty()) {
                            for (Product p : products) {
                    %>
                    <div class="col-md-4 mb-4 text-center product-container">
                        <!-- Apply hover effect on image container -->
                        <div class="product-image-container">
                            <img src="<%= request.getContextPath() + p.getImage_url()%>"
                                 alt="<%= p.getProduct_name()%>" 
                                 class="img-fluid rounded"
                                 style="width: 100%; height:200px; object-fit:cover;">
                        </div>
                        <p class="product-name mt-2"><%= p.getProduct_name()%></p>
                        <p class="product-description"><%= p.getDescription()%></p>
                        <p class="text-danger fw-bold"><%= p.getPrice()%> $</p>
                        <!-- Form để thêm sản phẩm vào giỏ hàng -->
                        <form action="${pageContext.request.contextPath}/manager" method="post">
                            <input type="hidden" name="productId" value="<%= p.getProduct_id()%>">
                            <input type="hidden" name="quantity" value="1" />
                            <input type="hidden" name="action" value="addToCart" />
                            <button type="submit" class="btn-add-to-cart mt-2">
                                <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                            </button>
                        </form>
                        <!-- Button xem chi tiết -->
                        <button class="btn-view-details" data-toggle="modal" data-target="#productModal<%= p.getProduct_id()%>">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>

                    <!-- Modal for Product Details -->
                    <div class="modal fade" id="productModal<%= p.getProduct_id()%>" tabindex="-1" aria-labelledby="productModalLabel<%= p.getProduct_id()%>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="productModalLabel<%= p.getProduct_id()%>"><%= p.getProduct_name()%></h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <p><strong>Description:</strong> <%= p.getDescription()%></p>
                                    <p><strong>Price:</strong> <fmt:formatNumber value="<%= p.getPrice()%>" type="currency" currencySymbol="₫"></fmt:formatNumber></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                        <!-- Xử lý khi thanh toán -->
                        <div class="button-group">
                            <a href="${pageContext.request.contextPath}/checkout" class="btn proceed-button">
                                Proceed to Checkout
                            </a>
                        </div>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <p>Không có sản phẩm nào để hiển thị!</p>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/includes/footer.jsp" %>

        <script src="assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
