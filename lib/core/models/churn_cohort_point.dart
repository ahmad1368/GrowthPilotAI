import 'package:flutter/foundation.dart';

/// Transaction count for one trailing week (Issue #357) — each transaction
/// stands in for a customer visit, the same proxy [TrafficPoint] uses,
/// since this app has no dedicated customer/CRM entity.
@immutable
class ChurnCohortPoint {
  final int weeksAgo;
  final int count;

  const ChurnCohortPoint({required this.weeksAgo, required this.count});
}
