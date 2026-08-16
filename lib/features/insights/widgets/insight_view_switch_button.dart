import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/insight_visual_hint.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Switch View" control (Issue #261's Manual Toggle AC) — cycles the
/// active [InsightVisualHint].
class InsightViewSwitchButton extends StatelessWidget {
  final VoidCallback onTap;

  const InsightViewSwitchButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return IconButton(
      icon: Icon(Icons.swap_horiz, color: colors.mutedForeground, size: 18),
      tooltip: 'Switch view',
      onPressed: onTap,
    );
  }
}
