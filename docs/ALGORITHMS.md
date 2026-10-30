# Core Algorithms

## 1. Haversine — lọc tài xế gần

Dùng khoảng cách đường chim bay để lọc sơ bộ. Bán kính nền trong đặc tả: 3 km, có thể mở rộng đến 5 km nếu chưa tìm được tài xế sau một khoảng thời gian. Không dùng Haversine thay cho khoảng cách đường đi thực tế.

```text
a = sin²(Δlat/2) + cos(lat1) × cos(lat2) × sin²(Δlng/2)
d = 2R × asin(√a), R ≈ 6371 km
```

## 2. Matching chuyến tiện đường

Các điều kiện lọc:

- Hành lang tuyến khoảng 1.5 km (cấu hình được).
- Chênh lệch giờ dự kiến khoảng 30 phút (cấu hình được).
- Cùng chiều đi; loại tuyến ngược chiều.
- Pickup phải đứng trước dropoff theo khoảng cách dọc tuyến.
- Còn đủ số ghế và không vượt sức chứa.
- Không vượt `maxExtraTime` hoặc `maxDetourDistance`.

Nên chiếu pickup/dropoff lên từng segment của encoded polyline và dùng cumulative route distance để xác định thứ tự, thay vì chỉ dùng index vertex gần nhất.

## 3. Tối ưu điểm dừng A/B

Với MVP tối đa hai hành khách, liệt kê các thứ tự dừng hợp lệ:

- Các điểm bắt buộc gồm pickup/dropoff B và các điểm còn lại của hành trình.
- Pickup(B) phải trước Dropoff(B).
- A đã được đón thì không tạo lại pickup(A) trong các điểm dừng còn lại.
- Loại phương án vượt ghế, thời gian hoặc quãng đường vòng.
- Tính tổng thời gian/quãng đường và ảnh hưởng ETA từng khách.
- Chọn phương án có cost thấp nhất.

Cost có thể cấu hình theo:
`w1 × ExtraDistance + w2 × ExtraTime + w3 × DetourA + w4 × DetourB + w5 × PickupDelay`.

Không cố định trọng số trước khi có kiểm thử.

## 4. Pricing

Giá phải thể hiện rõ giá cũ, giá mới và ưu đãi tiện chuyến. Bảng giá nền và hệ số giảm trong SRS phải được đưa vào cấu hình, không hard-code rải rác. Mọi thay đổi giá đã xác nhận cần có sự đồng ý của người bị ảnh hưởng.

## 5. Test cases tối thiểu

- Tọa độ trùng nhau, rất xa, tọa độ biên.
- Tuyến cùng chiều, ngược chiều, lệch hành lang.
- Pickup/dropoff đảo thứ tự.
- Không còn ghế và hai khách tranh ghế cuối.
- Proposal hết hạn, bị từ chối, thiếu một xác nhận.
- Hai tài xế nhận cùng trip gần như đồng thời.
