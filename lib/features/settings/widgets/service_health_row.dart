import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/enum/service_health_status.dart';
import 'package:growth_pilot_ai/core/models/service_health_indicator.dart';

/// One [ServiceHealthIndicator] row (Issue #166) — a colored status dot
/// plus name/message, flat minimal style (no glassmorphism).
class ServiceHealthRow extends StatelessWidget {
  final ServiceHealthIndicator indicator;

  const ServiceHealthRow({super.key, required this.indicator});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final dotColor = switch (indicator.status) {
      ServiceHealthStatus.up => Colors.green,
      ServiceHealthStatus.degraded => Colors.amber,
      ServiceHealthStatus.down => colors.destructive,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(indicator.name, style: TextStyle(color: colors.foreground)),
            Text(indicator.message,
                style: TextStyle(fontSize: 12, color: colors.mutedForeground)),
          ]),
        ),
      ]),
    );
  }
}
