import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/business_category.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';
import 'package:growth_pilot_ai/core/enum/verification_status.dart';
import 'package:growth_pilot_ai/core/models/tax_breakdown.dart';

/// Source-agnostic transaction record: normalizes data from any provider into
/// one shape for the dashboard and analytics. Always scoped to a [businessId]
/// (tenant isolation); keeps both the internal [category] and provider
/// [rawCategory].
@immutable
class UnifiedTransaction {
  final String businessId;
  final String transactionId;
  final String? externalId;
  final double amount;
  final String currency;
  final DateTime date;
  final String merchantName;
  final TransactionSource source;
  final BusinessCategory category;
  final String? rawCategory;
  final VerificationStatus status;
  final TaxBreakdown? tax;
  final List<String> tags;

  const UnifiedTransaction({
    required this.businessId,
    required this.transactionId,
    required this.amount,
    required this.date,
    required this.merchantName,
    required this.source,
    this.externalId,
    this.currency = 'CAD',
    this.category = BusinessCategory.uncategorized,
    this.rawCategory,
    this.status = VerificationStatus.pending,
    this.tax,
    this.tags = const [],
  });
}
