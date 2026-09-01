import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/spending_trend.dart';

/// One vendor's spend scorecard (Issue #369) — the closest local proxy for
/// "supplier price & quality scoring" this app's data model supports, since
/// there's no delivery-punctuality/defect-rate/invoice-discrepancy tracking.
@immutable
class SupplierScorecard {
  final String vendorName;
  final double totalSpend;
  final int transactionCount;
  final double averageAmount;
  final SpendingTrend priceTrend;
  final bool isRecommended;

  const SupplierScorecard({
    required this.vendorName,
    required this.totalSpend,
    required this.transactionCount,
    required this.averageAmount,
    required this.priceTrend,
    this.isRecommended = false,
  });
}
