<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="common/navbar.jsp" />

<div class="form-container">
    <h2>Login</h2>

    <c:if test="${param.error != null}">
        <div class="alert-error">Invalid username or password.</div>
    </c:if>
    <c:if test="${param.logout != null}">
        <div class="alert-success">You have been logged out.</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/perform_login" method="post">
        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>
        <button type="submit" class="btn-primary">Login</button>
    </form>
    <p style="margin-top:14px; font-size: 13px; color:#777;">
        Admin / Trainer / Student — same login, redirected to your dashboard automatically.
    </p>
</div>

<div class="footer">&copy; 2026 EduManage. All rights reserved.</div>
</body>
</html>
