<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <!-- Connect Bootstrap and Font Awesome -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"> <!-- Font Awesome -->

    <style>
        /* Ensure body takes full height of the screen */
        html, body {
            height: 100%;
            margin: 0;
        }

        /* Use Flexbox to ensure footer is always at the bottom */
        body {
            display: flex;
            flex-direction: column;
        }

        .container.mt-5 {
            flex: 1;
            margin-top: 100px; /* Create space between header and shopping cart */
        }

        h2 {
            margin-top: 40px;
            text-align: center;
        }

        footer {
            margin-top: auto;
        }

        /* Improve table design */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 15px;
            text-align: center;  /* Center the text inside the table */
        }

        th {
            background-color: #f8f9fa;
        }

        img {
            max-width: 100px;
            height: auto;
        }

        .cart-total {
            font-size: 1.25rem;
            font-weight: bold;
            text-align: right; /* Right align the total amount */
        }

        /* Button hover effects */
        .cart-actions button {
            margin: 5px;
            transition: transform 0.3s ease-in-out, background-color 0.3s ease-in-out;
            font-size: 18px;
        }

        .cart-actions button:hover {
            transform: scale(1.1);  /* Button scales up on hover */
            background-color: #007bff;
        }

        /* Icon for buttons */
        .btn-lg i, .btn-sm i {
            margin-right: 8px;
        }

        .btn-lg {
            width: 200px;
        }

        /* Custom styles for action buttons */
        .action-buttons .btn {
            width: 40px;
            height: 40px;
            padding: 8px;
            font-size: 18px;
        }

        /* Styling for Proceed and Back buttons in a horizontal layout */
        .button-group {
            display: flex;
            justify-content: center; /* Center the buttons */
            gap: 20px; /* Add space between the buttons */
            margin-top: 30px;
        }

        .proceed-button, .back-button {
            width: 200px;
            height: 50px;
            font-size: 18px;
            border-radius: 25px;
            padding: 10px;
            display: flex;
            align-items: center; /* Vertically center text and icon */
            justify-content: center;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        /* Default background color for both buttons */
        .proceed-button {
            background-color: #6c757d; /* Gray color for Proceed */
            color: white;
        }

        .back-button {
            background-color: #6c757d; /* Gray color for Back */
            color: white;
        }

        /* Hover effect for both buttons */
        .proceed-button:hover, .back-button:hover {
            background-color: #28a745; /* Green color on hover */
            color: white;
            transform: scale(1.05);
        }

        .proceed-button i, .back-button i {
            margin-right: 10px; /* Space between icon and text */
        }

        .proceed-button:focus, .back-button:focus {
            outline: none;
        }

        /* Modal styling */
        .modal-dialog {
            max-width: 500px;
        }

        /* Styling for confirmation section */
        .confirmation-section {
            display: none; /* Initially hidden */
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f8f9fa;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .confirmation-header {
            font-size: 1.5rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }

        .confirmation-details {
            margin-bottom: 20px;
        }

        .confirmation-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .confirmation-buttons button {
            width: 150px;
            padding: 10px;
            font-size: 16px;
            border-radius: 25px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .confirm-button {
            background-color: #28a745;
            color: white;
            border: none;
        }

        .cancel-button {
            background-color: #dc3545;
            color: white;
            border: none;
        }

        .confirm-button:hover {
            background-color: #218838;
        }

        .cancel-button:hover {
            background-color: #c82333;
        }

        .confirmation-buttons button:focus {
            outline: none;
        }

        .confirmation-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }

        .confirmation-item:last-child {
            border-bottom: none;
        }

        .total-price {
            font-weight: bold;
            font-size: 1.2rem;
            text-align: right;
            margin-top: 20px;
        }

        /* Success message */
        .success-message {
            display: none;
            margin-top: 30px;
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            color: #28a745;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/includes/header.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4">Shopping Cart <i class="fas fa-shopping-cart"></i></h2>

    <!-- Check if the cart is empty -->
    <c:if test="${empty cart}">
        <div class="alert alert-warning text-center">
            Your cart is currently empty.
        </div>
    </c:if>

    <!-- Shopping cart table -->
    <table class="table table-bordered table-striped">
        <thead class="thead-light">
            <tr>
                <th>Product Name</th>
                <th>Image</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${cart}">
                <tr>
                    <td>${item.productName}</td> <!-- Display product name -->
                    <td><img src="${pageContext.request.contextPath}${item.imageUrl}" alt="${item.productName}" class="img-fluid" style="max-width: 100px; height: auto;"></td> <!-- Display image -->
                    <td><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫"></fmt:formatNumber></td> <!-- Display price -->
                    <td>${item.quantity}</td> <!-- Display quantity -->
                    <td><fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="₫"></fmt:formatNumber></td> <!-- Display total -->
                    <td>
                        <!-- Remove product button -->
                        <form action="manager" method="post" class="d-inline">
                            <input type="hidden" name="productId" value="${item.product_id}">
                            <input type="hidden" name="action" value="removeFromCart">
                            <button type="submit" class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i></button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Calculate total amount to be paid -->
    <c:set var="totalAmount" value="0" />
    <c:forEach var="item" items="${cart}">
        <c:set var="totalAmount" value="${totalAmount + (item.price * item.quantity)}" />
    </c:forEach>

    <div class="row justify-content-end">
        <div class="col-md-4">
            <h4 class="text-right cart-total">Total amount to pay: 
                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫"></fmt:formatNumber>
            </h4>
        </div>
    </div>

    <!-- Proceed to checkout button and Back button -->
    <div class="button-group">
        <!-- Proceed to Checkout button -->
        <button class="btn proceed-button" onclick="showConfirmationSection()">
            <i class="fas fa-credit-card"></i> Proceed to Checkout
        </button>

        <!-- Back to Product page button -->
        <a href="${pageContext.request.contextPath}/food-shop" class="btn back-button">
            <i class="fas fa-arrow-left"></i> Back to Products
        </a>
    </div>

    <!-- Confirmation Section (Initially Hidden) -->
    <div class="confirmation-section">
        <div class="confirmation-header">Please confirm your purchase:</div>
        <div class="confirmation-details" id="confirmationDetails"></div> <!-- Product details will be inserted here -->
        
        <div class="total-price">
            <p>Total Price: <span id="totalAmountInConfirmation"></span></p>
        </div>

        <div class="confirmation-buttons">
            <button class="btn confirm-button" onclick="proceedToPayment()">Yes</button>
            <button class="btn cancel-button" onclick="cancelCheckout()">No</button>
        </div>
    </div>

    <!-- Success Message -->
    <div class="success-message" id="successMessage">
        You have successfully completed the payment. Thank you for your order!
    </div>
</div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    function showConfirmationSection() {
        var cartItems = [];
        var totalAmount = 0;
        <%-- Loop through cart items in JSP and generate cart data --%>
        <c:forEach var="item" items="${cart}">
            cartItems.push({
                productName: "${item.productName}",
                quantity: "${item.quantity}",
                price: "${item.price}",
                total: "${item.price * item.quantity}"
            });
            totalAmount += ${item.price * item.quantity};
        </c:forEach>

        var confirmationDetails = "";
        cartItems.forEach(function(item) {
            confirmationDetails += "<div class='confirmation-item'>";
            confirmationDetails += "<span>" + item.productName + " (" + item.quantity + " x " + item.price + "₫)</span>";
            confirmationDetails += "<span>" + item.total + "₫</span>";
            confirmationDetails += "</div>";
        });

        document.getElementById("confirmationDetails").innerHTML = confirmationDetails;
        document.getElementById("totalAmountInConfirmation").innerText = totalAmount + "₫";
        document.querySelector('.confirmation-section').style.display = 'block'; 
    }

    function proceedToPayment() {
        document.getElementById("successMessage").style.display = "block";  
        alert("You have successfully paid Cash on Delivery. Your total payment is " + document.getElementById("totalAmountInConfirmation").innerText);
        
        setTimeout(function() {
            window.location.href = "${pageContext.request.contextPath}/manager?view=order";  
        }, 0);  
    }

    function cancelCheckout() {
        document.querySelector('.confirmation-section').style.display = 'none';
    }
</script>

</body>
</html>
