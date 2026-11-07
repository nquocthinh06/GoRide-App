enum UserRole {
  passenger,
  driver,
}

enum TripStatus {
  searching,
  accepted,
  driverArriving,
  arrived,
  inProgress,
  sharedPending,
  sharedConfirmed,
  completed,
  cancelled,
  expired,
}

enum CarpoolScheduleStatus {
  open,
  full,
  inProgress,
  completed,
  cancelled,
  expired,
}

enum CarpoolProposalStatus {
  created,
  waitingA,
  waitingB,
  waitingDriver,
  confirmed,
  rejected,
  expired,
  cancelled,
}

enum PassengerLegStatus {
  waitingPickup,
  driverArriving,
  arrivedPickup,
  onboard,
  arrivedDropoff,
  completed,
  cancelled,
}

enum ProposalActor {
  passengerA,
  passengerB,
  driver,
}
