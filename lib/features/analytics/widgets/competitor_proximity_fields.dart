import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_sighting_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The competitor/category/distance/scale fields plus spotted-date picker
/// for a new competitor sighting (Issue #374).
class CompetitorProximityFields extends StatelessWidget {
  final TextEditingController competitorController;
  final TextEditingController categoryController;
  final TextEditingController distanceController;
  final CompetitorScale scale;
  final ValueChanged<CompetitorScale> onScaleChanged;
  final DateTime? spottedAt;
  final VoidCallback onPickDate;

  const CompetitorProximityFields({
    super.key,
    required this.competitorController,
    required this.categoryController,
    required this.distanceController,
    required this.scale,
    required this.onScaleChanged,
    required this.spottedAt,
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
            placeholder: const Text('Competitor name'),
            controller: competitorController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Category'), controller: categoryController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Distance (km)'),
            controller: distanceController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadSelect<CompetitorScale>(
          initialValue: scale,
          options: CompetitorScale.values
              .map((s) => ShadOption(value: s, child: Text(s.name)))
              .toList(),
          selectedOptionBuilder: (context, value) => Text(value.name),
          onChanged: (CompetitorScale? value) {
            if (value != null) onScaleChanged(value);
          },
        ),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickDate,
          child: Text(_label(spottedAt, 'Pick spotted date'),
              style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
