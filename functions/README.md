# Cloud Functions

Dùng Cloud Functions (TypeScript/Node.js) cho các nghiệp vụ cần quyền tin cậy và cập nhật nguyên tử.

Dự kiến:
- `acceptTrip`
- `reserveSeat`
- `createCarpoolProposal`
- `approveProposal`
- `commitProposal`

Khởi tạo sau khi tạo Firebase project:

```bash
firebase init functions
```

Chọn TypeScript. Không commit service account key hoặc file secret. Mỗi function phải xác thực Firebase Auth, quyền actor, trạng thái, version và điều kiện nghiệp vụ.
