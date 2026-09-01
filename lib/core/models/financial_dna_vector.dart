import 'package:flutter/foundation.dart';

/// The "Financial DNA" feature vector (Issue #83 scope item 1) — four
/// normalized ratios compared against a sector's Success Vector via
/// [ComputeCosineSimilarity].
@immutable
class FinancialDnaVector {
  final double liquidityRatio;
  final double burnVelocity;
  final double vendorDiversity;
  final double paymentPunctuality;

  const FinancialDnaVector({
    required this.liquidityRatio,
    required this.burnVelocity,
    required this.vendorDiversity,
    required this.paymentPunctuality,
  });

  List<double> toList() => [liquidityRatio, burnVelocity, vendorDiversity, paymentPunctuality];
}
