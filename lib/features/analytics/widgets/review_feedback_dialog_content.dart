import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/review_feedback_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/review_feedback_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showReviewFeedbackDialog] (Issue #358): owns
/// the text controller, selected domain, and picked submitted date.
class ReviewFeedbackDialogContent extends StatefulWidget {
  const ReviewFeedbackDialogContent({super.key});

  @override
  State<ReviewFeedbackDialogContent> createState() =>
      _ReviewFeedbackDialogContentState();
}

class _ReviewFeedbackDialogContentState
    extends State<ReviewFeedbackDialogContent> {
  final _reviewTextController = TextEditingController();
  FeedbackDomain _domain = FeedbackDomain.productQuality;
  DateTime? _submittedAt;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _submittedAt ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _submittedAt = picked);
  }

  void _submit() {
    if (_reviewTextController.text.trim().isEmpty || _submittedAt == null) {
      return;
    }
    Navigator.of(context).pop(ReviewFeedbackEntity(
      reviewText: _reviewTextController.text.trim(),
      submittedAt: _submittedAt!,
    )..domain = _domain);
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Customer Review'),
      description: ReviewFeedbackFields(
        reviewTextController: _reviewTextController,
        domain: _domain,
        onDomainChanged: (d) => setState(() => _domain = d),
        submittedAt: _submittedAt,
        onPickDate: _pickDate,
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
