import 'package:flutter/foundation.dart';

/// Revenue attributed to one buyer key (Issue #376) — this app has no
/// dedicated customer/CRM entity, so income transactions are grouped by
/// their normalized description text as a lightweight buyer proxy.
@immutable
class CustomerRevenueGroup {
  final String label;
  final double totalRevenue;
  final int transactionCount;
  final bool isRepeat;
  final DateTime firstPurchaseDate;
  final DateTime lastPurchaseDate;

  const CustomerRevenueGroup({
    required this.label,
    required this.totalRevenue,
    required this.transactionCount,
    required this.isRepeat,
    required this.firstPurchaseDate,
    required this.lastPurchaseDate,
  });
}
