import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/review_feedback_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/review_feedback_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a customer review (Issue #358). Returns the
/// new review (not yet persisted) or null if cancelled/invalid.
Future<ReviewFeedbackEntity?> showReviewFeedbackDialog(BuildContext context) {
  return showShadDialog<ReviewFeedbackEntity>(
    context: context,
    builder: (context) => const ReviewFeedbackDialogContent(),
  );
}
