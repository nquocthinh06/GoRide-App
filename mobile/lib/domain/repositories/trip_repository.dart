import '../entities/trip.dart';
import '../entities/trip_enums.dart';

abstract interface class TripRepository {
  Future<String> createTrip(Trip trip);
  Future<void> acceptTrip(String tripId);
  Future<void> updateTripStatus(String tripId, TripStatus status);
  Stream<Trip?> watchTrip(String tripId);
  Stream<List<Trip>> watchMyTrips();
}

