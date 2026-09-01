import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/action_impact_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Flat status pill for one roadmap item (Issue #260) — not the issue's
/// literal glassmorphism styling (architecture forbids Glassmorphism/
/// BackdropFilter).
class ActionImpactStatusChip extends StatelessWidget {
  final ActionImpactStatus status;

  const ActionImpactStatusChip({super.key, required this.status});

  String get _label => switch (status) {
        ActionImpactStatus.todo => 'To Do',
        ActionImpactStatus.doing => 'Doing',
        ActionImpactStatus.done => 'Done',
      };

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final accent = status == ActionImpactStatus.done ? Colors.green : colors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(_label, style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}
