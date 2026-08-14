import 'package:flutter/foundation.dart';

/// One calendar month's average income across every year of local history
/// (Issue #352). [isPeak] flags the single highest-averaging month.
@immutable
class SeasonalDemandPoint {
  final int month; // 1-12
  final double averageRevenue;
  final bool isPeak;

  const SeasonalDemandPoint({
    required this.month,
    required this.averageRevenue,
    this.isPeak = false,
  });

  static const monthLabels = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
}
