<%-- 
    Document   : signup
    Created on : Oct 21, 2025, 8:07:30 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body class="container mt-5">
        <form method="post" action="${pageContext.request.contextPath}/signup" class="container mt-5">
            <h2>Sign Up</h2>

            <div class="mb-3">
                <label>Full Name</label>
                <input type="text" name="full_name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Phone Number</label>
                <input type="text" name="phone_number" class="form-control">
            </div>

            <div class="mb-3">
                <label>Address</label>
                <input type="text" name="address" class="form-control">
            </div>

            <button type="submit" class="btn btn-primary">Create Account</button>

            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3">${error}</div>
            </c:if>
        </form>
</body>
</html>
