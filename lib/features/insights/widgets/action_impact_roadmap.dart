import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/action_impact_item.dart';
import 'package:growth_pilot_ai/features/insights/widgets/action_impact_card.dart';

/// "Dynamic Roadmap (Success Pipeline)" list (Issue #260) — renders
/// tracked recommendations as [ActionImpactCard] rows.
class ActionImpactRoadmap extends StatelessWidget {
  final List<ActionImpactItem> items;

  const ActionImpactRoadmap({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [for (final item in items) ActionImpactCard(item: item)],
    );
  }
}
