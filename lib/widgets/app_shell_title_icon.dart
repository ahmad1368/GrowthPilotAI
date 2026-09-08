import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [Issue #835] Was a bare decorative Icon with no tap handling at all —
/// wrapped tappable (with a visible ripple + tooltip) when a handler is
/// given, falling back to the old non-interactive icon otherwise. Split
/// out of AppShellBar to stay under this repo's per-file line cap.
class AppShellTitleIcon extends StatelessWidget {
  final IconData icon;
  final Color foreground;
  final VoidCallback? onTap;

  const AppShellTitleIcon({
    super.key,
    required this.icon,
    required this.foreground,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(icon, color: foreground);
    if (onTap == null) return iconWidget;
    return Tooltip(
      message: 'appbar_growth_metrics_tooltip'.tr,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(6), child: iconWidget),
      ),
    );
  }
}
