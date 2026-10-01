<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="navbar">
    <div class="brand">Edu<span>Manage</span></div>
    <ul>
        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/about">About</a></li>
        <li><a href="${pageContext.request.contextPath}/courses">Courses</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
        <li><a class="btn-login" href="${pageContext.request.contextPath}/login">Login</a></li>
    </ul>
</div>
<jsp:include page="/WEB-INF/views/common/theme-chatbot.jsp" />
