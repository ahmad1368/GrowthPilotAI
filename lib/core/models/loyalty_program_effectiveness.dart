import 'package:flutter/foundation.dart';

/// Simulated loyalty-points liability vs the repeat-customer revenue it
/// protects (Issue #396).
@immutable
class LoyaltyProgramEffectiveness {
  final int pointsIssued;
  final double liabilityCost;
  final double repeatCustomerRevenue;
  final double roiRatio;
  final bool isEffective;

  const LoyaltyProgramEffectiveness({
    required this.pointsIssued,
    required this.liabilityCost,
    required this.repeatCustomerRevenue,
    required this.roiRatio,
    required this.isEffective,
  });
}
