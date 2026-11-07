import '../entities/carpool_proposal.dart';
import '../entities/carpool_schedule.dart';
import '../entities/trip_enums.dart';

abstract interface class CarpoolRepository {
  Future<String> createSchedule(CarpoolSchedule schedule);
  Future<List<CarpoolMatch>> findMatches(CarpoolSearch search);
  Future<String> createProposal(String tripId, String passengerBId);
  Future<void> submitApproval(
    String proposalId,
    ProposalActor actor,
    bool accepted,
  );
  Stream<CarpoolProposal?> watchProposal(String proposalId);
}
