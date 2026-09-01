import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/format_waste_reason.dart';
import 'package:growth_pilot_ai/core/models/waste_reason_breakdown.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One ranked reason row in the waste breakdown (Issue #377): a bar sized
/// relative to [maxValue].
class WasteReasonRow extends StatelessWidget {
  final WasteReasonBreakdown item;
  final double maxValue;

  const WasteReasonRow({super.key, required this.item, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fraction = maxValue <= 0 ? 0.0 : (item.totalValue / maxValue).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                    '${FormatWasteReason.call(item.reason)} (${item.entryCount})',
                    overflow: TextOverflow.ellipsis),
              ),
              Text(
                CurrencyFormat.cad(item.totalValue),
                style: TextStyle(color: scheme.error, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 6,
              backgroundColor: scheme.onSurface.withValues(alpha: 0.08),
              color: scheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
