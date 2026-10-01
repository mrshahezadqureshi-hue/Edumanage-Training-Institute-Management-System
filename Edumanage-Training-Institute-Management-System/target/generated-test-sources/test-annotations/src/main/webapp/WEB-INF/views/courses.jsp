<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Courses - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="common/navbar.jsp" />
<div class="section">
    <h2>Our Courses</h2>
    <div class="card-grid">
        <div class="card"><h3>Java Full Stack</h3><p>Core Java, Spring Boot, JSP, MySQL — 3 months.</p></div>
        <div class="card"><h3>Python & Data Science</h3><p>Python, Pandas, ML basics — 2.5 months.</p></div>
        <div class="card"><h3>Frontend Development</h3><p>HTML, CSS, JavaScript, React — 2 months.</p></div>
        <div class="card"><h3>Digital Marketing</h3><p>SEO, Ads, Analytics — 6 weeks.</p></div>
    </div>
</div>
<div class="footer">&copy; 2026 EduManage. All rights reserved.</div>
</body>
</html>