import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_heatmap_optimization_narrative.dart';
import 'package:growth_pilot_ai/business/compute_traffic_heatmap.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/traffic_day_part.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_heatmap_day_part_chips.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_heatmap_grid.dart';

/// Body of the Store Traffic Heatmap widget (Issue #354): a day-part
/// filter narrows which band of [TrafficHeatmapGrid] is highlighted.
class TrafficHeatmapBody extends StatefulWidget {
  final List<TransactionEntity> transactions;

  const TrafficHeatmapBody({super.key, required this.transactions});

  @override
  State<TrafficHeatmapBody> createState() => _TrafficHeatmapBodyState();
}

class _TrafficHeatmapBodyState extends State<TrafficHeatmapBody> {
  TrafficDayPart? _dayPartFilter;

  @override
  Widget build(BuildContext context) {
    final cells = ComputeTrafficHeatmap.call(widget.transactions);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrafficHeatmapDayPartChips(
          selected: _dayPartFilter,
          onChanged: (p) => setState(() => _dayPartFilter = p),
        ),
        const SizedBox(height: 12),
        TrafficHeatmapGrid(cells: cells, dayPartFilter: _dayPartFilter),
        const SizedBox(height: 8),
        Text(BuildHeatmapOptimizationNarrative.call(cells)),
      ],
    );
  }
}
