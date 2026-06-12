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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor =
        isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(icon, color: activeColor, size: 22),
      title: Text(
        label,
        style: ShadTheme.of(context).textTheme.p.copyWith(
              color: activeColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
      ),
    );
  }
}
