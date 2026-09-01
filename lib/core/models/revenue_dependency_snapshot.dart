import 'package:flutter/foundation.dart';

/// Repeat-vs-one-time revenue breakdown and concentration-risk read
/// (Issue #376).
@immutable
class RevenueDependencySnapshot {
  final double totalRevenue;
  final double repeatRevenue;
  final double oneTimeRevenue;
  final double repeatRevenueShare;
  final int repeatCustomerCount;
  final int oneTimeCustomerCount;
  final String? topCustomerLabel;
  final double topCustomerShare;
  final bool isConcentrationRisk;

  const RevenueDependencySnapshot({
    required this.totalRevenue,
    required this.repeatRevenue,
    required this.oneTimeRevenue,
    required this.repeatRevenueShare,
    required this.repeatCustomerCount,
    required this.oneTimeCustomerCount,
    required this.topCustomerLabel,
    required this.topCustomerShare,
    required this.isConcentrationRisk,
  });
}
