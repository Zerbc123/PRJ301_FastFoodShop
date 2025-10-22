<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Duy Le Food</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="assets/css/sign-in.css"/>
        <style>
            #nav {
                margin-left: 900px;
            }
            .butt input {
                background-color: blue;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Fast Food Shop</a>
                <button
                    class="navbar-toggler"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse"
                    aria-controls="navbarCollapse"
                    aria-expanded="false"
                    aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <ul class="navbar-nav me-auto mb-2 mb-md-0"></ul>

                    <ul id="nav" class="navbar-nav me-auto mb-2 mb-md-0">
                        <c:choose>
                            <c:when test="${not empty loggedInUser}">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                        Hi ${loggedInUser.full_name}, logout
                                    </a>
                                </li>
                            </c:when>

                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                        <button type="button" class="btn btn-outline-success">Login</button>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/signup">
                                        <button type="button" class="btn btn-outline-primary">Sign up</button>
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>
    </body>
</html>