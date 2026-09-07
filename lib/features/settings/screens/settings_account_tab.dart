import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/legal_consent_controller.dart';
import 'package:growth_pilot_ai/controllers/subscription_controller.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';
import 'package:growth_pilot_ai/features/legal/screens/legal_document_screen.dart';
import 'package:growth_pilot_ai/features/settings/widgets/account_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/legal_compliance_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/security_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_section_header.dart';

/// [Issue #808] "Account & Security" tab: account actions, legal
/// compliance, and security (encryption status + 2FA).
class SettingsAccountTab extends StatelessWidget {
  const SettingsAccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        const SettingsSectionHeader('Account'),
        const SizedBox(height: 12),
        const AccountSection(),
        const SizedBox(height: 32),
        const SettingsSectionHeader('Legal'),
        const SizedBox(height: 12),
        LegalComplianceSection(
          controller: Get.find<LegalConsentController>(),
          hasPremiumSubscription: Get.find<SubscriptionController>()
                  .subscriptionFor('local-user')
                  .tier !=
              SubscriptionTier.starter,
          onViewTerms: () => Get.to(() => const LegalDocumentScreen()),
        ),
        const SizedBox(height: 32),
        const SettingsSectionHeader('Security'),
        const SizedBox(height: 12),
        const SecuritySection(),
      ],
    );
  }
}
