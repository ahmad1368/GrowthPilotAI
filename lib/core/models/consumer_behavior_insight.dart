import 'package:flutter/foundation.dart';

/// How well the current basket mix fits a budget-conscious, low-income
/// customer base (Issue #353).
enum LowIncomeFitTier { strong, moderate, weak }

/// Result of segmenting transactions against a documented low-income
/// spending profile (Issue #353).
@immutable
class ConsumerBehaviorInsight {
  final double averageBasketSize;
  final double visitFrequencyPerWeek;
  final double budgetFriendlyShare;
  final LowIncomeFitTier fitTier;

  const ConsumerBehaviorInsight({
    required this.averageBasketSize,
    required this.visitFrequencyPerWeek,
    required this.budgetFriendlyShare,
    required this.fitTier,
  });
}
