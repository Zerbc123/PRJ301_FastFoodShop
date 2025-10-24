<%-- 
    Document   : dashboard
    Created on : 24 thg 10, 2025, 22:31:29
    Author     : dile
--%>

<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="model.User"%>
<%
    User admin = (User) session.getAttribute("loggedInUser");
    
    
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial; margin: 0; }
        header { background: #2c3e50; padding: 15px; color: white; }
        .container { padding: 20px; }
        a.btn { padding: 10px 16px; background: #009688; color: white; 
               text-decoration: none; margin-right: 10px; border-radius: 5px; }
    </style>
</head>
<body>

<header>Admin Dashboard</header>
<div class="container">
    
    <p>Hi Admin, <b><%= admin.getFull_name() %></b></p>
    <a href="<%= request.getContextPath() %>/logout" class="btn" style="background:#e74c3c;">Logout</a>
    
    <a href="products.jsp" class="btn">Product Management</a>
    <a href="users.jsp" class="btn">User Management</a>
    

</div>

</body>
</html>