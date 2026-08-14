import 'package:flutter/foundation.dart';

/// How a transaction's suggested account was decided (Issue #57).
enum MappingSource { userRule, fuzzyMatch, none }

/// Outcome of mapping one transaction to a Chart-of-Accounts entry. Anything
/// below [reviewThreshold] confidence must be flagged "Needs Review".
@immutable
class MappingResult {
  static const double reviewThreshold = 0.5;

  final String? suggestedAccountId;
  final double confidence;
  final MappingSource source;

  const MappingResult({
    required this.suggestedAccountId,
    required this.confidence,
    required this.source,
  });

  bool get needsReview => confidence < reviewThreshold;
}
