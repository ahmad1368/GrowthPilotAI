import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/describe_intelligence_sync_state.dart';
import 'package:growth_pilot_ai/controllers/intelligence_status_controller.dart';
import 'package:growth_pilot_ai/core/enum/intelligence_sync_state.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/widgets/intelligence_status_pill.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const _tooltip = 'Benchmarking runs 100% on this device for privacy and '
    'speed — no data ever leaves your phone.';

Color _accent(ShadColorScheme colors, IntelligenceSyncState state) => switch (state) {
      IntelligenceSyncState.syncing => colors.primary,
      IntelligenceSyncState.updateRequired => colors.destructive,
      IntelligenceSyncState.localMode => colors.mutedForeground,
    };

/// "Offline Intelligence" status badge (Issue #109): connects the
/// #105/#106 local cache's freshness to [IntelligenceStatusPill]. Wraps
/// its own [ShadTheme] since it's mounted in [HomeLayout]'s app bar, which
/// — unlike the feature screens — has no ShadTheme ancestor of its own.
class IntelligenceStatusBadge extends StatelessWidget {
  const IntelligenceStatusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IntelligenceStatusController>();

    return ShadTheme(
      data: AppShadTheme.build(Theme.of(context).brightness),
      child: Builder(builder: (context) {
        final colors = ShadTheme.of(context).colorScheme;
        return Obx(() {
          final state = controller.state.value;
          return IntelligenceStatusPill(
            label: DescribeIntelligenceSyncState.call(
                state, controller.lastSyncedAt.value, DateTime.now()),
            accent: _accent(colors, state),
            foreground: colors.foreground,
            tooltip: _tooltip,
          );
        });
      }),
    );
  }
}
