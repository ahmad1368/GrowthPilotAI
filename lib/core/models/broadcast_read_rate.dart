/// One dispatched broadcast's delivery/read status read (Issue #345,
/// acceptance criterion 3).
class BroadcastReadRate {
  final int id;
  final String messageBody;
  final String targetNeighborhoods;
  final int recipientCount;
  final int readCount;
  final double readRatePercent;
  final DateTime dispatchedAt;

  const BroadcastReadRate({
    required this.id,
    required this.messageBody,
    required this.targetNeighborhoods,
    required this.recipientCount,
    required this.readCount,
    required this.readRatePercent,
    required this.dispatchedAt,
  });
}
