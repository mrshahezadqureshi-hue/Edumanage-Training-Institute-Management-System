<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trainer Dashboard - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/trainer-sidebar.jsp" />
    <div class="main-content">
        <h2>Welcome, ${trainer.fullName}</h2>
        <p style="color:var(--text-muted); margin-bottom:20px;">Here's everything happening across your batches.</p>

        <div class="stat-grid">
            <div class="stat-card"><div class="num">${batchCount}</div><div class="label">My Batches</div></div>
            <div class="stat-card"><div class="num">${studentCount}</div><div class="label">My Students</div></div>
            <div class="stat-card"><div class="num">${taskCount}</div><div class="label">Tasks Assigned</div></div>
            <div class="stat-card"><div class="num">${pendingReviewCount}</div><div class="label">Pending Reviews</div></div>
        </div>

        <h3 style="margin-bottom:12px;">My Assigned Batches</h3>
        <c:if test="${empty batches}">
            <p style="color:var(--text-muted);">No batches assigned yet. Please check back once admin assigns you a batch.</p>
        </c:if>

        <c:if test="${not empty batches}">
        <table>
            <tr><th>Batch</th><th>Course</th><th>Students</th><th>Actions</th></tr>
            <c:forEach var="b" items="${batches}">
                <tr>
                    <td>${b.batchName}</td>
                    <td>${b.courseName}</td>
                    <td>${fn:length(b.students)}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/trainer/batch/${b.id}/students" class="btn-secondary">View Students</a>
                        <a href="${pageContext.request.contextPath}/trainer/batch/${b.id}/attendance" class="btn-secondary">Mark Attendance</a>
                        <a href="${pageContext.request.contextPath}/trainer/batch/${b.id}/tasks/new" class="btn-secondary">Assign Task</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
        </c:if>
    </div>
</div>
</body>
</html>
