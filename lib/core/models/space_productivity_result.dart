import 'package:flutter/foundation.dart';

/// Revenue-per-square-foot result for the Commercial Space Productivity
/// Index (Issue #398).
@immutable
class SpaceProductivityResult {
  final double totalRevenue;
  final double squareFootage;
  final double revenuePerSquareFoot;

  const SpaceProductivityResult({
    required this.totalRevenue,
    required this.squareFootage,
    required this.revenuePerSquareFoot,
  });

  bool get hasSquareFootage => squareFootage > 0;
}
