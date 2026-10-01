<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/student-sidebar.jsp" />
    <div class="main-content">
        <h2>My Profile</h2>
        <div class="card" style="max-width:400px;">
            <p><strong>Name:</strong> ${student.fullName}</p>
            <p><strong>Username:</strong> ${student.username}</p>
            <p><strong>Email:</strong> ${student.email}</p>
            <p><strong>Phone:</strong> ${student.phone}</p>
        </div>
    </div>
</div>
</body>
</html>
