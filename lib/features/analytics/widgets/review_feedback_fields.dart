import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/review_feedback_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The review-text field, domain selector, and submitted-date picker for
/// a new logged review (Issue #358).
class ReviewFeedbackFields extends StatelessWidget {
  final TextEditingController reviewTextController;
  final FeedbackDomain domain;
  final ValueChanged<FeedbackDomain> onDomainChanged;
  final DateTime? submittedAt;
  final VoidCallback onPickDate;

  const ReviewFeedbackFields({
    super.key,
    required this.reviewTextController,
    required this.domain,
    required this.onDomainChanged,
    required this.submittedAt,
    required this.onPickDate,
  });

  String _label(DateTime? d, String placeholder) => d == null
      ? placeholder
      : '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Review text'),
            controller: reviewTextController,
            maxLines: 3),
        const SizedBox(height: 8),
        ShadSelect<FeedbackDomain>(
          initialValue: domain,
          options: FeedbackDomain.values
              .map((d) => ShadOption(value: d, child: Text(d.name)))
              .toList(),
          selectedOptionBuilder: (context, value) => Text(value.name),
          onChanged: (FeedbackDomain? value) {
            if (value != null) onDomainChanged(value);
          },
        ),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickDate,
          child: Text(_label(submittedAt, 'Pick submitted date'),
              style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
