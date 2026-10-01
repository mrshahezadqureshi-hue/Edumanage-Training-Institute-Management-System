<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registrations - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />
    <div class="main-content">
        <h2>Student Registrations</h2>

        <c:if test="${not empty approvedMessage}">
            <div class="alert-success">${approvedMessage}</div>
        </c:if>

        <table>
            <tr><th>Name</th><th>Email</th><th>Phone</th><th>Course</th><th>Status</th><th>Action</th></tr>
            <c:forEach var="reg" items="${registrations}">
                <tr>
                    <td>${reg.fullName}</td>
                    <td>${reg.email}</td>
                    <td>${reg.phone}</td>
                    <td>${reg.courseApplied}</td>
                    <td>
                        <c:choose>
                            <c:when test="${reg.status == 'PENDING'}"><span class="badge badge-pending">PENDING</span></c:when>
                            <c:when test="${reg.status == 'APPROVED'}"><span class="badge badge-approved">APPROVED</span></c:when>
                            <c:otherwise><span class="badge badge-rejected">REJECTED</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${reg.status == 'PENDING'}">
                            <form action="${pageContext.request.contextPath}/admin/registrations/${reg.id}/approve" method="post" style="display:inline;">
                                <button class="btn-primary" style="width:auto; padding:6px 12px;" type="submit">Approve</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/admin/registrations/${reg.id}/reject" method="post" style="display:inline;">
                                <button class="btn-secondary" type="submit">Reject</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
