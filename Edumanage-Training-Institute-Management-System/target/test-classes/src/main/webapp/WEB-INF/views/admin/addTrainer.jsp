<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <!-- ========================= -->
        <!-- CREATE TRAINER -->
        <!-- ========================= -->

        <div class="card" style="max-width:600px;margin-bottom:25px;">

            <h3>Create Trainer</h3>

            <form action="${pageContext.request.contextPath}/admin/trainers"
                  method="post">

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text"
                           name="fullName"
                           required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email"
                           name="email">
                </div>

                <div class="form-group">
                    <label>Phone</label>
                    <input type="text"
                           name="phone">
                </div>

                <div class="form-group">
                    <label>Username</label>
                    <input type="text"
                           name="username"
                           required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password"
                           name="password"
                           required>
                </div>

                <button type="submit"
                        class="btn-primary">
                    Create Trainer
                </button>

            </form>

        </div>

    </div>
</body>
</html>