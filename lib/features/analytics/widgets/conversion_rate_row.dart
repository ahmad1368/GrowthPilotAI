import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/conversion_rate.dart';

/// One logged day's visitor-to-buyer conversion row (Issue #387).
class ConversionRateRow extends StatelessWidget {
  final ConversionRate result;

  const ConversionRateRow({super.key, required this.result});

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
          Expanded(child: Text(_date(result.date))),
          Text('${result.transactionCount}/${result.visitorCount}',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(
            '${result.conversionPercent.toStringAsFixed(1)}%',
            style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary),
          ),
        ],
      ),
    );
  }
}
