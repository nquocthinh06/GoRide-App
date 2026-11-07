# GoRide App

Ứng dụng Android xây dựng bằng Flutter/Dart, hỗ trợ đặt chuyến tiêu chuẩn và chia sẻ chuyến đi theo lộ trình có sẵn của tài xế.

> **Project status:** Planning / Not started  
> **Team size:** 2 members  
> **Schedule:** 8 weeks — 02/11/2026 to 27/12/2026  
> **Repository:** `nquocthinh06/GoRide-App` (tạo trên GitHub trước khi chạy script bootstrap)

## 1. Mục tiêu MVP

GoRide tập trung vào hai luồng:

1. **Chuyến tiêu chuẩn:** hành khách tạo yêu cầu, tài xế nhận chuyến, đón khách, cập nhật trạng thái và hoàn thành chuyến.
2. **Tiện chuyến / ghép chuyến:** tài xế công bố lộ trình; hệ thống tìm yêu cầu phù hợp theo tuyến, chiều đi, thời gian và số ghế. Khi hành khách A đang trên xe đồng ý tìm khách B, hệ thống tạo đề xuất tuyến/giá mới. Chỉ cập nhật chuyến sau khi A xác nhận lần hai, B xác nhận và tài xế xác nhận.

### Phạm vi MVP cần giữ ổn định

- Một tài xế trên một chuyến.
- Tối đa hai hành khách trên cùng chuyến.
- Một lần ghép thêm hành khách B vào chuyến đang thực hiện.
- Không triển khai thanh toán thật trong MVP.
- Không triển khai nhiều tài xế hoặc ghép không giới hạn hành khách.
- Các ngưỡng ghép tuyến/thời gian và trọng số tính giá phải cấu hình được để kiểm thử.

## 2. Công nghệ dự kiến

| Thành phần | Công nghệ |
|---|---|
| Mobile app | Flutter, Dart |
| State management | Riverpod |
| Navigation | GoRouter |
| Authentication | Firebase Authentication |
| Database | Cloud Firestore |
| Realtime GPS | Firebase Realtime Database |
| Trusted business operations | Cloud Functions (TypeScript/Node.js) |
| Push notifications | Firebase Cloud Messaging |
| Map / route | Google Maps Platform |
| Tests | `flutter_test`, unit tests, Firebase Emulator Suite (khi cấu hình) |
| CI | GitHub Actions |

**Lưu ý:** ứng dụng Flutter dùng Dart. Cloud Functions có thể dùng TypeScript vì đây là môi trường backend riêng; không cần ép toàn bộ hệ thống viết bằng Dart.

## 3. Thành viên và phân công

| Thành viên | Phụ trách chính | Kết quả bàn giao |
|---|---|---|
| Member 1 — `nquocthinh06` | Flutter UI, navigation, map screens, GPS presentation, tích hợp giao diện | Màn hình Passenger/Driver, bản đồ, luồng thao tác |
| Member 2 — `nguyentruc241006` | Firebase, data model, repositories, business logic, matching/pricing/route algorithms, tests | Firebase rules, Cloud Functions, domain logic, test cases |

Hai thành viên cùng chịu trách nhiệm: phân tích SRS, thống nhất API/model contract, review PR, tích hợp, kiểm thử hệ thống, tài liệu và demo.

## 4. Cấu trúc repository

```text
GoRide-App/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── workflows/flutter-ci.yml
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── labels.csv
│   ├── milestones.csv
│   └── issues/
├── docs/
│   ├── PROJECT_PLAN.md
│   ├── ARCHITECTURE.md
│   ├── DATA_MODEL.md
│   ├── API_CONTRACTS.md
│   ├── ALGORITHMS.md
│   └── TEST_PLAN.md
├── mobile/
│   ├── lib/
│   │   ├── core/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── test/
│   └── README.md
├── functions/
│   └── README.md
├── firebase/
│   ├── firestore.rules
│   └── README.md
├── .gitignore
├── CONTRIBUTING.md
└── README.md
```

