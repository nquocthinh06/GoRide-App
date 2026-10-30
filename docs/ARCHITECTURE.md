# Architecture

## 1. Kiến trúc tổng thể

```text
Flutter UI (Passenger / Driver)
        |
Presentation (Riverpod + GoRouter)
        |
Domain (Entities, Use Cases, Repository Interfaces, Algorithms)
        |
Data (Repository Implementations, DTO, Firebase Data Sources)
        |
Firebase Auth | Cloud Firestore | Realtime Database | FCM
        |
Cloud Functions (trusted/atomic operations)
```

Google Maps Platform cung cấp bản đồ, geocoding/places và route polyline. Không để UI gọi trực tiếp các thao tác nghiệp vụ quan trọng nếu cần transaction hoặc xác thực quyền.

## 2. Phân lớp

- `presentation/`: screens, widgets, providers, routing.
- `domain/`: entities, enums, repository interfaces, use cases, pure Dart algorithms.
- `data/`: Firebase data sources, DTO/models, mappers, repository implementations.
- `core/`: errors, constants, validators, logging abstraction.

## 3. Backend boundary

Các thao tác nên chạy ở Cloud Functions hoặc backend tin cậy:

- `acceptTrip`: xác thực trạng thái SEARCHING và gán đúng một driver.
- `reserveSeat`: kiểm tra availableSeats và cập nhật nguyên tử.
- `createCarpoolProposal`: kiểm tra phiên bản chuyến, số ghế, thời hạn và trạng thái.
- `approveProposal`: ghi nhận sự đồng ý của từng bên.
- `commitProposal`: chỉ commit khi A, B và driver đều đồng ý, proposal chưa hết hạn.

Client không được tự quyết định kết quả cuối cùng của các thao tác trên.

## 4. Realtime

- Realtime Database: `drivers_online/{uid}`, `active_trips/{tripId}`, tùy chọn `trip_presence/{tripId}/{uid}`.
- Firestore: hồ sơ, trip, schedule, proposal, passenger leg và lịch sử.
- Cập nhật GPS có timestamp; UI phải hiển thị vị trí gần nhất khi mất kết nối.

## 5. Luồng ghép chuyến

1. A đang trên chuyến và chọn đồng ý tìm khách ghép.
2. Tìm B theo hành lang tuyến, chiều đi, thời gian và số ghế.
3. Tạo các phương án điểm dừng hợp lệ.
4. Tính lại ETA, quãng đường và giá.
5. Gửi đề xuất cho A (xác nhận lần hai), B và tài xế.
6. Chỉ commit nguyên tử khi cả ba đồng ý và đề xuất chưa hết hạn.
7. Nếu có người từ chối/hết hạn, giữ tuyến/giá cũ và giải phóng ghế đã giữ (nếu có).

## 6. Quy ước trạng thái

Trip: `SEARCHING`, `ACCEPTED`, `DRIVER_ARRIVING`, `ARRIVED`, `IN_PROGRESS`, `SHARED_PENDING`, `SHARED_CONFIRMED`, `COMPLETED`, `CANCELLED`, `EXPIRED`.

Carpool schedule: `OPEN`, `FULL`, `IN_PROGRESS`, `COMPLETED`, `CANCELLED`, `EXPIRED`.

Carpool proposal: `CREATED`, `WAITING_A`, `WAITING_B`, `WAITING_DRIVER`, `CONFIRMED`, `REJECTED`, `EXPIRED`, `CANCELLED`.

Passenger leg: `WAITING_PICKUP`, `DRIVER_ARRIVING`, `ARRIVED_PICKUP`, `ONBOARD`, `ARRIVED_DROPOFF`, `COMPLETED`, `CANCELLED`.

Không dùng một trạng thái Trip duy nhất để mô tả cả A và B. Mỗi hành khách cần PassengerLeg riêng để A có thể hoàn tất chặng trong khi B vẫn còn trên xe.
