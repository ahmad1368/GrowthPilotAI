import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Non-dismissible "you are offline" barrier for Web (Issue #263, AC:
/// "Web correctly blocks interactions during downtime") — flat, no
/// Glassmorphism/BackdropFilter.
class WebOfflineOverlay extends StatelessWidget {
  const WebOfflineOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Positioned.fill(
      child: AbsorbPointer(
        child: Container(
          color: colors.background.withValues(alpha: 0.92),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi_off, size: 40, color: colors.mutedForeground),
              const SizedBox(height: 12),
              Text(
                'You are currently offline. Please wait for the connection to be restored.',
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.foreground, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
