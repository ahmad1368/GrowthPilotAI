import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/microphone_consent_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Mock "Microphone Audio Monitoring" consent toggle (Issue #540) — a
/// UI-only placeholder. GrowthPilotAI never requests microphone
/// permission and never captures, records, or analyzes audio; this
/// screen exists only to demonstrate the opt-in/opt-out + audit-logging
/// mechanics real feature flags would use later. The disclosure text
/// below is deliberately honest about that, unlike the issue's literal
/// ask to word it as if monitoring were active (see PR notes).
class MicrophoneMonitoringConsentToggle extends StatelessWidget {
  final MicrophoneConsentController controller;

  const MicrophoneMonitoringConsentToggle({super.key, required this.controller});

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
                '[Demo] Microphone-based ad personalization — placeholder only. '
                'This app does not access your microphone; no audio is ever captured, '
                'recorded, or analyzed. This toggle exists to preview the consent UI only.',
                style: TextStyle(color: colors.mutedForeground, fontSize: 12),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Enable (simulation only)', style: TextStyle(color: colors.foreground)),
                value: controller.optedIn.value,
                onChanged: controller.setOptedIn,
              ),
            ],
          ),
        ));
  }
}
