# Repository / Use Case Contracts

Các interface dưới đây là contract khởi đầu. Nhóm cần chốt kiểu Entity, DTO và error model trong PR kiến trúc.

```dart
abstract interface class TripRepository {
  Future<String> createTrip(Trip trip);
  Future<void> acceptTrip(String tripId);
  Future<void> updateTripStatus(String tripId, TripStatus status);
  Stream<Trip?> watchTrip(String tripId);
  Stream<List<Trip>> watchMyTrips();
}

abstract interface class CarpoolRepository {
  Future<String> createSchedule(CarpoolSchedule schedule);
  Future<List<CarpoolMatch>> findMatches(CarpoolSearch search);
  Future<String> createProposal(String tripId, String passengerBId);
  Future<void> submitApproval(String proposalId, ProposalActor actor, bool accepted);
  Stream<CarpoolProposal?> watchProposal(String proposalId);
}
```

## Contract rules

- Repository interface thuộc `domain/`; implementation thuộc `data/`.
- UI gọi use case/provider, không truy cập Firestore trực tiếp.
- Lỗi dùng kiểu thống nhất (ví dụ `Result<T>` hoặc exception phân loại).
- Stream phải có hành vi khi document bị xóa hoặc người dùng mất quyền.
- Cloud Function trả về mã lỗi ổn định để client hiển thị thông báo phù hợp.

## Function contracts dự kiến

| Function | Input | Kết quả |
|---|---|---|
| `acceptTrip` | `tripId` | Driver được gán nếu trip còn SEARCHING |
| `reserveSeat` | `scheduleId`, `requestId` | Giữ ghế nếu còn chỗ |
| `createCarpoolProposal` | `tripId`, `passengerBId`, `expectedVersion` | Proposal mới |
| `approveProposal` | `proposalId`, `decision` | Lưu quyết định của actor |
| `commitProposal` | `proposalId`, `expectedVersion` | Commit khi đủ 3 xác nhận |

Mọi function phải xác thực Firebase Auth, quyền actor, trạng thái hiện tại, version và hạn đề xuất.
