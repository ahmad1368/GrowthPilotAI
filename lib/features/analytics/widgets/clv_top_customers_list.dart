import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/customer_lifetime_value.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// The highest-projected-CLV buyers, capped at [maxRows] (Issue #394).
class ClvTopCustomersList extends StatelessWidget {
  static const maxRows = 5;

  final List<CustomerLifetimeValue> clvs;

  const ClvTopCustomersList({super.key, required this.clvs});

  @override
  Widget build(BuildContext context) {
    if (clvs.isEmpty) return const Text('No income history yet.');
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final clv in clvs.take(maxRows))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(clv.label, overflow: TextOverflow.ellipsis)),
                Text(clv.cohort.label,
                    style: TextStyle(
                        fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
                const SizedBox(width: 12),
                Text(CurrencyFormat.cad(clv.lifetimeValue)),
              ],
            ),
          ),
      ],
    );
  }
}
