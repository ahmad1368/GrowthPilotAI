import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/academy_video_category.dart';

/// Category filter row (Issue #163 AC: "Search & Filter") — null
/// selection means "All".
class AcademyCategoryChips extends StatelessWidget {
  final AcademyVideoCategory? selected;
  final ValueChanged<AcademyVideoCategory?> onSelected;

  const AcademyCategoryChips({super.key, required this.selected, required this.onSelected});

  String _label(AcademyVideoCategory? category) => switch (category) {
        null => 'All',
        AcademyVideoCategory.tutorial => 'Tutorial',
        AcademyVideoCategory.marketplace => 'Marketplace',
        AcademyVideoCategory.legal => 'Legal',
      };

  @override
  Widget build(BuildContext context) {
    final options = <AcademyVideoCategory?>[null, ...AcademyVideoCategory.values];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final option = options[i];
          return ChoiceChip(
            label: Text(_label(option)),
            selected: selected == option,
            onSelected: (_) => onSelected(option),
          );
        },
      ),
    );
  }
}
