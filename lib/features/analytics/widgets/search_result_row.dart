import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/search_result_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One search result row (Issue #404, acceptance criterion 2) — a
/// distinct, unmistakable "Sponsored" tag marks promoted slots so
/// users can tell them apart from organic matches.
class SearchResultRow extends StatelessWidget {
  final SearchResultItem result;
  final VoidCallback onTap;

  const SearchResultRow({super.key, required this.result, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            if (result.isSponsored) ...[
              const ShadBadge.outline(child: Text('Sponsored')),
              const SizedBox(width: 8),
            ],
            Expanded(child: Text(result.name, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}
