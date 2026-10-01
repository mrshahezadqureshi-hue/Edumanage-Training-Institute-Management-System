<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Feedback - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/student-sidebar.jsp" />
    <div class="main-content">
        <h2>My Feedback</h2>
        <table>
            <tr><th>Task</th><th>Marks</th><th>Feedback</th><th>Status</th></tr>
            <c:forEach var="s" items="${submissions}">
                <tr>
                    <td>${s.task.title}</td>
                    <td>${s.marks != null ? s.marks : '-'}</td>
                    <td>${s.feedback != null ? s.feedback : 'Awaiting review'}</td>
                    <td>${s.status}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
