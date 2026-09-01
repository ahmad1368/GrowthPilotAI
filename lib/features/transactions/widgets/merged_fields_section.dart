import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/merged_transaction_view.dart';
import 'package:growth_pilot_ai/features/transactions/widgets/merged_provider_badge.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Merge-strategy fields shown on the Transaction Details screen (Issue
/// #69) once a record is matched: badge, bank-sourced posted date, and
/// accounting-sourced category/tax, plus the "Split" action.
class MergedFieldsSection extends StatelessWidget {
  final MergedTransactionView view;
  final VoidCallback onSplit;

  const MergedFieldsSection({super.key, required this.view, required this.onSplit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MergedProviderBadge(originSources: view.originSources),
        const SizedBox(height: 16),
        Text('Posted: ${view.postedDate.toString().split(' ').first}'),
        Text('Category: ${view.category.name}'),
        Text('Tax total: \$${view.tax.total.toStringAsFixed(2)}'),
        const SizedBox(height: 24),
        ShadButton.destructive(onPressed: onSplit, child: const Text('Split')),
      ],
    );
  }
}
