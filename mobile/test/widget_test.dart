import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goride_mobile/core/constants/app_constants.dart';
import 'package:goride_mobile/core/errors/app_failure.dart';
import 'package:goride_mobile/core/errors/result.dart';
import 'package:goride_mobile/domain/entities/trip_enums.dart';
import 'package:goride_mobile/presentation/app.dart';

void main() {
  group('GoRide Smoke Tests (GOR-002)', () {
    testWidgets('renders AuthScreen and navigates to Passenger and Driver flows',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: GoRideApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('GoRide — Đặt chuyến & Tiện chuyến'), findsOneWidget);
      expect(find.byKey(const Key('role_passenger_button')), findsOneWidget);
      expect(find.byKey(const Key('role_driver_button')), findsOneWidget);

      // Navigate to Passenger flow
      await tester.tap(find.byKey(const Key('role_passenger_button')));
      await tester.pumpAndSettle();

      expect(find.text('Hành khách — GoRide'), findsOneWidget);
      expect(find.text('Đặt chuyến tiêu chuẩn'), findsOneWidget);
      expect(find.text('Tìm chuyến tiện đường'), findsOneWidget);

      // Switch role back to AuthScreen
      await tester.tap(find.byKey(const Key('passenger_switch_role_button')));
      await tester.pumpAndSettle();

      // Navigate to Driver flow
      await tester.tap(find.byKey(const Key('role_driver_button')));
      await tester.pumpAndSettle();

      expect(find.text('Tài xế — GoRide'), findsOneWidget);
      expect(find.text('Đăng lịch tiện chuyến'), findsOneWidget);
    });

    test('MVP constants and Result type behave as expected', () {
      expect(AppConstants.maxPassengersPerTrip, 2);
      expect(AppConstants.haversineInitialRadiusKm, 3.0);
      expect(AppConstants.carpoolCorridorKm, 1.5);
      expect(TripStatus.values, contains(TripStatus.searching));
      expect(
        CarpoolProposalStatus.values,
        contains(CarpoolProposalStatus.confirmed),
      );

      const Result<int> ok = Success<int>(42);
      const Result<int> err = Failure<int>(
        AppFailure(code: 'TEST_ERR', message: 'Test error'),
      );

      expect(ok.isSuccess, isTrue);
      expect(ok.isFailure, isFalse);
      expect(err.isFailure, isTrue);
      expect(err.isSuccess, isFalse);
    });
  });
}
