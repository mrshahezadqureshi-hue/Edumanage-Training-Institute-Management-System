<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Submitted - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="common/navbar.jsp" />

<div class="form-container" style="text-align:center;">
    <h2>Registration Received!</h2>
    <div class="alert-success">
        Thank you, ${registration.fullName}. Your registration for
        <strong>${registration.courseApplied}</strong> has been saved.
    </div>
    <p>Status: <span class="badge badge-pending">PENDING</span></p>
    <p style="margin-top: 16px; color:#777; font-size: 14px;">
        Our admin team will review your registration. Once approved,
        your student login credentials will be shared via email/phone.
    </p>
    <a href="${pageContext.request.contextPath}/home" class="btn-secondary" style="display:inline-block; margin-top:16px;">Back to Home</a>
</div>

<div class="footer">&copy; 2026 EduManage. All rights reserved.</div>
</body>
</html>
