import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/dashboard_template.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One archetype card in the Template Store gallery (Issue #118). Flat
/// [ShadCard], not the issue's literal Glassmorphism/Hero-morph ask.
class DashboardTemplateCard extends StatelessWidget {
  final DashboardTemplate template;
  final bool isApplied;
  final VoidCallback onTap;

  const DashboardTemplateCard({
    super.key,
    required this.template,
    required this.isApplied,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return SizedBox(
      width: 200,
      child: GestureDetector(
        onTap: onTap,
        child: ShadCard(
          border: isApplied ? ShadBorder.all(color: primary, width: 1.5) : null,
          title: Text(template.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          description: Text(template.description,
              maxLines: 2, overflow: TextOverflow.ellipsis),
          footer: isApplied ? Text('Applied', style: TextStyle(color: primary)) : null,
        ),
      ),
    );
  }
}
