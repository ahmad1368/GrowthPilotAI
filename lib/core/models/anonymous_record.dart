import 'package:flutter/foundation.dart';

/// An analytics-safe transaction record: identity stripped, metrics preserved.
/// Contains no direct PII — safe for cloud/"Big Data" storage.
@immutable
class AnonymousRecord {
  final String orgHash;
  final String period; // YYYY-MM
  final String region; // FSA, e.g. "V3J"
  final String? category;
  final double amount;
  final String currency;

  const AnonymousRecord({
    required this.orgHash,
    required this.period,
    required this.region,
    required this.amount,
    this.category,
    this.currency = 'CAD',
  });
}
