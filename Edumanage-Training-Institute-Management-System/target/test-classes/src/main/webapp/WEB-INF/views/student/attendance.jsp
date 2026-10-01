<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Attendance - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/student-sidebar.jsp" />
    <div class="main-content">
        <h2>My Attendance</h2>
        <table>
            <tr><th>Date</th><th>Batch</th><th>Status</th></tr>
            <c:forEach var="a" items="${attendanceList}">
                <tr>
                    <td>${a.attendanceDate}</td>
                    <td>${a.batch.batchName}</td>
                    <td>${a.status}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
