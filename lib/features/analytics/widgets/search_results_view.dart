import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/search_result_item.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/search_result_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the search field and ranked result rows (Issue #404) —
/// purely presentational, query state and telemetry are owned by
/// [SearchResultsBody].
class SearchResultsView extends StatelessWidget {
  final List<SearchResultItem> results;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<SearchResultItem> onResultTap;

  const SearchResultsView({
    super.key,
    required this.results,
    required this.onQueryChanged,
    required this.onResultTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Search products, services, or local businesses'),
            onChanged: onQueryChanged),
        const SizedBox(height: 8),
        for (final result in results)
          SearchResultRow(result: result, onTap: () => onResultTap(result)),
      ],
    );
  }
}
