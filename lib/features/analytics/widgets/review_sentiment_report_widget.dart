import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/review_feedback_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/review_feedback_body.dart';

/// Registers the Market Feedback & User Review Sentiment Analysis
/// (Issue #358) as a pluggable report widget under id
/// `REVIEW_SENTIMENT_ANALYSIS` (#111).
class ReviewSentimentReportWidget extends BaseReportWidget {
  const ReviewSentimentReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return ReviewFeedbackBody(
      initialReviews: data['reviews'] as List<ReviewFeedbackEntity>,
    );
  }
}
