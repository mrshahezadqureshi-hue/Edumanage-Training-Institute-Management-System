<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reports - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />
    <div class="main-content">
        <h2>Reports</h2>

        <div class="stat-grid">
            <div class="stat-card"><div class="num">${fn:length(batches)}</div><div class="label">Total Batches</div></div>
            <div class="stat-card"><div class="num">${fn:length(students)}</div><div class="label">Total Students</div></div>
            <div class="stat-card"><div class="num">${fn:length(trainers)}</div><div class="label">Total Trainers</div></div>
        </div>

        <h3 style="margin-bottom:12px;">Batch-wise Summary</h3>
        <table>
            <tr><th>Batch</th><th>Course</th><th>Trainer</th><th>Students Enrolled</th></tr>
            <c:forEach var="b" items="${batches}">
                <tr>
                    <td>${b.batchName}</td>
                    <td>${b.courseName}</td>
                    <td>${b.trainer != null ? b.trainer.fullName : 'Not Assigned'}</td>
                    <td>${fn:length(b.students)}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
