import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài xế — GoRide'),
        actions: [
          IconButton(
            key: const Key('driver_switch_role_button'),
            tooltip: 'Đổi vai trò',
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.swap_horiz),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.online_prediction_outlined),
              title: Text('Trạng thái hoạt động'),
              subtitle: Text('Bật Online để nhận yêu cầu chuyến tiêu chuẩn'),
            ),
          ),
          SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: Icon(Icons.route_outlined),
              title: Text('Đăng lịch tiện chuyến'),
              subtitle: Text('Công bố lộ trình và số ghế trống cho khách cùng chiều'),
            ),
          ),
        ],
      ),
    );
  }
}

