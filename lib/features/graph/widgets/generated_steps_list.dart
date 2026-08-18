import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/positioned_process_node.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The generated diagram's steps as a flat list (Issue #224) — a
/// simplified stand-in for the issue's "Ghost/Skeleton" streaming
/// canvas preview and its CustomPainter mobile-rendering plan (see PR
/// notes: no full graph canvas is wired up for this general
/// [PositionedProcessNode] shape yet).
class GeneratedStepsList extends StatelessWidget {
  final List<PositionedProcessNode> positions;

  const GeneratedStepsList({super.key, required this.positions});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final p in positions)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text('${p.node.label}  (${p.x.toInt()}, ${p.y.toInt()})',
                style: TextStyle(color: colors.foreground, fontSize: 13)),
          ),
      ],
    );
  }
}
