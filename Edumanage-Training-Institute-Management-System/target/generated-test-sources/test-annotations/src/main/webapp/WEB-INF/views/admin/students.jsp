<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

    <title>Students - EduManage</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<div class="dashboard-layout">

    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp"/>

    <div class="main-content">

        <h2>Student Management</h2>

        <table>

            <tr>

                <th>ID</th>
                <th>Name</th>
                <th>Username</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Status</th>
                <th>Action</th>

            </tr>

            <c:forEach var="s" items="${students}">

                <tr>

                    <td>${s.id}</td>

                    <td>${s.fullName}</td>

                    <td>${s.username}</td>

                    <td>${s.email}</td>

                    <td>${s.phone}</td>

                    <td>

                        <c:choose>

                            <c:when test="${s.active}">
                                <span class="badge badge-approved">
                                    Active
                                </span>
                            </c:when>

                            <c:otherwise>
                                <span class="badge badge-rejected">
                                    Inactive
                                </span>
                            </c:otherwise>

                        </c:choose>

                    </td>
                 <td>
    <div style="display:flex; justify-content:space-between; align-items:center; gap:6px; width:160px;">
        <a href="${pageContext.request.contextPath}/admin/students/edit/${s.id}"
           class="btn-primary"
           style="padding:6px 12px; text-decoration:none;">
            Edit
        </a>

        <a href="${pageContext.request.contextPath}/admin/students/delete/${s.id}"
           class="btn-secondary"
           style="padding:6px 12px; text-decoration:none;"
           onclick="return confirm('Are you sure you want to Delete this student ?')">
            Delete
        </a>
    </div>
</td>
                 

                    
                    
                    


            
                </tr>

            </c:forEach>

        </table>

    </div>

</div>

</body>
</html>
