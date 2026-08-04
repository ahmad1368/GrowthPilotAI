import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_merchant_tag_narrative.dart';
import 'package:growth_pilot_ai/core/models/merchant_tag_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_tag_filter_field.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_tag_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the tag filter, bulk-tag button, filtered merchant rows, and
/// a summary narrative (Issue #342). Purely presentational — the
/// merchant/tag data and filter state are owned by [MerchantTagBody].
class MerchantTagView extends StatelessWidget {
  final List<MerchantTagSummary> filteredResults;
  final List<MerchantTagSummary> allResults;
  final ValueChanged<String> onFilterChanged;
  final VoidCallback onBulkTag;

  const MerchantTagView({
    super.key,
    required this.filteredResults,
    required this.allResults,
    required this.onFilterChanged,
    required this.onBulkTag,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: MerchantTagFilterField(onChanged: onFilterChanged)),
            const SizedBox(width: 8),
            ShadButton.outline(
              onPressed: onBulkTag,
              child: Text('+ Bulk Tag', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in filteredResults) MerchantTagRow(result: result),
        const SizedBox(height: 8),
        Text(BuildMerchantTagNarrative.call(allResults)),
      ],
    );
  }
}
