import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_feedback_reason_label.dart';
import 'package:growth_pilot_ai/core/enum/feedback_reason.dart';

/// Optional reasons shown after a "Thumbs Down" (Issue #209 AC: "tiny
/// optional list of reasons").
class FeedbackReasonChips extends StatelessWidget {
  final ValueChanged<FeedbackReason> onSelected;
  const FeedbackReasonChips({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: FeedbackReason.values
          .map((reason) => ActionChip(
                label: Text(BuildFeedbackReasonLabel.call(reason), style: const TextStyle(fontSize: 10)),
                onPressed: () => onSelected(reason),
              ))
          .toList(),
    );
  }
}
