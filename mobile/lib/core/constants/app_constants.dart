class AppConstants {
  const AppConstants._();

  static const String appName = 'GoRide';

  // MVP scope & matching thresholds (configurable per SRS)
  static const int maxPassengersPerTrip = 2;
  static const double haversineInitialRadiusKm = 3.0;
  static const double haversineExpandedRadiusKm = 5.0;
  static const double carpoolCorridorKm = 1.5;
  static const int carpoolTimeWindowMinutes = 30;
}

