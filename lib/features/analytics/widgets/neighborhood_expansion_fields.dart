import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The neighborhood/demand-gap/competitor-count/cost fields plus
/// evaluated-date picker for a new expansion evaluation (Issue #372).
class NeighborhoodExpansionFields extends StatelessWidget {
  final TextEditingController neighborhoodController;
  final TextEditingController demandGapController;
  final TextEditingController competitorCountController;
  final TextEditingController costController;
  final DateTime? evaluatedAt;
  final VoidCallback onPickDate;

  const NeighborhoodExpansionFields({
    super.key,
    required this.neighborhoodController,
    required this.demandGapController,
    required this.competitorCountController,
    required this.costController,
    required this.evaluatedAt,
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
            placeholder: const Text('Neighborhood name'),
            controller: neighborhoodController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Estimated demand gap (\$/mo)'),
            controller: demandGapController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Existing competitor count'),
            controller: competitorCountController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Estimated expansion cost (\$)'),
            controller: costController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickDate,
          child: Text(_label(evaluatedAt, 'Pick evaluated date'),
              style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
