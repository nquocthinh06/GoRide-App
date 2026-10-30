# Contributing to GoRide

## 1. Quy tắc làm việc

1. Mọi công việc phải có GitHub Issue và mã `GOR-xxx`.
2. Trước khi code, chuyển Issue sang `In Progress` và tạo branch từ `develop`.
3. Một PR nên giải quyết một Issue chính; tránh gom nhiều tính năng không liên quan.
4. Không tự ý thay đổi model/API contract đã thống nhất. Nếu cần, cập nhật `docs/` và thông báo người còn lại trước.
5. Không merge PR của chính mình nếu thay đổi ảnh hưởng luồng nghiệp vụ hoặc dữ liệu; yêu cầu thành viên còn lại review.

## 2. Branch naming

```text
feature/GOR-012-trip-repository
fix/GOR-018-prevent-double-booking
docs/update-api-contract
```

## 3. Commit message

Dùng Conventional Commits:

- `feat:` tính năng mới
- `fix:` sửa lỗi
- `refactor:` tái cấu trúc không đổi hành vi
- `test:` bổ sung/sửa kiểm thử
- `docs:` tài liệu
- `chore:` cấu hình/công cụ

## 4. Pull Request

- PR target mặc định: `develop`.
- Liên kết Issue bằng `Closes #<issue-number>`.
- Mô tả thay đổi, cách kiểm thử, ảnh/video nếu thay đổi UI.
- Nêu thay đổi Firestore schema, Rules, index, Cloud Functions hoặc API contract.
- Không merge khi CI thất bại hoặc còn review comment chưa xử lý.

## 5. Review checklist

- [ ] Đúng phạm vi Issue và Acceptance Criteria.
- [ ] Không có secret/API key/credential.
- [ ] Xử lý loading, empty, error và retry.
- [ ] Kiểm tra quyền truy cập và dữ liệu đầu vào.
- [ ] Có test cho trường hợp bình thường và trường hợp biên.
- [ ] Không phá vỡ model/API contract.
- [ ] Tài liệu được cập nhật nếu cần.

## 6. Phối hợp giữa hai thành viên

- Member 1 phụ trách UI/UX, điều hướng, màn hình bản đồ và trình bày trạng thái.
- Member 2 phụ trách Firebase, repository, nghiệp vụ, thuật toán và kiểm thử logic.
- Trước mỗi milestone, hai thành viên thống nhất model, tên field, trạng thái và chữ ký hàm.
- Tích hợp theo contract; không chờ đến cuối tuần mới ghép code.
- Họp ngắn tối thiểu 2 lần/tuần: đầu tuần chốt việc, cuối tuần demo và cập nhật Board.

## 7. Quy tắc dữ liệu

- Firestore lưu dữ liệu hồ sơ, yêu cầu, chuyến, lịch tiện chuyến, đề xuất ghép và lịch sử.
- Realtime Database lưu vị trí tài xế/chuyến đang hoạt động.
- Các thao tác cạnh tranh như nhận cùng một chuyến hoặc đặt ghế cuối phải dùng transaction/Cloud Function có kiểm tra lại điều kiện tại thời điểm ghi.
- Không tin dữ liệu giá, số ghế hoặc trạng thái gửi từ client nếu chưa xác thực ở backend.
