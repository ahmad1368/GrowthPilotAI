import 'package:flutter/foundation.dart';

/// The five "Success DNA" axes of the Business Compass radar (Issue #84),
/// each normalized to [0.0, 1.0] so the chart never needs raw dollar
/// amounts (the issue's "Data Masking" requirement).
@immutable
class BusinessCompassMetrics {
  final double liquidityRatio;
  final double burnVelocity;
  final double vendorDiversity;
  final double paymentPunctuality;
  final double profitMargin;

  const BusinessCompassMetrics({
    required this.liquidityRatio,
    required this.burnVelocity,
    required this.vendorDiversity,
    required this.paymentPunctuality,
    required this.profitMargin,
  });

  /// Radar-chart axis order: Liquidity, Burn Velocity, Vendor Diversity,
  /// Payment Punctuality, Profit Margin.
  List<double> toList() =>
      [liquidityRatio, burnVelocity, vendorDiversity, paymentPunctuality, profitMargin];

  static const labels = [
    'Liquidity',
    'Burn Velocity',
    'Vendor Diversity',
    'Punctuality',
    'Profit Margin',
  ];
}
