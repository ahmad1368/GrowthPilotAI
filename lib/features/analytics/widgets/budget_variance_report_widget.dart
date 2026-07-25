import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/budget_variance_body.dart';

/// Registers the Budget Variance Alert System widget (Issue #383) as a
/// pluggable report widget under id `BUDGET_VARIANCE` (#111): merchant-
/// configured monthly limits vs. trailing-30-day actual spend per category.
class BudgetVarianceReportWidget extends BaseReportWidget {
  const BudgetVarianceReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return BudgetVarianceBody(
      transactions: data['transactions'] as List<TransactionEntity>,
      initialLimits: data['limits'] as List<BudgetLimitEntity>,
    );
  }
}
