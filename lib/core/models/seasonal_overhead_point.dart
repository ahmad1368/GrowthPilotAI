import 'package:flutter/foundation.dart';

/// One calendar month's average overhead expense across every year of
/// local history (Issue #386). [isPeak] flags the single highest-averaging
/// month — the closest local proxy for "seasonal utility/HVAC cost
/// fluctuation", since no weather/equipment-sensor data exists.
@immutable
class SeasonalOverheadPoint {
  final int month; // 1-12
  final double averageExpense;
  final bool isPeak;

  const SeasonalOverheadPoint({
    required this.month,
    required this.averageExpense,
    this.isPeak = false,
  });

  static const monthLabels = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
}
