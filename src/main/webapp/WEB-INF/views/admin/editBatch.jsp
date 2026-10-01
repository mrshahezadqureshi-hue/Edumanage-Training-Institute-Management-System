<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Batch - EduManage</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="dashboard-layout">
    <jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp"/>

    <main class="main-content">
        <div class="header-bar" style="margin-bottom:24px;">
            <div>
                <h2><i class="fas fa-layer-group" style="color:var(--primary);"></i> Edit Batch</h2>
                <span style="color:var(--text-muted);font-size:13.5px;">Update batch details, schedule and assigned trainer.</span>
            </div>
            <a href="${pageContext.request.contextPath}/admin/batches" style="text-decoration:none;">
                <button type="button" class="mini-btn" style="padding:10px 18px;font-size:13.5px;">
                    <i class="fas fa-arrow-left"></i> Back to Batches
                </button>
            </a>
        </div>

        <div style="display:flex;justify-content:center;align-items:flex-start;padding-top:8px;">
            <div class="dashboard-card" style="width:100%;max-width:620px;padding:32px;border-radius:20px;box-shadow:var(--shadow-lg);">
                <div style="margin-bottom:24px;border-bottom:1px solid var(--border);padding-bottom:14px;display:flex;align-items:center;justify-content:space-between;gap:16px;">
                    <div>
                        <h5 style="margin:0 0 4px;font-size:18px;color:var(--text);font-weight:700;">
                            <i class="fas fa-calendar-edit" style="color:var(--primary);margin-right:6px;"></i> Batch Details
                        </h5>
                        <small style="color:var(--text-muted);font-size:13px;">Editing: <strong>${batch.batchName}</strong></small>
                    </div>
                    <span class="badge ${batch.active ? 'badge-approved' : 'badge-pending'}" style="font-size:12px;">
                        ${batch.active ? 'Active Batch' : 'Inactive Batch'}
                    </span>
                </div>

                <form action="${pageContext.request.contextPath}/admin/batches/${batch.id}/update" method="post">
                    <div class="form-group" style="margin-bottom:18px;">
                        <label style="display:block;font-weight:600;font-size:13.5px;color:var(--text);margin-bottom:7px;">
                            <i class="fas fa-tag" style="color:var(--primary);width:18px;"></i> Batch Name <span style="color:#ef4444;">*</span>
                        </label>
                        <input type="text" name="batchName" value="${batch.batchName}" required style="width:100%;box-sizing:border-box;">
                    </div>

                    <div class="form-group" style="margin-bottom:18px;">
                        <label style="display:block;font-weight:600;font-size:13.5px;color:var(--text);margin-bottom:7px;">
                            <i class="fas fa-book" style="color:var(--primary);width:18px;"></i> Course Name <span style="color:#ef4444;">*</span>
                        </label>
                        <input type="text" name="courseName" value="${batch.courseName}" required style="width:100%;box-sizing:border-box;">
                    </div>

                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-bottom:18px;">
                        <div>
                            <label style="display:block;font-weight:600;font-size:13.5px;color:var(--text);margin-bottom:7px;">
                                <i class="fas fa-calendar-alt" style="color:var(--primary);width:18px;"></i> Start Date
                            </label>
                            <input type="date" name="startDate" value="${batch.startDate}" style="width:100%;box-sizing:border-box;">
                        </div>
                        <div>
                            <label style="display:block;font-weight:600;font-size:13.5px;color:var(--text);margin-bottom:7px;">
                                <i class="fas fa-calendar-check" style="color:var(--primary);width:18px;"></i> End Date
                            </label>
                            <input type="date" name="endDate" value="${batch.endDate}" style="width:100%;box-sizing:border-box;">
                        </div>
                    </div>

                    <div class="form-group" style="margin-bottom:26px;">
                        <label style="display:block;font-weight:600;font-size:13.5px;color:var(--text);margin-bottom:7px;">
                            <i class="fas fa-chalkboard-teacher" style="color:var(--primary);width:18px;"></i> Assign Trainer
                        </label>
                        <select name="trainerId" style="width:100%;box-sizing:border-box;padding:10.5px 12px;border-radius:10px;border:1px solid var(--border);background:var(--surface);color:var(--text);font-size:13.5px;">
                            <option value="">-- Not Assigned --</option>
                            <c:forEach var="t" items="${trainers}">
                                <option value="${t.id}" ${batch.trainer != null && batch.trainer.id == t.id ? 'selected' : ''}>${t.fullName} (@${t.username})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div style="display:flex;gap:14px;align-items:center;">
                        <button type="submit" class="btn-primary" style="flex:1;padding:12px;font-size:14.5px;font-weight:700;border-radius:10px;display:flex;align-items:center;justify-content:center;gap:8px;">
                            <i class="fas fa-save"></i> Update Batch
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/batches" class="btn-secondary" style="padding:12px 20px;font-size:14px;font-weight:600;border-radius:10px;text-decoration:none;display:inline-flex;align-items:center;justify-content:center;">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>

<jsp:include page="/WEB-INF/views/common/admin-footer.jsp"/>
</body>
</html>
