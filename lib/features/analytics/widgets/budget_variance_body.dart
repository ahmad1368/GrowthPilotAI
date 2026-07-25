import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_budget_variance.dart';
import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/budget_limit_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/budget_limit_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/budget_variance_view.dart';

/// Owns the configured budget-limit list (Issue #383), refreshing it
/// locally after each quick-configure upsert.
class BudgetVarianceBody extends StatefulWidget {
  final List<TransactionEntity> transactions;
  final List<BudgetLimitEntity> initialLimits;

  const BudgetVarianceBody(
      {super.key, required this.transactions, required this.initialLimits});

  @override
  State<BudgetVarianceBody> createState() => _BudgetVarianceBodyState();
}

class _BudgetVarianceBodyState extends State<BudgetVarianceBody> {
  late List<BudgetLimitEntity> _limits = widget.initialLimits;

  Future<void> _setLimit() async {
    final result = await showBudgetLimitDialog(context);
    if (result == null) return;
    final (category, limit) = result;
    final repo = BudgetLimitRepository(Get.find<ObjectBox>().store.box<BudgetLimitEntity>());
    repo.upsert(category, limit);
    setState(() => _limits = repo.getAll());
  }

  @override
  Widget build(BuildContext context) {
    final variances = ComputeBudgetVariance.call(widget.transactions, _limits);
    return BudgetVarianceView(variances: variances, onSetLimit: _setLimit);
  }
}
