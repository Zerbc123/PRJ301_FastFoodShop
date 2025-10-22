
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/includes/header.jsp" %>

<style>
    .form-signin {
        transform: translateY(100px);
        max-width: 400px;
    }
</style>

<main class="form-signin w-100 m-auto">
    <form action="${pageContext.request.contextPath}/login" method="POST">
        <h1 class="h3 mb-3 fw-normal text-center">Please sign in</h1>

        <!-- Hiển thị thông báo lỗi -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="form-floating mb-3">
            <input
                type="text"
                name="email"
                class="form-control"
                id="floatingInput"
                placeholder="Email"
                />
            <label for="floatingInput">Email address</label>
        </div>

        <div class="form-floating mb-3">
            <input
                type="password"
                name="password"
                class="form-control"
                id="floatingPassword"
                placeholder="Password"
                />
            <label for="floatingPassword">Password</label>
        </div>

        <button class="btn btn-primary w-100 py-2" type="submit">Sign in</button>
        <p class="mt-5 mb-3 text-body-secondary text-center">&copy; 2017–2025</p>
    </form>
</main>