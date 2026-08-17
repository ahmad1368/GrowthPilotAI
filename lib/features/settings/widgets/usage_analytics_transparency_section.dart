import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/local_usage_analytics_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Transparency Report" for locally-logged usage events (Issue #539) —
/// this is honest, first-party, in-app-only counting. No Meta/Facebook
/// SDK, cross-app/cross-site tracking, location, contacts, or microphone
/// data exists anywhere in this app (see PR notes).
class UsageAnalyticsTransparencySection extends StatelessWidget {
  final LocalUsageAnalyticsController controller;

  const UsageAnalyticsTransparencySection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() => Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'On-device activity log — first-party and in-app only. '
                'No third-party ad SDK, cross-app tracking, location, contacts, '
                'or microphone data is ever collected.',
                style: TextStyle(color: colors.mutedForeground, fontSize: 12),
              ),
              const SizedBox(height: 8),
              for (final entry in controller.summary.entries)
                Text('${entry.key.name}: ${entry.value}',
                    style: TextStyle(color: colors.foreground, fontSize: 13)),
            ],
          ),
        ));
  }
}
