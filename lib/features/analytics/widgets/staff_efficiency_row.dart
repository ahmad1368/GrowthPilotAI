import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/staff_efficiency.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One shift's efficiency row: transactions handled, avg ticket size,
/// and throughput per hour (Issue #379).
class StaffEfficiencyRow extends StatelessWidget {
  final StaffEfficiency result;

  const StaffEfficiencyRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(result.staffName, overflow: TextOverflow.ellipsis)),
          Text('${result.transactionCount} txns',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(result.avgTicketSize),
              style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 8),
          Text(
            '${result.transactionsPerHour.toStringAsFixed(1)}/hr',
            style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary),
          ),
        ],
      ),
    );
  }
}
