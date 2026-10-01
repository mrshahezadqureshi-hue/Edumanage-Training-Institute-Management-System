<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/student-sidebar.jsp" />
    <div class="main-content">
        <h2>Welcome, ${student.fullName}</h2>
        <p style="color:var(--text-muted); margin-bottom:20px;">Here's what's happening in your courses.</p>

        <div class="stat-grid">
            <div class="stat-card"><div class="num">${batchCount}</div><div class="label">My Batches</div></div>
            <div class="stat-card"><div class="num">${taskCount}</div><div class="label">Total Tasks</div></div>
            <div class="stat-card"><div class="num">${pendingTaskCount}</div><div class="label">Pending Tasks</div></div>
            <div class="stat-card"><div class="num">${attendancePresent}/${attendanceTotal}</div><div class="label">Attendance</div></div>
        </div>

        <c:if test="${empty batches}">
            <p style="color:var(--text-muted);">You haven't been assigned to a batch yet. Please contact admin.</p>
        </c:if>

        <c:if test="${not empty batches}">
        <h3 style="margin-bottom:12px;">My Batches</h3>
        <table>
            <tr><th>Batch</th><th>Course</th><th>Trainer</th><th>Actions</th></tr>
            <c:forEach var="b" items="${batches}">
                <tr>
                    <td>${b.batchName}</td>
                    <td>${b.courseName}</td>
                    <td>${b.trainer != null ? b.trainer.fullName : 'Not Assigned'}</td>
                    <td><a href="${pageContext.request.contextPath}/student/batch/${b.id}/tasks" class="btn-secondary">View Tasks</a></td>
                </tr>
            </c:forEach>
        </table>
        </c:if>
    </div>
</div>
</body>
</html>
