import 'package:flutter/foundation.dart';

/// One row of financial context ready to inject into the SLM prompt
/// (Issue #199) — deliberately decoupled from any specific entity so
/// callers can adapt whichever local record they have.
@immutable
class ContextRecord {
  final DateTime date;
  final String merchant;
  final double amount;
  final String category;

  const ContextRecord({
    required this.date,
    required this.merchant,
    required this.amount,
    required this.category,
  });
}
