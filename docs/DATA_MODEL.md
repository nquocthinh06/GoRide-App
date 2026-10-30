# Data Model — initial proposal

> Đây là bản khung để nhóm thống nhất trước khi triển khai; cần đối chiếu và chốt field cuối cùng trong Issue GOR-003.

## Firestore collections

| Collection | Key fields | Purpose |
|---|---|---|
| `users/{uid}` | `displayName`, `phone`, `role`, `createdAt` | Hồ sơ và vai trò |
| `vehicles/{vehicleId}` | `ownerUid`, `type`, `capacity`, `plateMasked`, `status` | Phương tiện |
| `ride_requests/{requestId}` | `passengerUid`, `pickup`, `dropoff`, `requestedAt`, `status` | Yêu cầu đặt chuyến |
| `trips/{tripId}` | `driverId`, `passengerIds`, `origin`, `destination`, `status`, `fare`, `version` | Chuyến tổng |
| `carpool_schedules/{scheduleId}` | `driverId`, `origin`, `destination`, `departureAt`, `encodedPolyline`, `availableSeats`, `status` | Lịch tiện chuyến |
| `carpool_proposals/{proposalId}` | `tripId`, `passengerAId`, `passengerBId`, `proposedStops`, `proposedRoute`, `fareChanges`, `etaChanges`, `expiresAt`, `status`, `version` | Đề xuất ghép |
| `passenger_legs/{legId}` | `tripId`, `passengerUid`, `pickup`, `dropoff`, `status`, `fareShare` | Trạng thái riêng từng khách |
| `ratings/{ratingId}` | `tripId`, `fromUid`, `toUid`, `score`, `comment`, `createdAt` | Đánh giá |

## Realtime Database paths

| Path | Fields |
|---|---|
| `drivers_online/{uid}` | `lat`, `lng`, `heading`, `speed`, `vehicleType`, `availability`, `updatedAt` |
| `active_trips/{tripId}` | `status`, `currentDriverLocation`, `currentStopIndex`, `updatedAt` |
| `trip_presence/{tripId}/{uid}` | `connected`, `lastSeenAt` |

## Data integrity

- Dùng server timestamp cho thời điểm ghi.
- Có `version` hoặc điều kiện trạng thái để tránh ghi đè dữ liệu cũ.
- Không tin `availableSeats`, `fare`, `driverId`, `proposal.status` từ client.
- Các cập nhật đồng thời phải kiểm tra điều kiện và ghi nguyên tử.
- Firestore Security Rules giới hạn truy cập theo `request.auth.uid`, vai trò và quan hệ tham gia chuyến.
- Chỉ lưu dữ liệu vị trí cần thiết; giới hạn quyền và thời gian chia sẻ.
