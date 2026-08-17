import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One rendered node's content in [StaticGraphViewer] (Issue #219) —
/// flat card, no Glassmorphism/BackdropFilter.
class RequirementNodeWidget extends StatelessWidget {
  final String label;

  const RequirementNodeWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.border),
      ),
      child: Text(label, style: TextStyle(color: colors.foreground, fontSize: 12)),
    );
  }
}
