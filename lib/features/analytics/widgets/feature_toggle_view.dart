import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_feature_module_toggle_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/feature_toggle_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-module toggle rows, an add button, and a summary
/// narrative (Issue #339). Purely presentational — the module list is
/// owned by [FeatureToggleBody].
class FeatureToggleView extends StatelessWidget {
  final List<FeatureModuleToggleEntity> results;
  final VoidCallback onAddModule;
  final ValueChanged<FeatureModuleToggleEntity> onEditModule;

  const FeatureToggleView({
    super.key,
    required this.results,
    required this.onAddModule,
    required this.onEditModule,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onAddModule,
              child: Text('+ Add Module', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final toggle in results)
          FeatureToggleRow(toggle: toggle, onTap: () => onEditModule(toggle)),
        const SizedBox(height: 8),
        Text(BuildFeatureModuleToggleNarrative.call(results)),
      ],
    );
  }
}
