import 'package:flutter/material.dart';

/// Generic Settings menu entry (used by Issue #68's Connected Accounts and
/// Issue #69's Duplicate Matches). Flat card styling only — no
/// glassmorphism/BackdropFilter, per the fixed palette: dark card #18181b,
/// light card white + soft shadow.
class SettingsNavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsNavTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final foreground = theme.colorScheme.onSurface;

    return Material(
      color: isDark ? const Color(0xFF18181B) : Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: isDark ? 0 : 1,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Icon(icon, color: foreground),
          title: Text(title, style: TextStyle(color: foreground)),
          subtitle: Text(subtitle,
              style: TextStyle(fontSize: 12, color: foreground.withValues(alpha: 0.6))),
          trailing: Icon(Icons.chevron_right_rounded,
              color: foreground.withValues(alpha: 0.3)),
        ),
      ),
    );
  }
}
