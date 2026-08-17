import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/security_incident_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Security Advisory" public-notice page (Issue #187, AC: "host public
/// notices if individual notification is not possible") — shows only
/// [SecurityIncidentEntity.summary]/[dataInvolved], never a stolen
/// secret itself (AC: "Privacy by Design").
class SecurityAdvisoryPage extends StatelessWidget {
  final SecurityIncidentController controller;

  const SecurityAdvisoryPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      if (controller.incidents.isEmpty) {
        return Text('No security advisories at this time.',
            style: TextStyle(color: colors.mutedForeground, fontSize: 12));
      }
      return Column(
        children: [
          for (final incident in controller.incidents)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration:
                  BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(incident.summary, style: TextStyle(color: colors.foreground, fontSize: 14)),
                  Text('Status: ${incident.status.name} · ${incident.detectedAt}',
                      style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
                ],
              ),
            ),
        ],
      );
    });
  }
}
