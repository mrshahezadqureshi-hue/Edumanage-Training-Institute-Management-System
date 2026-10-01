<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="common/navbar.jsp" />

<div class="form-container">
    <h2>Student Registration</h2>
    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="fullName" required>
        </div>
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" required>
        </div>
        <div class="form-group">
            <label>Phone</label>
            <input type="text" name="phone" required>
        </div>
        <div class="form-group">
            <label>Address</label>
            <textarea name="address" rows="2"></textarea>
        </div>
        <div class="form-group">
            <label>Course Applied For</label>
            <input type="text" name="courseApplied" placeholder="e.g. Java Full Stack" required>
        </div>
        <div class="form-group">
            <label>Highest Qualification</label>
            <input type="text" name="qualification">
        </div>
        <button type="submit" class="btn-primary">Submit Registration</button>
    </form>
</div>

<div class="footer">&copy; 2026 EduManage. All rights reserved.</div>
</body>
</html>
