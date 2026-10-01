<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submissions - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/trainer-sidebar.jsp" />
    <div class="main-content">
        <h2>Submissions - ${task.title}</h2>
        <p style="color:var(--text-muted); margin-bottom:20px;">Batch: ${task.batch.batchName}</p>

        <c:if test="${empty submissions}">
            <p style="color:var(--text-muted);">No submissions yet for this task.</p>
        </c:if>

        <c:forEach var="s" items="${submissions}">
            <div class="card" style="max-width:600px; margin-bottom:16px;">
                <h3>${s.student.fullName}</h3>
                <p style="color:var(--text-muted); margin-bottom:8px;">Submitted: ${s.submittedAt}</p>
                <c:if test="${not empty s.fileName}">
                    <p>File: ${s.fileName}</p>
                </c:if>
                <c:if test="${not empty s.submissionNote}">
                    <p>Note: ${s.submissionNote}</p>
                </c:if>
                <p>Status: <span class="badge ${s.status == 'REVIEWED' ? 'badge-approved' : 'badge-pending'}">${s.status}</span></p>

                <c:if test="${s.status == 'REVIEWED'}">
                    <p style="margin-top:8px;"><strong>Marks:</strong> ${s.marks}/100</p>
                    <p><strong>Feedback:</strong> ${s.feedback}</p>
                </c:if>

                <c:if test="${s.status != 'REVIEWED'}">
                    <form action="${pageContext.request.contextPath}/trainer/submissions/${s.id}/feedback" method="post" style="margin-top:12px;">
                        <div class="form-group">
                            <label>Marks (out of 100)</label>
                            <input type="number" name="marks" min="0" max="100" required>
                        </div>
                        <div class="form-group">
                            <label>Feedback</label>
                            <textarea name="feedback" rows="3"></textarea>
                        </div>
                        <button type="submit" class="btn-primary">Submit Feedback</button>
                    </form>
                </c:if>
            </div>
        </c:forEach>

        <a href="${pageContext.request.contextPath}/trainer/tasks" class="btn-secondary">Back to Tasks</a>
    </div>
</div>
</body>
</html>
