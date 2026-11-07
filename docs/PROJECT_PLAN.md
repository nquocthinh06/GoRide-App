# GoRide — Kế hoạch triển khai 8 tuần

**Thời gian đề xuất:** 02/11/2026 – 27/12/2026  
**Nhân lực:** 2 thành viên  
**MVP:** chuyến tiêu chuẩn + tiện chuyến/ghép tối đa hai hành khách.

| Milestone | Thời gian | Mục tiêu | Bàn giao |
|---|---|---|---|
| M1 — Foundation | 02–15/11 | Chốt kiến trúc, Firebase, Auth, model/repository contract, bản đồ nền | App scaffold, Firebase config, auth và data contract |
| M2 — Standard Trip | 16–29/11 | Tạo yêu cầu, tìm tài xế, nhận chuyến, vòng đời chuyến | Luồng đặt xe tiêu chuẩn chạy end-to-end |
| M3 — Carpool Schedule | 30/11–13/12 | Tài xế đăng tuyến, khách tìm chuyến, matching và pricing | Tìm tiện chuyến, kiểm tra ghế, tính giá dự kiến |
| M4 — Shared Trip | 14–20/12 | Đề xuất ghép A/B, tối ưu tuyến, xác nhận nhiều bên | Quy trình xác nhận và atomic commit |
| M5 — Final Delivery | 21–27/12 | Kiểm thử, sửa lỗi, tài liệu, demo | Bản MVP, test report, hướng dẫn chạy và demo |

## Phân công

| Workstream | Member 1 (`nquocthinh06`) | Member 2 (`nguyentruc241006`) |
|---|---|---|
| Flutter UI/navigation | Lead | Hỗ trợ contract |
| Maps/route display/GPS UI | Lead | Hỗ trợ dữ liệu |
| Firebase/Auth/Rules | Hỗ trợ tích hợp | Lead |
| Data models/repositories | UI integration | Lead |
| Trip state/business logic | UI state integration | Lead |
| Matching/pricing/route algorithm | Results UI | Lead |
| Tests | Widget/UI tests | Unit/security/logic tests |
| Docs/demo | Cùng thực hiện | Cùng thực hiện |

## Nhịp làm việc hàng tuần

- Thứ Hai: chọn Issue, xác nhận phụ thuộc và tiêu chí nghiệm thu.
- Giữa tuần: tích hợp theo contract, không đợi đến cuối sprint.
- Cuối tuần: demo, chạy test, cập nhật Board và ghi nhận rủi ro.
- Mỗi Issue phải có người phụ trách, milestone, label, estimate và Acceptance Criteria.

## Nguyên tắc kiểm soát phạm vi

Không mở rộng sang thanh toán thật, nhiều tài xế trên một chuyến, ghép quá hai hành khách hoặc tối ưu tuyến phức tạp ngoài phạm vi MVP. Ưu tiên thuật toán liệt kê các thứ tự điểm dừng hợp lệ vì MVP chỉ có tối đa hai hành khách và dễ kiểm thử hơn.

## Rủi ro

| Rủi ro | Cách kiểm soát |
|---|---|
| Google Maps API/billing/key | Giới hạn API, tách key theo nền tảng, không commit key |
| Race condition nhận chuyến/giữ ghế | Cloud Function + transaction; test hai yêu cầu đồng thời |
| GPS không ổn định | Có vị trí gần nhất, timestamp, retry; có chế độ mô phỏng GPS |
| Ghép sai chiều hoặc sai thứ tự | Kiểm tra cumulative distance trên polyline và precedence pickup/dropoff |
| Xung đột code | Contract-first, branch riêng, PR nhỏ, tích hợp thường xuyên |
| Thiếu thời gian | Ưu tiên Must-have, không làm thanh toán thật |

## Điều kiện nghiệm thu tổng thể

- Luồng đặt xe tiêu chuẩn hoàn chỉnh.
- Không thể có hai tài xế cùng nhận thành công một trip.
- Không thể đặt vượt số ghế.
- Chuyến ngược chiều bị loại khỏi kết quả tiện chuyến.
- Ghép A/B chỉ commit sau khi A xác nhận lần hai, B xác nhận và tài xế xác nhận.
- Nếu bị từ chối/hết hạn, giữ nguyên tuyến và giá ban đầu.
- Có kiểm thử cho các tình huống trong SRS và hướng dẫn chạy dự án.
