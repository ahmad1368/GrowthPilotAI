/// One logged day's foot/vehicular traffic read (Issue #381): sales
/// closed against the manually-logged traffic counts, plus the weekday
/// name for peak-day comparison.
class DailyTrafficAnalytics {
  final DateTime date;
  final int footTraffic;
  final int vehicleTraffic;
  final int salesCount;
  final double conversionPercent;
  final String weekdayLabel;

  const DailyTrafficAnalytics({
    required this.date,
    required this.footTraffic,
    required this.vehicleTraffic,
    required this.salesCount,
    required this.conversionPercent,
    required this.weekdayLabel,
  });

  int get totalTraffic => footTraffic + vehicleTraffic;
}
