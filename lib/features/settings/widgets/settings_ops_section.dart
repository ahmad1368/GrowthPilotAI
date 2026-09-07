import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/support_chat_controller.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_nav_tile.dart';

/// [Issue #808] Support chat, analytics dashboard, and system-health
/// entry points, Settings > More.
class SettingsOpsSection extends StatelessWidget {
  const SettingsOpsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Obx(() {
        final unread = Get.find<SupportChatController>().unreadCount.value;
        return SettingsNavTile(
          icon: Icons.support_agent_rounded,
          title: 'Chat with Support',
          subtitle: unread > 0 ? '$unread new reply' : "Ask a question, we'll follow up",
          onTap: () => Get.toNamed('/settings/support'),
        );
      }),
      const SizedBox(height: 12),
      SettingsNavTile(
        icon: Icons.insights_rounded,
        title: 'Analytics Dashboard',
        subtitle: 'Conversion funnel and feature popularity',
        onTap: () => Get.toNamed('/settings/analytics'),
      ),
      const SizedBox(height: 12),
      SettingsNavTile(
        icon: Icons.monitor_heart_rounded,
        title: 'System Health',
        subtitle: 'Database, storage, and connectivity status',
        onTap: () => Get.toNamed('/settings/health'),
      ),
    ]);
  }
}
