<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />
    <div class="main-content">
        <h2>Welcome, Admin</h2>
        <div class="stat-grid">
            <div class="stat-card"><div class="num">${inquiryCount}</div><div class="label">Inquiries</div></div>
            <div class="stat-card"><div class="num">${pendingCount}</div><div class="label">Pending Registrations</div></div>
            <div class="stat-card"><div class="num">${trainerCount}</div><div class="label">Trainers</div></div>
            <div class="stat-card"><div class="num">${studentCount}</div><div class="label">Students</div></div>
            <div class="stat-card"><div class="num">${batchCount}</div><div class="label">Batches</div></div>
        </div>
        <p style="color:#777;">Use the sidebar to manage inquiries, approve registrations, create trainers/batches, and view reports.</p>
    </div>
</div>
</body>
</html>