## 5. Bắt đầu phát triển

### Yêu cầu môi trường

- Flutter stable và Dart SDK tương thích.
- Android Studio hoặc VS Code, Android SDK và emulator/thiết bị Android.
- Git và GitHub CLI (`gh`).
- Firebase project; Google Maps API key được cấu hình riêng ở môi trường local/CI.

### Khởi tạo ứng dụng Flutter

Từ thư mục gốc:

```bash
flutter create mobile
cd mobile
flutter pub get
flutter analyze
flutter test
```

Sau khi scaffold Flutter thành công, giữ lại các thư mục `lib/` và `test/` theo kiến trúc trong `docs/ARCHITECTURE.md`. Nếu đã tạo `mobile/` từ bộ starter này, chạy `flutter create .` bên trong `mobile/` để bổ sung các file nền của Flutter.

### Clone repository

```bash
git clone https://github.com/nquocthinh06/GoRide-App.git
cd GoRide-App
```

### Chạy ứng dụng

```bash
cd mobile
flutter pub get
flutter run
```

## 6. Quy trình Git

- `main`: phiên bản ổn định, chỉ nhận merge từ PR.
- `develop`: nhánh tích hợp chung.
- `feature/GOR-xxx-short-name`: phát triển tính năng.
- `fix/GOR-xxx-short-name`: sửa lỗi.
- `docs/short-name`: tài liệu.

Không push trực tiếp lên `main`. Mỗi thay đổi cần Issue → Branch → Pull Request → Review → Merge.

### Commit convention

```text
feat: add passenger booking screen
fix: prevent duplicate trip acceptance
refactor: separate trip repository
test: add haversine unit tests
docs: update database schema
chore: configure flutter ci
```

## 7. Definition of Done

Một Issue chỉ được chuyển sang Done khi:

- Đáp ứng Acceptance Criteria trong Issue.
- Code chạy được, `flutter analyze` không có lỗi nghiêm trọng.
- Có unit/widget/integration test phù hợp.
- Không chứa API key, service account key, mật khẩu hoặc dữ liệu cá nhân thật.
- PR đã được thành viên còn lại review.
- Đã merge vào `develop`.
- Tài liệu liên quan được cập nhật.

## 8. Bảo mật và cấu hình

- Không commit `.env`, Firebase service account JSON, keystore, API key có quyền ghi hoặc thông tin đăng nhập.
- Không đặt Firestore Rules ở chế độ public read/write.
- Kiểm tra quyền theo `uid`, vai trò và quan hệ tham gia chuyến.
- Chỉ chia sẻ vị trí tài xế trong thời gian Online/chuyến hoạt động và với người có quyền xem.
- Các thao tác nhận chuyến, giữ ghế, xác nhận ghép và cập nhật giá cần kiểm tra nguyên tử ở backend.

## 9. GitHub Project

Tạo GitHub Project dạng Board với các trạng thái:

`Backlog` → `Ready` → `In Progress` → `In Review` → `Done`

Thêm trạng thái `Blocked` để theo dõi việc bị phụ thuộc. Nên tạo các view: Board, Roadmap, By Member, By Milestone.

## 10. Tài liệu

- Kế hoạch 8 tuần: [`docs/PROJECT_PLAN.md`](docs/PROJECT_PLAN.md)
- Kiến trúc: [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)
- Mô hình dữ liệu: [`docs/DATA_MODEL.md`](docs/DATA_MODEL.md)
- Hợp đồng repository/API: [`docs/API_CONTRACTS.md`](docs/API_CONTRACTS.md)
- Thuật toán: [`docs/ALGORITHMS.md`](docs/ALGORITHMS.md)
- Kiểm thử: [`docs/TEST_PLAN.md`](docs/TEST_PLAN.md)
- Quy trình cộng tác: [`CONTRIBUTING.md`](CONTRIBUTING.md)
