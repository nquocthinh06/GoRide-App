# Flutter application

Ứng dụng Android Flutter/Dart.

## Scaffold

```bash
flutter create .
flutter pub get
flutter analyze
flutter test
```

## Suggested dependencies

Chốt phiên bản ổn định tương thích trong PR đầu tiên:

- `flutter_riverpod`
- `go_router`
- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `firebase_database`
- `firebase_messaging`
- `google_maps_flutter`
- `geolocator`
- `flutter_polyline_points` (nếu phù hợp với API route được chọn)

Không thêm tất cả package cùng lúc nếu chưa có màn hình/use case sử dụng. Không commit file cấu hình chứa secret.
