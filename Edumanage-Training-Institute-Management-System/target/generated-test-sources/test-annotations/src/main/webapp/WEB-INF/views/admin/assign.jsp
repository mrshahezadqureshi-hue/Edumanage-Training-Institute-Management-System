<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Assign - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />
    <div class="main-content">
        <h2>Assign for: ${batch.batchName}</h2>

        <div class="card" style="max-width:500px; margin-bottom:24px;">
            <h3>Assign Trainer</h3>
            <form action="${pageContext.request.contextPath}/admin/batches/${batch.id}/assign-trainer" method="post">
                <div class="form-group">
                    <select name="trainerId" required>
                        <option value="">-- Select Trainer --</option>
                        <c:forEach var="t" items="${trainers}">
                            <option value="${t.id}">${t.fullName}</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn-primary">Assign Trainer</button>
            </form>
        </div>

        <div class="card" style="max-width:500px;">
            <h3>Assign Students</h3>
            <form action="${pageContext.request.contextPath}/admin/batches/${batch.id}/assign-students" method="post">
                <div class="form-group">
                    <c:forEach var="s" items="${students}">
                        <label style="font-weight:normal;">
                            <input type="checkbox" name="studentIds" value="${s.id}"> ${s.fullName} (${s.username})
                        </label><br>
                    </c:forEach>
                </div>
                <button type="submit" class="btn-primary">Assign Students</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
