# GitHub project configuration

## Bootstrap (Windows PowerShell)

```powershell
gh auth login
.\.github\github-bootstrap.ps1
```

Script tạo/cập nhật labels, tạo milestones nếu chưa có và tạo Issues từ backlog. Script kiểm tra mã `GOR-xxx` trước khi tạo để hạn chế Issue trùng.

Điều kiện: repository `nquocthinh06/GoRide-App` đã được tạo, GitHub CLI đã đăng nhập và tài khoản có quyền quản trị.

Issue của Member 2 được gán cho `nguyentruc241006`. Issue `Both` được gán cho cả `nquocthinh06` và `nguyentruc241006`.

## GitHub Project

Tạo Project dạng Board, liên kết repository và thêm field:
- Status: Backlog, Ready, In Progress, In Review, Done, Blocked
- Priority: P0, P1, P2
- Sprint/Milestone, Assignee, Estimate, Start date, Due date

Views: Board, Roadmap, By Member, By Milestone.
