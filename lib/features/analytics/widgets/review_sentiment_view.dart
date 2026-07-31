import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_review_sentiment_narrative.dart';
import 'package:growth_pilot_ai/core/models/review_sentiment_result.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/review_sentiment_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-review sentiment rows, a quick-add button, and a summary
/// narrative (Issue #358). Purely presentational — the review list is
/// owned by [ReviewFeedbackBody].
class ReviewSentimentView extends StatelessWidget {
  final List<ReviewSentimentResult> results;
  final VoidCallback onAddReview;

  const ReviewSentimentView(
      {super.key, required this.results, required this.onAddReview});

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
              onPressed: onAddReview,
              child: Text('+ Log Review', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) ReviewSentimentRow(result: result),
        const SizedBox(height: 8),
        Text(BuildReviewSentimentNarrative.call(results)),
      ],
    );
  }
}
