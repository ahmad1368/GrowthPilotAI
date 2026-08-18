import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_confidence_bar.dart';

/// Batch-select checkbox + [RequirementConfidenceBar] row atop each
/// triage card (Issue #231).
class RequirementCardHeader extends StatelessWidget {
  final bool isBatchSelected;
  final ValueChanged<bool?> onBatchToggle;
  final double confidence;

  const RequirementCardHeader({
    super.key,
    required this.isBatchSelected,
    required this.onBatchToggle,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: isBatchSelected, onChanged: onBatchToggle),
        const Spacer(),
        RequirementConfidenceBar(confidence: confidence),
      ],
    );
  }
}
