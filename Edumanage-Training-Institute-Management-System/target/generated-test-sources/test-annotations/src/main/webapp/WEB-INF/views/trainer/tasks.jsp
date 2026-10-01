<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Tasks - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/trainer-sidebar.jsp" />
    <div class="main-content">
        <h2>Tasks I've Assigned</h2>
        <p style="color:var(--text-muted); margin-bottom:20px;">Every task you've created, across all your batches.</p>

        <c:if test="${empty tasks}">
            <p style="color:var(--text-muted);">You haven't assigned any tasks yet. Open a batch to assign one.</p>
        </c:if>

        <c:if test="${not empty tasks}">
        <table>
            <tr><th>Title</th><th>Batch</th><th>Assigned</th><th>Due</th><th>Action</th></tr>
            <c:forEach var="t" items="${tasks}">
                <tr>
                    <td>${t.title}</td>
                    <td>${t.batch.batchName}</td>
                    <td>${t.assignedDate}</td>
                    <td>${t.dueDate}</td>
                    <td><a href="${pageContext.request.contextPath}/trainer/tasks/${t.id}/submissions" class="btn-secondary">View Submissions</a></td>
                </tr>
            </c:forEach>
        </table>
        </c:if>

        <a href="${pageContext.request.contextPath}/trainer/dashboard" class="btn-secondary" style="display:inline-block; margin-top:16px;">Back to Dashboard</a>
    </div>
</div>
</body>
</html>
