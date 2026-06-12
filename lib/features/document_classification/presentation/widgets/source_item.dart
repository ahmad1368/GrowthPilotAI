import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SourceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SourceItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return ListTile(
      leading: Icon(icon, color: fgColor, size: 24),
      title: Text(
        label,
        style: theme.textTheme.p.copyWith(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
