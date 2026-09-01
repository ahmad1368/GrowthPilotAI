import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/channel_attribution_summary.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One channel's aggregated attribution row (Issue #395).
class ChannelAttributionRow extends StatelessWidget {
  final ChannelAttributionSummary result;

  const ChannelAttributionRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(result.channel.name, overflow: TextOverflow.ellipsis)),
          Text('${result.campaignCount} campaigns',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(result.totalAttributedRevenue),
              style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 8),
          Text(
            '${(result.roi * 100).toStringAsFixed(0)}%',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: result.isPositiveRoi ? scheme.primary : scheme.error),
          ),
        ],
      ),
    );
  }
}
