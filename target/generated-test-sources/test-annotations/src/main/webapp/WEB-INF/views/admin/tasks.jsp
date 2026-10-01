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
    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />
    <div class="main-content">
        <h2>Tasks Overview</h2>
        <p style="color:#777; margin-bottom:16px;">Tasks assigned by trainers, grouped by batch.</p>
        <table>
            <tr><th>Batch</th><th>Course</th><th>Trainer</th></tr>
            <c:forEach var="b" items="${batches}">
                <tr>
                    <td>${b.batchName}</td>
                    <td>${b.courseName}</td>
                    <td>${b.trainer != null ? b.trainer.fullName : 'Not Assigned'}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
