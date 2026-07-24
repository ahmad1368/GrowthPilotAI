import 'package:flutter/foundation.dart';

/// One plotted point on the Profit Margin Analysis trend (Issue #350):
/// net margin for the period starting at [periodStart].
@immutable
class ProfitMarginPoint {
  final DateTime periodStart;
  final double marginPercent;

  const ProfitMarginPoint({
    required this.periodStart,
    required this.marginPercent,
  });
}
