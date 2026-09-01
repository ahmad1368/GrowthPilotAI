import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_matrix_header_cell.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

/// "Desktop/Web Layout: sticky headers & columns, interactive checkbox
/// intersections, red/orange gap highlighting" (Issue #239).
class TraceabilityMatrixGrid extends StatelessWidget {
  final TraceabilityController controller;

  const TraceabilityMatrixGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final goals = controller.goalList;
      final requirements = controller.requirementList;
      if (goals.isEmpty || requirements.isEmpty) {
        return const Text('Add at least one goal and one requirement to see the matrix.');
      }
      return SizedBox(
        height: 400,
        child: TableView.builder(
          pinnedRowCount: 1,
          pinnedColumnCount: 1,
          columnCount: goals.length + 1,
          rowCount: requirements.length + 1,
          columnBuilder: (i) => TableSpan(extent: FixedTableSpanExtent(i == 0 ? 220 : 120)),
          rowBuilder: (_) => const TableSpan(extent: FixedTableSpanExtent(44)),
          cellBuilder: (context, vicinity) => TableViewCell(child: _cellFor(vicinity, goals, requirements)),
        ),
      );
    });
  }

  Widget _cellFor(TableVicinity vicinity, List goals, List requirements) {
    if (vicinity.row == 0 && vicinity.column == 0) return const SizedBox.shrink();
    if (vicinity.row == 0) {
      final goal = goals[vicinity.column - 1];
      return TraceabilityMatrixHeaderCell(
        label: goal.title,
        gapColor: controller.goalIdsWithoutRequirements.contains(goal.id) ? Colors.orange : null,
      );
    }
    if (vicinity.column == 0) {
      final requirement = requirements[vicinity.row - 1];
      return TraceabilityMatrixHeaderCell(
        label: '${requirement.reqCode} ${requirement.description}',
        gapColor: controller.requirementIdsWithoutGoal.contains(requirement.id) ? Colors.red : null,
      );
    }
    final goal = goals[vicinity.column - 1];
    final requirement = requirements[vicinity.row - 1];
    return Checkbox(
      value: controller.isLinked(goal.id, requirement.id),
      onChanged: (_) => controller.toggleLink(goal.id, requirement.id),
    );
  }
}
