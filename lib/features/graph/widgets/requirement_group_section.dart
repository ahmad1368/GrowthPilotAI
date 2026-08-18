import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One labeled group's requirement descriptions (Issue #229's
/// "Categorized Views").
class RequirementGroupSection extends StatelessWidget {
  final String label;
  final List<ExtractedRequirement> requirements;

  const RequirementGroupSection({super.key, required this.label, required this.requirements});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label (${requirements.length})',
              style: TextStyle(color: colors.foreground, fontSize: 13, fontWeight: FontWeight.w600)),
          for (final requirement in requirements)
            Text('• ${requirement.description}',
                style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
        ],
      ),
    );
  }
}
