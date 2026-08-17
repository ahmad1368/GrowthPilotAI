import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/legal_consent_controller.dart';
import 'package:growth_pilot_ai/business/is_data_usage_consent_required.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Legal & Compliance" settings section (Issue #215) — always-available
/// entry point (AC: "Direct Link... always in the Settings section") plus
/// the data-usage consent toggle, disabled while mandatory for the free
/// tier.
class LegalComplianceSection extends StatelessWidget {
  final LegalConsentController controller;
  final bool hasPremiumSubscription;
  final VoidCallback onViewTerms;

  const LegalComplianceSection({
    super.key,
    required this.controller,
    required this.hasPremiumSubscription,
    required this.onViewTerms,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final consentRequired = IsDataUsageConsentRequired.call(hasPremiumSubscription);

    return Obx(() {
      final state = controller.state.value;
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Terms of Service & Privacy Policy',
                  style: TextStyle(color: colors.foreground)),
              subtitle: Text('Version ${state.acceptedVersion ?? 'not yet accepted'}',
                  style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
              onTap: onViewTerms,
            ),
            SwitchListTile(
              title: Text('Anonymized market data sharing',
                  style: TextStyle(color: colors.foreground)),
              value: state.dataUsageConsent,
              onChanged: consentRequired
                  ? null
                  : (v) => controller.accept(dataUsageConsent: v),
            ),
          ],
        ),
      );
    });
  }
}
