import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/traffic_day_part.dart';
import 'package:growth_pilot_ai/core/models/traffic_heatmap_cell.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_heatmap_row.dart';

/// Full 7-day x 4-day-part color-coded heatmap grid (Issue #354).
class TrafficHeatmapGrid extends StatelessWidget {
  final List<TrafficHeatmapCell> cells;
  final TrafficDayPart? dayPartFilter;

  const TrafficHeatmapGrid(
      {super.key, required this.cells, required this.dayPartFilter});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 32),
            for (final part in TrafficDayPart.values)
              Expanded(
                child: Text(part.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 11,
                        color: scheme.onSurface.withValues(alpha: 0.6))),
              ),
          ],
        ),
        for (var day = 0; day < 7; day++)
          TrafficHeatmapRow(
            cells: cells.where((c) => c.dayOfWeek == day).toList(),
            dayPartFilter: dayPartFilter,
          ),
      ],
    );
  }
}
