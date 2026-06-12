import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SettingsCardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget trailing;

  const SettingsCardItem(
      {super.key,
      required this.icon,
      required this.title,
      this.subtitle,
      required this.trailing});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      content: Row(
        children: [
          Icon(icon, color: isDark ? Colors.white : Colors.black, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: theme.textTheme.p
                        .copyWith(fontWeight: FontWeight.bold)),
                if (subtitle != null)
                  Text(subtitle!,
                      style: theme.textTheme.muted.copyWith(fontSize: 12)),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
