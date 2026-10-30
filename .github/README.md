# GitHub project configuration

## Bootstrap (Windows PowerShell)

```powershell
gh auth login
.\.github\github-bootstrap.ps1
```

Script tạo/cập nhật labels, tạo milestones nếu chưa có và tạo Issues từ backlog. Script kiểm tra mã `GOR-xxx` trước khi tạo để hạn chế Issue trùng.

Điều kiện: repository `nquocthinh06/GoRide-App` đã được tạo, GitHub CLI đã đăng nhập và tài khoản có quyền quản trị.

Member 2 chưa cung cấp GitHub username nên Issue gợi ý Member 2 chưa được tự động assign. Các Issue `Both` cần thống nhất người phụ trách chính.

## GitHub Project

Tạo Project dạng Board, liên kết repository và thêm field:
- Status: Backlog, Ready, In Progress, In Review, Done, Blocked
- Priority: P0, P1, P2
- Sprint/Milestone, Assignee, Estimate, Start date, Due date

Views: Board, Roadmap, By Member, By Milestone.
