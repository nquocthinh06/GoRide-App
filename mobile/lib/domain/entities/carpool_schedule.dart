import 'location_point.dart';
import 'trip_enums.dart';

class CarpoolSchedule {
  const CarpoolSchedule({
    required this.id,
    required this.driverId,
    required this.origin,
    required this.destination,
    required this.departureAt,
    required this.encodedPolyline,
    required this.availableSeats,
    required this.status,
  });

  final String id;
  final String driverId;
  final LocationPoint origin;
  final LocationPoint destination;
  final DateTime departureAt;
  final String encodedPolyline;
  final int availableSeats;
  final CarpoolScheduleStatus status;
}

class CarpoolSearch {
  const CarpoolSearch({
    required this.pickup,
    required this.dropoff,
    required this.desiredDepartureAt,
    this.seatsRequested = 1,
  });

  final LocationPoint pickup;
  final LocationPoint dropoff;
  final DateTime desiredDepartureAt;
  final int seatsRequested;
}

class CarpoolMatch {
  const CarpoolMatch({
    required this.schedule,
    required this.estimatedFare,
    required this.extraDistanceKm,
    required this.extraDurationMinutes,
  });

  final CarpoolSchedule schedule;
  final int estimatedFare;
  final double extraDistanceKm;
  final int extraDurationMinutes;
}
