import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_review_sentiment.dart';
import 'package:growth_pilot_ai/core/data/entities/review_feedback_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/review_feedback_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/review_feedback_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/review_sentiment_view.dart';

/// Owns the logged-review list (Issue #358), refreshing it locally after
/// each quick-add insert — mirrors [CompetitorPriceBody]'s pattern.
class ReviewFeedbackBody extends StatefulWidget {
  final List<ReviewFeedbackEntity> initialReviews;

  const ReviewFeedbackBody({super.key, required this.initialReviews});

  @override
  State<ReviewFeedbackBody> createState() => _ReviewFeedbackBodyState();
}

class _ReviewFeedbackBodyState extends State<ReviewFeedbackBody> {
  late List<ReviewFeedbackEntity> _reviews = widget.initialReviews;

  Future<void> _addReview() async {
    final review = await showReviewFeedbackDialog(context);
    if (review == null) return;
    ReviewFeedbackRepository(Get.find<ObjectBox>().store.box<ReviewFeedbackEntity>())
        .insert(review);
    setState(() => _reviews = [..._reviews, review]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeReviewSentiment.call(_reviews);
    return ReviewSentimentView(results: results, onAddReview: _addReview);
  }
}
