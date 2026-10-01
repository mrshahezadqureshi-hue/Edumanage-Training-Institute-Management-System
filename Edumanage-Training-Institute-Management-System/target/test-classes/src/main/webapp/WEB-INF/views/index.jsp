<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>EduManage - Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<jsp:include page="common/navbar.jsp" />

<div class="hero">
    <span class="eyebrow">TRAINING INSTITUTE MANAGEMENT, SIMPLIFIED</span>
    <h1>Learn Skills That Get You Hired</h1>
    <p>EduManage helps you register, track attendance, submit tasks, and get trainer feedback — all in one place.</p>
    <a class="btn" href="${pageContext.request.contextPath}/register">Register Now</a>

    <div class="hero-stats">
        <div><div class="num">4+</div><div class="label">Courses Offered</div></div>
        <div><div class="num">100%</div><div class="label">Trainer-Led Batches</div></div>
        <div><div class="num">24/7</div><div class="label">Progress Tracking</div></div>
    </div>
</div>

<div class="section">
    <h2>Why EduManage?</h2>
    <p class="subtitle">Everything you need to learn, teach, and manage — from one dashboard.</p>
    <div class="card-grid">
        <div class="card"><div class="icon-badge">📚</div><h3>Structured Batches</h3><p>Learn in small, trainer-led batches with a clear schedule.</p></div>
        <div class="card"><div class="icon-badge">✅</div><h3>Real Feedback</h3><p>Get marks and feedback on every task you submit.</p></div>
        <div class="card"><div class="icon-badge">📊</div><h3>Track Progress</h3><p>See your attendance and performance any time.</p></div>
    </div>
</div>

<div class="section">
    <h2>How It Works</h2>
    <p class="subtitle">From inquiry to certification, every step is tracked.</p>
    <div class="card-grid">
        <div class="card"><div class="icon-badge">1</div><h3>Register</h3><p>Submit your details and course of interest online.</p></div>
        <div class="card"><div class="icon-badge">2</div><h3>Get Approved</h3><p>Admin reviews your application and shares login access.</p></div>
        <div class="card"><div class="icon-badge">3</div><h3>Join a Batch</h3><p>Get assigned to a trainer-led batch matching your course.</p></div>
        <div class="card"><div class="icon-badge">4</div><h3>Learn & Grow</h3><p>Attend sessions, submit tasks, and track your feedback.</p></div>
    </div>
</div>

<div class="footer">&copy; 2026 EduManage. All rights reserved.</div>

<!-- ============ Inquiry Popup (appears 5 seconds after page load) ============ -->
<div class="popup-overlay" id="inquiryOverlay">
    <div class="popup-box">
        <span class="popup-close" onclick="closePopup()">&times;</span>
        <h3>Quick Inquiry</h3>
        <div id="popupMessage"></div>
        <form id="inquiryForm">
            <div class="form-group">
                <label>Name</label>
                <input type="text" name="name" required>
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="text" name="phone" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email">
            </div>
            <div class="form-group">
                <label>Course Interested</label>
                <input type="text" name="courseInterested" placeholder="e.g. Java Full Stack">
            </div>
            <button type="submit" class="btn-primary">Submit Inquiry</button>
        </form>
    </div>
</div>

<script>
    // Show popup 5 seconds after landing on the page
    setTimeout(function () {
        document.getElementById('inquiryOverlay').style.display = 'block';
    }, 5000);

    function closePopup() {
        document.getElementById('inquiryOverlay').style.display = 'none';
    }

    document.getElementById('inquiryForm').addEventListener('submit', function (e) {
        e.preventDefault();
        var formData = new FormData(this);
        var params = new URLSearchParams();
        formData.forEach(function (value, key) { params.append(key, value); });

        fetch('${pageContext.request.contextPath}/inquiry/submit', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params.toString()
        }).then(function (res) { return res.text(); })
          .then(function () {
              document.getElementById('popupMessage').innerHTML =
                  '<div class="alert-success">Thank you! Our team will contact you soon.</div>';
              setTimeout(closePopup, 1800);
          });
    });
</script>

</body>
</html>
