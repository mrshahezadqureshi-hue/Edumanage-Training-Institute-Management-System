<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Students - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/trainer-sidebar.jsp" />
    <div class="main-content">
        <h2>Students in ${batch.batchName}</h2>
        <p style="color:var(--text-muted); margin-bottom:20px;">${batch.courseName}</p>

        <c:if test="${empty students}">
            <p style="color:var(--text-muted);">No students assigned to this batch yet.</p>
        </c:if>

        <c:if test="${not empty students}">
        <table>
            <tr><th>Name</th><th>Username</th><th>Email</th><th>Phone</th></tr>
            <c:forEach var="s" items="${students}">
                <tr>
                    <td>${s.fullName}</td>
                    <td>${s.username}</td>
                    <td>${s.email}</td>
                    <td>${s.phone}</td>
                </tr>
            </c:forEach>
        </table>
        </c:if>

        <a href="${pageContext.request.contextPath}/trainer/dashboard" class="btn-secondary" style="display:inline-block; margin-top:16px;">Back to Dashboard</a>
    </div>
</div>
</body>
</html>
