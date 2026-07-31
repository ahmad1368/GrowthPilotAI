import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/channel_sales_snapshot.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// Side-by-side In-store vs Online estimated-revenue bars (Issue #384).
class ChannelSalesComparisonBar extends StatelessWidget {
  final List<ChannelSalesSnapshot> snapshots;

  const ChannelSalesComparisonBar({super.key, required this.snapshots});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxRevenue = snapshots
        .map((s) => s.estimatedRevenue)
        .fold<double>(0, (a, b) => a > b ? a : b);

    Widget bar(ChannelSalesSnapshot s) {
      final label = s.channel == SalesChannel.pos ? 'In-store' : 'Online';
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$label (${s.unitsSold} units)',
                style: const TextStyle(fontSize: 11)),
            const SizedBox(height: 4),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: maxRevenue <= 0
                  ? 0
                  : (s.estimatedRevenue / maxRevenue).clamp(0.0, 1.0),
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                    color: scheme.primary, borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(height: 2),
            Text(CurrencyFormat.cad(s.estimatedRevenue),
                style: const TextStyle(fontSize: 11)),
          ],
        ),
      );
    }

    return Row(
      children: [
        for (var i = 0; i < snapshots.length; i++) ...[
          if (i > 0) const SizedBox(width: 16),
          bar(snapshots[i]),
        ],
      ],
    );
  }
}
