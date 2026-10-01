<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Batches - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />
    <div class="main-content">
        <h2>Batches</h2>

        <div class="card" style="max-width:500px; margin-bottom:24px;">
            <h3>Create Batch</h3>
            <form action="${pageContext.request.contextPath}/admin/batches" method="post">
                <div class="form-group"><label>Batch Name</label><input type="text" name="batchName" placeholder="Java Full Stack - Morning" required></div>
                <div class="form-group"><label>Course Name</label><input type="text" name="courseName" required></div>
                <div class="form-group"><label>Start Date</label><input type="date" name="startDate"></div>
                <div class="form-group"><label>End Date</label><input type="date" name="endDate"></div>
                <div class="form-group">
                    <label>Trainer</label>
                    <select name="trainerId">
                        <option value="">-- Not Assigned --</option>
                        <c:forEach var="t" items="${trainers}">
                            <option value="${t.id}">${t.fullName} (${t.username})</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn-primary">Create Batch</button>
            </form>
        </div>

        <table>
            <tr><th>Batch</th><th>Course</th><th>Trainer Username</th><th>Trainer Name</th><th>Students</th><th>Action</th></tr>
            <c:forEach var="b" items="${batches}">
                <tr>
                    <td>${b.batchName}</td>
                    <td>${b.courseName}</td>
                    <td>${b.trainer != null ? b.trainer.username : '-'}</td>
                    <td>${b.trainer != null ? b.trainer.fullName : 'Not Assigned'}</td>
                    <td>${fn:length(b.students)}</td>
                    <td><a href="${pageContext.request.contextPath}/admin/batches/${b.id}/assign" class="btn-secondary">Assign</a></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
