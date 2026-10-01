<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inquiries - EduManage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />
    <div class="main-content">
        <h2>Inquiries</h2>
        <table>
            <tr><th>Name</th><th>Phone</th><th>Email</th><th>Course</th><th>Status</th><th>Action</th></tr>
            <c:forEach var="inq" items="${inquiries}">
                <tr>
                    <td>${inq.name}</td>
                    <td>${inq.phone}</td>
                    <td>${inq.email}</td>
                    <td>${inq.courseInterested}</td>
                    <td>${inq.status}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/admin/inquiries/${inq.id}/status" method="post" style="display:flex; gap:6px;">
                            <select name="status">
                                <option value="NEW">New</option>
                                <option value="FOLLOWED_UP">Followed Up</option>
                                <option value="CONVERTED">Converted</option>
                                <option value="CLOSED">Closed</option>
                            </select>
                            <button class="btn-secondary" type="submit">Update</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
