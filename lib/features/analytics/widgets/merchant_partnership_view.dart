import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_merchant_partnership_narrative.dart';
import 'package:growth_pilot_ai/core/models/merchant_partnership_value.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_partnership_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-partnership collaborative-value rows, a quick-add button,
/// and a summary narrative (Issue #393). Purely presentational — the
/// partnership list is owned by [MerchantPartnershipBody].
class MerchantPartnershipView extends StatelessWidget {
  final List<MerchantPartnershipValue> results;
  final VoidCallback onAddPartnership;

  const MerchantPartnershipView(
      {super.key, required this.results, required this.onAddPartnership});

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
              onPressed: onAddPartnership,
              child: Text('+ Log Partnership', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) MerchantPartnershipRow(result: result),
        const SizedBox(height: 8),
        Text(BuildMerchantPartnershipNarrative.call(results)),
      ],
    );
  }
}
