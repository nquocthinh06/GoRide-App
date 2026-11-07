import 'location_point.dart';
import 'trip_enums.dart';

class CarpoolProposal {
  const CarpoolProposal({
    required this.id,
    required this.tripId,
    required this.passengerAId,
    required this.passengerBId,
    required this.proposedStops,
    required this.proposedFareA,
    required this.proposedFareB,
    required this.expiresAt,
    required this.status,
    this.version = 1,
  });

  final String id;
  final String tripId;
  final String passengerAId;
  final String passengerBId;
  final List<LocationPoint> proposedStops;
  final int proposedFareA;
  final int proposedFareB;
  final DateTime expiresAt;
  final CarpoolProposalStatus status;
  final int version;
}

