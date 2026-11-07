import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PassengerHomeScreen extends StatelessWidget {
  const PassengerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hành khách — GoRide'),
        actions: [
          IconButton(
            key: const Key('passenger_switch_role_button'),
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
              leading: Icon(Icons.local_taxi_outlined),
              title: Text('Đặt chuyến tiêu chuẩn'),
              subtitle: Text('Chọn điểm đón, điểm đến và tìm tài xế gần bạn'),
            ),
          ),
          SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: Icon(Icons.group_outlined),
              title: Text('Tìm chuyến tiện đường'),
              subtitle: Text('Ghép chuyến theo lộ trình có sẵn (tối đa 2 khách)'),
            ),
          ),
        ],
      ),
    );
  }
}
