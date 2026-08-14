import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/branch_performance_summary.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One logged branch's drill-down supervisory row (Issue #400).
class MerchantBranchRow extends StatelessWidget {
  final BranchPerformanceSummary result;

  const MerchantBranchRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(result.branchName, overflow: TextOverflow.ellipsis)),
          Text(result.inventoryStatus.name,
              style: TextStyle(
                  fontSize: 11,
                  color: result.needsAttention
                      ? scheme.error
                      : scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(
            '${CurrencyFormat.cad(result.salesTotal)} (${result.salesSharePercent.toStringAsFixed(1)}%)',
            style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary),
          ),
        ],
      ),
    );
  }
}
