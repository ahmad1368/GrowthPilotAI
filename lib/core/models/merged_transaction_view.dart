import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/business_category.dart';
import 'package:growth_pilot_ai/core/models/tax_breakdown.dart';

/// Read-only, display-ready shape of two merged records (Issue #69):
/// the bank's posted date, the accounting side's category/tax, and both
/// providers' external ids for traceability.
@immutable
class MergedTransactionView {
  final DateTime postedDate;
  final double amount;
  final String merchantName;
  final BusinessCategory category;
  final TaxBreakdown tax;
  final List<String> originSources;
  final double matchScore;

  const MergedTransactionView({
    required this.postedDate,
    required this.amount,
    required this.merchantName,
    required this.category,
    required this.tax,
    required this.originSources,
    required this.matchScore,
  });
}
