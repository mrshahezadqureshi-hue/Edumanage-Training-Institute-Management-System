<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

    <title>Edit Student - EduManage</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<div class="dashboard-layout">

    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp"/>

    <div class="main-content">

        <h2>Edit Student</h2>

        <div class="card" style="max-width:600px;">

            <form action="${pageContext.request.contextPath}/admin/students/${student.id}/update"
      method="post">
            

                <!-- Hidden ID -->
                <input type="hidden"
                       name="id"
                       value="${student.id}">

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text"
                           name="fullName"
                           value="${student.fullName}"
                           required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email"
                           name="email"
                           value="${student.email}">
                </div>

                <div class="form-group">
                    <label>Phone</label>
                    <input type="text"
                           name="phone"
                           value="${student.phone}">
                </div>

                <div class="form-group">
                    <label>Username</label>
                    <input type="text"
                           name="username"
                           value="${student.username}"
                           required>
                </div>

                <div class="form-group">
                    <label>New Password</label>
                    <input type="password"
                           name="password"
                           placeholder="Leave blank to keep current password">
                </div>

                <div class="form-group">
                    <label>Status</label>

                    <select name="active">

                        <option value="true"
                            ${student.active ? "selected" : ""}>
                            Active
                        </option>

                        <option value="false"
                            ${!student.active ? "selected" : ""}>
                            Inactive
                        </option>

                    </select>

                </div>

                <br>

                <button type="submit"
                        class="btn-primary">
                    Update Student
                </button>

                <a href="${pageContext.request.contextPath}/admin/students"
                   class="btn-secondary"
                   style="padding:10px 15px;text-decoration:none;">
                    Cancel
                </a>

            </form>

        </div>

    </div>

</div>

</body>
</html>
