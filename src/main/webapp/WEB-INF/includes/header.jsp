<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

        <div class="collapse navbar-collapse justify-content-end" id="navbarCollapse">
            <form class="d-flex me-3" action="${pageContext.request.contextPath}/search" method="get">
                <input class="form-control me-2" type="search" name="keyword" placeholder="Search..." aria-label="Search">
                <button class="btn btn-outline-light" type="submit">Search</button>
            </form>

            <a href="${pageContext.request.contextPath}/cart" class="btn btn-warning me-3">
                ? Cart
            </a>

            <ul class="navbar-nav mb-2 mb-md-0">
                <c:choose>
                    <c:when test="${not empty loggedInUser}">
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/logout">
                                Hi ${loggedInUser.full_name}, logout
                            </a>
                        </li>
                    </c:when>

                    <c:otherwise>
                        <li class="nav-item me-2">
                            <a class="btn btn-outline-success" href="${pageContext.request.contextPath}/login">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/signup">Sign up</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>


    </div>
</nav>
