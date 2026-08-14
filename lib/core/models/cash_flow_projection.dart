import 'package:flutter/foundation.dart';

/// One future month's projected cash flow (Issue #368).
@immutable
class CashFlowProjection {
  final String monthLabel;
  final double projectedInflow;
  final double projectedOutflow;

  const CashFlowProjection({
    required this.monthLabel,
    required this.projectedInflow,
    required this.projectedOutflow,
  });

  double get projectedNet => projectedInflow - projectedOutflow;
  bool get isDeficit => projectedNet < 0;
}
