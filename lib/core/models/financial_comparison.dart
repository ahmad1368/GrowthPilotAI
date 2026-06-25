import 'package:flutter/foundation.dart';

@immutable
class FinancialComparison {
  final double totalDifference;
  final double percentageChange;
  final bool isNegativeTrend;

  const FinancialComparison({
    required this.totalDifference,
    required this.percentageChange,
    required this.isNegativeTrend,
  });
}
