<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Assign Task - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/trainer-sidebar.jsp" />
    <div class="main-content">
        <h2>Assign Task - ${batch.batchName}</h2>
        <div class="card" style="max-width:500px;">
            <form action="${pageContext.request.contextPath}/trainer/batch/${batch.id}/tasks" method="post">
                <div class="form-group">
                    <label>Title</label>
                    <input type="text" name="title" required>
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="4"></textarea>
                </div>
                <div class="form-group">
                    <label>Due Date</label>
                    <input type="date" name="dueDate">
                </div>
                <button type="submit" class="btn-primary">Assign Task</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
