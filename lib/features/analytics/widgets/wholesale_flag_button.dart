import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Flag-next-surplus-item action (Issue #411, acceptance criterion 1)
/// — split out of [WholesaleView] to stay under the file line cap.
class WholesaleFlagButton extends StatelessWidget {
  final VoidCallback onPressed;

  const WholesaleFlagButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Align(
      alignment: Alignment.centerRight,
      child: ShadButton.outline(
        onPressed: onPressed,
        child: Text('+ List Next Surplus Item', style: TextStyle(color: fg)),
      ),
    );
  }
}
