<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Assignment - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/student-sidebar.jsp" />
    <div class="main-content">
        <h2>Submit Assignment</h2>
        <div class="card" style="max-width:500px; margin-bottom:20px;">
            <h3>${task.title}</h3>
            <p style="color:var(--text-muted); margin:8px 0;">${task.description}</p>
            <p><strong>Due:</strong> ${task.dueDate}</p>
        </div>

        <form action="${pageContext.request.contextPath}/student/tasks/${task.id}/submit" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Upload File</label>
                <input type="file" name="file" required>
            </div>
            <div class="form-group">
                <label>Note (optional)</label>
                <textarea name="note" rows="3"></textarea>
            </div>
            <button type="submit" class="btn-primary">Submit</button>
        </form>
    </div>
</div>
</body>
</html>
