<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Trainer - EduManage</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

<div class="dashboard-layout">

    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp"/>

    <div class="main-content">

        <h2>Edit Trainer</h2>

        <div class="card" style="max-width:600px;">

            <form action="${pageContext.request.contextPath}/admin/trainers/${trainer.id}/update"
      method="post">

                <!-- Hidden ID -->
                <input type="hidden"
                       name="id"
                       value="${trainer.id}">

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text"
                           name="fullName"
                           value="${trainer.fullName}"
                           required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email"
                           name="email"
                           value="${trainer.email}">
                </div>

                <div class="form-group">
                    <label>Phone</label>
                    <input type="text"
                           name="phone"
                           value="${trainer.phone}">
                </div>

                <div class="form-group">
                    <label>Username</label>
                    <input type="text"
                           name="username"
                           value="${trainer.username}"
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
                            ${trainer.active ? "selected" : ""}>
                            Active
                        </option>

                        <option value="false"
                            ${!trainer.active ? "selected" : ""}>
                            Inactive
                        </option>

                    </select>

                </div>

                <br>

                <button type="submit" class="btn-primary">
                    Update Trainer
                </button>

                <a href="${pageContext.request.contextPath}/admin/trainers"
                   class="btn-secondary"
                   style="text-decoration:none;padding:10px 15px;">
                    Cancel
                </a>

            </form>

        </div>

    </div>

</div>

</body>
</html>