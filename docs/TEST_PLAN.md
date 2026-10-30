# Test Plan

## Unit tests (Dart)

- Haversine: same point, known distance, invalid coordinate.
- Polyline projection: point near segment, point outside corridor, cumulative distance ordering.
- Matching: same direction, reverse direction, time-window boundary, seat capacity.
- Route optimizer: precedence constraints, detour/time limits, choose minimum cost.
- Pricing: vehicle type, base distance, extra distance/time, carpool discount and rounding.
- State machine: valid/invalid transitions for Trip, Proposal and PassengerLeg.

## Firebase/backend tests

- User can read/update only permitted profile fields.
- Driver location visible only to authorized participants during online/active trip.
- Two drivers accepting one trip: exactly one succeeds.
- Two passengers reserving final seat: at most one succeeds.
- Proposal commit fails if any approval is missing, proposal expired or version changed.
- Rejection/expiry leaves original route and fare unchanged.

## SRS acceptance scenarios

Tạo kết quả Pass/Fail và bằng chứng cho TC-01 đến TC-18 theo SRS. Nhóm phải đọc toàn bộ bảng test trong SRS trước khi đánh dấu nghiệm thu; danh sách trong tài liệu này chỉ là nhóm kiểm thử kỹ thuật bổ sung.

## UI / integration

- Loading, empty, error, offline and retry.
- Permission denied for location.
- GPS updates with timestamp and stale-location display.
- Passenger and Driver flows on Android emulator/device.
- End-to-end demo with deterministic/simulated GPS.
