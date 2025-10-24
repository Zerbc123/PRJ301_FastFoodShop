<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh Sách Sản Phẩm</title>
        <!-- Kết nối Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .product-card {
                margin-bottom: 30px;
            }
            .product-image {
                max-height: 200px;
                object-fit: cover;
                width: 100%;
                border-radius: 8px;
            }
            .product-card-body {
                text-align: center;
            }
            .product-card-body h5 {
                font-size: 1.25rem;
                font-weight: bold;
            }
            .product-card-body p {
                font-size: 1rem;
                color: #777;
            }
            .product-card-body .price {
                font-size: 1.25rem;
                font-weight: bold;
                color: #009688;
            }
        </style>
    </head>
    <body>

        <div class="container mt-5">
            <h2 class="text-center mb-4">Danh Sách Sản Phẩm</h2>

            <!-- Kiểm tra nếu danh sách sản phẩm trống -->
            <c:if test="${empty products}">
                <div class="alert alert-warning text-center">
                    Không có sản phẩm nào để hiển thị.
                </div>
            </c:if>

            <!-- Sử dụng grid layout của Bootstrap để hiển thị các sản phẩm -->
            <div class="row">
                <!-- Duyệt qua danh sách sản phẩm -->
                <c:forEach var="product" items="${products}">
                    <div class="col-md-4 mb-4">
                        <div class="card product-card">
                            <!-- Hiển thị hình ảnh sản phẩm -->
                            <img class="card-img-top product-image" 
                                 src="${pageContext.request.contextPath}/image/${product.image_url}" 
                                 alt="${product.product_name}">
                            <div class="card-body product-card-body">
                                <h5 class="card-title">${product.product_name}</h5>
                                <p class="card-text">${product.description}</p>
                                <p class="price">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"></fmt:formatNumber>
                                    </p>
                                    <!-- Form để thêm sản phẩm vào giỏ -->
                                    <form action="manager" method="post">
                                        <input type="hidden" name="productId" value="${product.product_id}">
                                    <input type="number" name="quantity" value="1" min="1" class="form-control mb-2" />
                                    <input type="hidden" name="action" value="addToCart" />
                                    <button type="submit" class="btn btn-primary btn-block">Thêm vào giỏ</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Kết nối Bootstrap JS và Popper.js -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>
</html>
