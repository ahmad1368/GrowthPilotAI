/// One logged day's visitor-to-buyer conversion read (Issue #387):
/// transactions closed against the manually-logged visitor count.
class ConversionRate {
  final DateTime date;
  final int visitorCount;
  final int transactionCount;
  final double conversionPercent;

  const ConversionRate({
    required this.date,
    required this.visitorCount,
    required this.transactionCount,
    required this.conversionPercent,
  });
}
