import 'location_point.dart';
import 'trip_enums.dart';

class Trip {
  const Trip({
    required this.id,
    this.driverId,
    required this.passengerIds,
    required this.origin,
    required this.destination,
    required this.status,
    required this.fare,
    this.version = 1,
  });

  final String id;
  final String? driverId;
  final List<String> passengerIds;
  final LocationPoint origin;
  final LocationPoint destination;
  final TripStatus status;
  final int fare;
  final int version;
}

