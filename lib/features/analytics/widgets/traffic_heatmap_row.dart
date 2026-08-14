import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/traffic_day_part.dart';
import 'package:growth_pilot_ai/core/models/traffic_heatmap_cell.dart';

/// One day-of-week row of color-coded day-part cells (Issue #354). Cells
/// outside the active [dayPartFilter] (if any) are dimmed.
class TrafficHeatmapRow extends StatelessWidget {
  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  final List<TrafficHeatmapCell> cells;
  final TrafficDayPart? dayPartFilter;

  const TrafficHeatmapRow(
      {super.key, required this.cells, required this.dayPartFilter});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 32, child: Text(_days[cells.first.dayOfWeek])),
          for (final cell in cells)
            Expanded(
              child: Opacity(
                opacity: dayPartFilter == null || dayPartFilter == cell.dayPart
                    ? 1
                    : 0.3,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: scheme.primary
                        .withValues(alpha: 0.08 + cell.intensity * 0.72),
                    borderRadius: BorderRadius.circular(4),
                    border: cell.isPeak
                        ? Border.all(color: scheme.primary, width: 1.5)
                        : null,
                  ),
                  child: Text('${cell.count}',
                      style: TextStyle(
                          fontSize: 11,
                          color: cell.intensity > 0.5
                              ? scheme.onPrimary
                              : scheme.onSurface)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
