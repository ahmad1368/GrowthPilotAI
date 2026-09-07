import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/settings/widgets/founding_member_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/learning_community_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_ops_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_section_header.dart';

/// [Issue #808] "More" tab: learning/community, the Founding Member
/// beta program, and operational entries (support, analytics, system
/// health).
class SettingsMoreTab extends StatelessWidget {
  const SettingsMoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        const SettingsSectionHeader('Learning & Community'),
        const SizedBox(height: 12),
        const LearningCommunitySection(),
        const SizedBox(height: 32),
        const SettingsSectionHeader('Founding Member Beta'),
        const SizedBox(height: 12),
        const FoundingMemberSection(businessId: 'local-user'),
        const SizedBox(height: 32),
        const SettingsSectionHeader('Support & System'),
        const SizedBox(height: 12),
        const SettingsOpsSection(),
      ],
    );
  }
}
