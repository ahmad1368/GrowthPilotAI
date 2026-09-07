import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/settings/widgets/appearance_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/language_settings_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/notification_preference_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/performance_settings_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/quiet_hours_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_section_card.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_section_header.dart';

/// [Issue #808] "General" tab: appearance, language, performance,
/// notifications, quiet hours — unchanged content, grouped here instead
/// of sitting in one long flat scroll with everything else.
class SettingsGeneralTab extends StatelessWidget {
  const SettingsGeneralTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        const SettingsSectionHeader('Appearance'),
        const SizedBox(height: 12),
        const AppearanceSection(),
        const SizedBox(height: 32),
        const SettingsSectionHeader('Language'),
        const SizedBox(height: 12),
        const SettingsSectionCard(child: LanguageSettingsSection()),
        const SizedBox(height: 32),
        const SettingsSectionHeader('Performance'),
        const SizedBox(height: 12),
        const SettingsSectionCard(child: PerformanceSettingsSection()),
        const SizedBox(height: 32),
        const SettingsSectionHeader('Notifications'),
        const SizedBox(height: 12),
        const SettingsSectionCard(child: NotificationPreferenceSection()),
        const SizedBox(height: 32),
        const SettingsSectionHeader('Quiet Hours'),
        const SizedBox(height: 12),
        const SettingsSectionCard(child: QuietHoursSection()),
      ],
    );
  }
}
