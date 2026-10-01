<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Trainer Management - EduManage</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

<div class="dashboard-layout">

    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp"/>

    <div class="main-content">
    <div class="header-bar">
    <h2>Trainer Management</h2>
    <button>  <a href="AddTrainer" > ADD TRAINER</button></a>
</div>
    
        <!-- ========================= -->
        <!-- TRAINER LIST -->
        <!-- ========================= -->

        <table>

            <tr>

                <th>ID</th>
                <th>Full Name</th>
                <th>Username</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Status</th>
                <th>Action</th>

            </tr>

            <c:forEach var="t" items="${trainers}">

                <tr>

                    <td>${t.id}</td>

                    <td>${t.fullName}</td>

                    <td>${t.username}</td>

                    <td>${t.email}</td>

                    <td>${t.phone}</td>

                    <td>

                        <c:choose>

                            <c:when test="${t.active}">
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

                        <a href="${pageContext.request.contextPath}/admin/trainers/edit/${t.id}"
                           class="btn-primary"
                           style="padding:6px 10px;text-decoration:none;">
                            Edit
                        </a>

                        &nbsp;

                        <a href="${pageContext.request.contextPath}/admin/trainers/delete/${t.id}"
                           class="btn-secondary"
                           style="padding:6px 10px;text-decoration:none;"
                           onclick="return confirm('Are you sure you want to Delete this trainer ?');">
                            Delete
                        </a>

                    </td>

                </tr>

            </c:forEach>

        </table>


</body>
</html>