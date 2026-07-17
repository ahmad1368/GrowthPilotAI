import 'package:flutter/material.dart';

/// Settings menu entry that navigates to the Connected Accounts screen
/// (Issue #68). Flat card styling only — no glassmorphism/BackdropFilter,
/// per the fixed palette: dark card #18181b, light card white + soft shadow.
class ConnectedAccountsNavTile extends StatelessWidget {
  final VoidCallback onTap;

  const ConnectedAccountsNavTile({super.key, required this.onTap});

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
          leading: Icon(Icons.account_balance_wallet_rounded,
              color: foreground),
          title: Text('Connected Accounts',
              style: TextStyle(color: foreground)),
          subtitle: Text('Manage linked bank sub-accounts',
              style:
                  TextStyle(fontSize: 12, color: foreground.withValues(alpha: 0.6))),
          trailing: Icon(Icons.chevron_right_rounded,
              color: foreground.withValues(alpha: 0.3)),
        ),
      ),
    );
  }
}
