/// One logged staff shift's efficiency read (Issue #379): transaction
/// volume and throughput handled during the shift window.
class StaffEfficiency {
  final String staffName;
  final DateTime startTime;
  final DateTime endTime;
  final int transactionCount;
  final double totalVolume;
  final double avgTicketSize;
  final double transactionsPerHour;

  const StaffEfficiency({
    required this.staffName,
    required this.startTime,
    required this.endTime,
    required this.transactionCount,
    required this.totalVolume,
    required this.avgTicketSize,
    required this.transactionsPerHour,
  });
}
