import 'package:flutter/foundation.dart';

/// A statutory holiday's revenue lift vs. an ordinary-day baseline (Issue
/// #388).
@immutable
class HolidaySalesImpact {
  final String holidayName;
  final double holidayRevenue;
  final double baselineRevenue;

  const HolidaySalesImpact({
    required this.holidayName,
    required this.holidayRevenue,
    required this.baselineRevenue,
  });

  double get liftPercent =>
      baselineRevenue <= 0 ? 0.0 : ((holidayRevenue - baselineRevenue) / baselineRevenue) * 100;
}
