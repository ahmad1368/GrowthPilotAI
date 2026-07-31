import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_channel_sales_narrative.dart';
import 'package:growth_pilot_ai/business/compute_channel_sales_comparison.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/channel_sales_comparison_bar.dart';

/// Body of the Online vs In-Store Sales Performance widget (Issue #384).
class ChannelSalesBody extends StatelessWidget {
  final List<StockMovementEntity> movements;
  final List<InventoryItemEntity> items;

  const ChannelSalesBody({super.key, required this.movements, required this.items});

  @override
  Widget build(BuildContext context) {
    final snapshots = ComputeChannelSalesComparison.call(movements, items);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChannelSalesComparisonBar(snapshots: snapshots),
        const SizedBox(height: 8),
        Text(BuildChannelSalesNarrative.call(snapshots)),
      ],
    );
  }
}
