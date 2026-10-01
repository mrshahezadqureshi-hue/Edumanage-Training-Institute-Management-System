<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/trainer-sidebar.jsp" />
    <div class="main-content">
        <h2>Mark Attendance - ${batch.batchName}</h2>

        <c:if test="${empty batch.students}">
            <p style="color:var(--text-muted);">No students in this batch yet.</p>
        </c:if>

        <c:if test="${not empty batch.students}">
        <form action="${pageContext.request.contextPath}/trainer/batch/${batch.id}/attendance" method="post">
            <div class="card" style="max-width:700px;">
                <div class="form-group">
                    <label>Date</label>
                    <input type="date" name="date" value="${today}" required>
                </div>

                <table>
                    <tr><th>Student</th><th>Status</th></tr>
                    <c:forEach var="s" items="${batch.students}">
                        <tr>
                            <td>${s.fullName}</td>
                            <td>
                                <select name="status_${s.id}">
                                    <option value="PRESENT">Present</option>
                                    <option value="ABSENT">Absent</option>
                                    <option value="LATE">Late</option>
                                </select>
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <button type="submit" class="btn-primary" style="margin-top:16px;">Save Attendance</button>
            </div>
        </form>
        </c:if>

        <a href="${pageContext.request.contextPath}/trainer/dashboard" class="btn-secondary" style="display:inline-block; margin-top:16px;">Back to Dashboard</a>
    </div>
</div>
</body>
</html>
