import 'package:flutter/foundation.dart';

/// A lightweight, searchable Chart-of-Accounts entry synced from QuickBooks
/// or Xero (Issue #57) — just enough to drive fuzzy matching client-side.
@immutable
class ChartOfAccount {
  final String accountId;
  final String accountName;
  final String accountType;

  const ChartOfAccount({
    required this.accountId,
    required this.accountName,
    required this.accountType,
  });
}
