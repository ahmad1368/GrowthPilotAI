import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/orphan_warning_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The "Traceability Navigator"'s goal list (Issue #238) — tap a goal
/// to see its linked requirements; delete triggers the orphan check.
class TraceabilityGoalList extends StatelessWidget {
  final TraceabilityController controller;
  final int? selectedGoalId;
  final ValueChanged<int> onSelect;

  const TraceabilityGoalList({
    super.key,
    required this.controller,
    required this.selectedGoalId,
    required this.onSelect,
  });

  Future<void> _delete(BuildContext context, int goalId) async {
    final orphaned = controller.requirementsOrphanedByDeleting(goalId);
    if (orphaned.isNotEmpty) {
      final requirements = controller.requirementList.where((r) => orphaned.contains(r.id)).toList();
      final confirmed = await showDialog<bool>(
          context: context, builder: (_) => OrphanWarningDialog(orphaned: requirements));
      if (confirmed != true) return;
    }
    controller.deleteGoal(goalId);
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      if (controller.goalList.isEmpty) {
        return Text('No business goals yet.', style: TextStyle(color: colors.mutedForeground, fontSize: 12));
      }
      return Column(
        children: [
          for (final goal in controller.goalList)
            ListTile(
              title: Text(goal.title, style: TextStyle(color: colors.foreground)),
              selected: goal.id == selectedGoalId,
              onTap: () => onSelect(goal.id),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _delete(context, goal.id),
              ),
            ),
        ],
      );
    });
  }
}
