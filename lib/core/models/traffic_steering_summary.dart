/// One logged directive's traffic-steering read (Issue #334): its share
/// of all redirects logged across every directive, for monitoring
/// merchant traffic deviation rates.
class TrafficSteeringSummary {
  final String targetName;
  final String destinationLabel;
  final int redirectCount;
  final double deviationSharePercent;
  final DateTime createdAt;

  const TrafficSteeringSummary({
    required this.targetName,
    required this.destinationLabel,
    required this.redirectCount,
    required this.deviationSharePercent,
    required this.createdAt,
  });
}
