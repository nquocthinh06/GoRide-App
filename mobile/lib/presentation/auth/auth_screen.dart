import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GoRide'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.directions_car_filled_rounded,
                size: 64,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'GoRide — Đặt chuyến & Tiện chuyến',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Chọn vai trò để tiếp tục trải nghiệm ứng dụng.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                key: const Key('role_passenger_button'),
                onPressed: () => context.go('/passenger'),
                icon: const Icon(Icons.person_pin_circle_outlined),
                label: const Text('Tiếp tục với vai trò Hành khách'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                key: const Key('role_driver_button'),
                onPressed: () => context.go('/driver'),
                icon: const Icon(Icons.drive_eta_outlined),
                label: const Text('Tiếp tục với vai trò Tài xế'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
