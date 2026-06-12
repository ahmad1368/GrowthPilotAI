import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/settings/presentation/widgets/settings_card_item.dart';
import 'package:growth_pilot_ai/widgets/theme_toggle.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SettingsSections extends StatelessWidget {
  const SettingsSections({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        Text("APPEARANCE",
            style: theme.textTheme.muted.copyWith(
                fontWeight: FontWeight.w900,
                color: const Color(0xff3b82f6),
                fontSize: 11,
                letterSpacing: 1.2)),
        const SizedBox(height: 12),
        const SettingsCardItem(
          icon: Icons.dark_mode_rounded,
          title: "App Theme",
          subtitle: "Switch between Day and Night",
          trailing: ThemeToggle(),
        ),
        const SizedBox(height: 32),
        Text("ACCOUNT",
            style: theme.textTheme.muted.copyWith(
                fontWeight: FontWeight.w900,
                color: const Color(0xff3b82f6),
                fontSize: 11,
                letterSpacing: 1.2)),
        const SizedBox(height: 12),
        const SettingsCardItem(
            icon: Icons.person_outline_rounded,
            title: "Profile Settings",
            trailing: Icon(Icons.chevron_right_rounded, size: 20)),
        const SizedBox(height: 32),
        Text("SECURITY",
            style: theme.textTheme.muted.copyWith(
                fontWeight: FontWeight.w900,
                color: const Color(0xff3b82f6),
                fontSize: 11,
                letterSpacing: 1.2)),
        const SizedBox(height: 12),
        const SettingsCardItem(
            icon: Icons.security_rounded,
            title: "Local Encryption",
            subtitle: "AES-256 Protection Active",
            trailing: Icon(Icons.verified_user_rounded,
                color: Color(0xff3b82f6), size: 20)),
        const SizedBox(height: 48),
        Center(
            child: Text("GrowthPilot AI v1.0.8",
                style: theme.textTheme.muted.copyWith(fontSize: 12))),
      ],
    );
  }
}
