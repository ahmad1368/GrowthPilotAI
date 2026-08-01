import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/daily_traffic_analytics.dart';

/// One logged day's foot/vehicular traffic analytics row (Issue #381).
class TrafficAnalyticsRow extends StatelessWidget {
  final DailyTrafficAnalytics result;

  const TrafficAnalyticsRow({super.key, required this.result});

  String _date(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text('${_date(result.date)} (${result.weekdayLabel})')),
          Text('${result.footTraffic} foot / ${result.vehicleTraffic} veh',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text('${result.conversionPercent.toStringAsFixed(1)}%',
              style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary)),
        ],
      ),
    );
  }
}
