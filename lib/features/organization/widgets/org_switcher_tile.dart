import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One selectable row in [OrgSwitcherPanel], split out to keep the panel
/// under the file's SRP line budget.
class OrgSwitcherTile extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const OrgSwitcherTile({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ShadButton.outline(
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? colors.primary : colors.foreground,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
