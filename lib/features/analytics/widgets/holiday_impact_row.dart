import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/holiday_sales_impact.dart';

/// One holiday's revenue-lift row (Issue #388): trending icon + lift%,
/// colored primary for a positive lift, error for a decline.
class HolidayImpactRow extends StatelessWidget {
  final HolidaySalesImpact item;

  const HolidayImpactRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isLift = item.liftPercent >= 0;
    final color = isLift ? scheme.primary : scheme.error;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(isLift ? Icons.trending_up : Icons.trending_down, size: 14, color: color),
                const SizedBox(width: 4),
                Flexible(child: Text(item.holidayName, overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          Text(
            '${isLift ? '+' : ''}${item.liftPercent.toStringAsFixed(0)}%',
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
