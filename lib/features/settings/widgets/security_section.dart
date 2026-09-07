import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_nav_tile.dart';

/// [Issue #808] Local-encryption status + 2FA entry point,
/// Settings > Account & Security.
class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(children: [
      Material(
        color: isDark ? const Color(0xFF18181B) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: isDark ? 0 : 1,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Icon(Icons.security_rounded, color: theme.colorScheme.onSurface),
          title: Text("Local Encryption", style: TextStyle(color: theme.colorScheme.onSurface)),
          subtitle: Text("AES-256 Protection Active",
              style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
          trailing: Icon(Icons.verified_user_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6), size: 20),
        ),
      ),
      const SizedBox(height: 12),
      SettingsNavTile(
        icon: Icons.phonelink_lock_rounded,
        title: 'Two-Factor Authentication',
        subtitle: 'Protect your account with an authenticator app',
        onTap: () => Get.toNamed('/settings/2fa'),
      ),
    ]);
  }
}
