import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/features/settings/widgets/notification_category_tile.dart';
import 'package:growth_pilot_ai/features/settings/widgets/push_permission_banner.dart';

/// "Notification Preference Center" (Issue #158) — per-category Push/
/// Email/SMS toggles, grouped so a user can mute Marketing while keeping
/// Orders alerts active (AC: "Granularity").
class NotificationPreferenceSection extends StatelessWidget {
  const NotificationPreferenceSection({super.key});

  static const _labels = {
    NotificationCategory.orders: 'Orders',
    NotificationCategory.finance: 'Finance',
    NotificationCategory.marketing: 'Marketing',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          const PushPermissionBanner(),
          for (final category in NotificationCategory.values)
            NotificationCategoryTile(category: category, label: _labels[category]!),
        ],
      ),
    );
  }
}
