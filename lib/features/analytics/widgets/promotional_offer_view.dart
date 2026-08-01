import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_promotional_offer_narrative.dart';
import 'package:growth_pilot_ai/core/models/promotional_offer_performance.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/promotional_offer_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-offer engagement rows, a quick-add button, and a summary
/// narrative (Issue #335). Purely presentational — the offer list is
/// owned by [PromotionalOfferBody].
class PromotionalOfferView extends StatelessWidget {
  final List<PromotionalOfferPerformance> results;
  final VoidCallback onAddOffer;

  const PromotionalOfferView(
      {super.key, required this.results, required this.onAddOffer});

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onAddOffer,
              child: Text('+ Log Offer', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) PromotionalOfferRow(result: result),
        const SizedBox(height: 8),
        Text(BuildPromotionalOfferNarrative.call(results)),
      ],
    );
  }
}
