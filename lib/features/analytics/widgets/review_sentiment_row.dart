import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/review_sentiment_result.dart';

/// One logged review's keyword-scored sentiment row (Issue #358).
class ReviewSentimentRow extends StatelessWidget {
  final ReviewSentimentResult result;

  const ReviewSentimentRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(result.reviewText, overflow: TextOverflow.ellipsis)),
          Text(result.domain.name,
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(
            result.sentimentScore.toString(),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: result.isNegative ? scheme.error : scheme.primary),
          ),
        ],
      ),
    );
  }
}
