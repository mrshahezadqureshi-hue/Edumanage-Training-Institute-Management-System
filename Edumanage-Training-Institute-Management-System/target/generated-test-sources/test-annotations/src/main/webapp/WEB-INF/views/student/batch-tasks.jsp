<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tasks - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/student-sidebar.jsp" />
    <div class="main-content">
        <h2>Tasks - ${batch.batchName}</h2>
        <p style="color:var(--text-muted); margin-bottom:20px;">${batch.courseName}</p>

        <c:if test="${empty tasks}">
            <p style="color:var(--text-muted);">No tasks assigned in this batch yet.</p>
        </c:if>

        <c:if test="${not empty tasks}">
        <table>
            <tr><th>Title</th><th>Due Date</th><th>Action</th></tr>
            <c:forEach var="t" items="${tasks}">
                <tr>
                    <td>${t.title}</td>
                    <td>${t.dueDate}</td>
                    <td><a href="${pageContext.request.contextPath}/student/tasks/${t.id}/submit" class="btn-secondary">Submit</a></td>
                </tr>
            </c:forEach>
        </table>
        </c:if>

        <a href="${pageContext.request.contextPath}/student/dashboard" class="btn-secondary" style="display:inline-block; margin-top:16px;">Back to Dashboard</a>
    </div>
</div>
</body>
</html>
