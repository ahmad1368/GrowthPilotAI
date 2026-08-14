import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_csat_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/csat_rating_entity.dart';
import 'package:growth_pilot_ai/core/models/csat_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/csat_rating_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the CSAT narrative, a quick-add button, and per-rating rows
/// (Issue #375). Purely presentational — the rating list is owned by
/// [CsatSummaryBody].
class CsatSummaryView extends StatelessWidget {
  final CsatSummary summary;
  final List<CsatRatingEntity> ratings;
  final VoidCallback onAddRating;

  const CsatSummaryView({
    super.key,
    required this.summary,
    required this.ratings,
    required this.onAddRating,
  });

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
              onPressed: onAddRating,
              child: Text('+ Log Rating', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final rating in ratings) CsatRatingRow(rating: rating),
        const SizedBox(height: 8),
        Text(BuildCsatNarrative.call(summary)),
      ],
    );
  }
}
