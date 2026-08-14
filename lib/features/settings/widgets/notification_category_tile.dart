import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/notification_preference_controller.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/core/enum/notification_channel.dart';

/// One category's Push/Email/SMS toggles (Issue #158) — an ExpansionTile
/// per the issue's own "keep the mobile UI clean and focused" guidance,
/// so the 3x3 toggle grid doesn't dominate the Settings screen.
class NotificationCategoryTile extends StatelessWidget {
  final NotificationCategory category;
  final String label;

  const NotificationCategoryTile({super.key, required this.category, required this.label});

  String _channelLabel(NotificationChannel channel) => switch (channel) {
        NotificationChannel.push => 'Push',
        NotificationChannel.email => 'Email',
        NotificationChannel.sms => 'SMS',
      };

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationPreferenceController>();
    final theme = Theme.of(context);

    return Obx(() => ExpansionTile(
          title: Text(label, style: TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w600)),
          children: NotificationChannel.values
              .map((channel) => SwitchListTile(
                    title: Text(_channelLabel(channel),
                        style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 13)),
                    value: controller.preferences.value.isEnabled(category, channel),
                    onChanged: (_) => controller.toggle(category, channel),
                  ))
              .toList(),
        ));
  }
}
