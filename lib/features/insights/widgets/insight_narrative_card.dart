import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/insight_narrative.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Insight Narrative" text box (Issue #101) — a flat card with a
/// colored left border, not the issue's literal frosted-glass/typewriter
/// treatment (architecture forbids Glassmorphism/BackdropFilter).
class InsightNarrativeCard extends StatelessWidget {
  final InsightNarrative narrative;

  const InsightNarrativeCard({super.key, required this.narrative});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border(left: BorderSide(color: colors.primary, width: 4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('"${narrative.text}"',
          style: TextStyle(
              color: colors.foreground, fontSize: 13, fontStyle: FontStyle.italic)),
    );
  }
}
