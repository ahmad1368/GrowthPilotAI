import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_nav_tile.dart';

/// [Issue #808] Business Academy, AI Engine, and OmniPulse entry points,
/// Settings > More.
class LearningCommunitySection extends StatelessWidget {
  const LearningCommunitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SettingsNavTile(
        icon: Icons.play_circle_outline_rounded,
        title: 'Business Academy',
        subtitle: 'Tutorials, marketplace guides, and legal videos',
        onTap: () => Get.toNamed('/academy'),
      ),
      const SizedBox(height: 12),
      SettingsNavTile(
        icon: Icons.psychology_outlined,
        title: 'AI Engine',
        subtitle: 'On-device AI model — download, pause, resume',
        onTap: () => Get.toNamed('/ai-engine'),
      ),
      const SizedBox(height: 12),
      SettingsNavTile(
        icon: Icons.campaign_outlined,
        title: 'OmniPulse',
        subtitle: 'Live business bottlenecks and hazards near you',
        onTap: () => Get.toNamed('/pulse'),
      ),
    ]);
  }
}
