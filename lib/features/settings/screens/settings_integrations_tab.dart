import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/features/settings/widgets/integrations_section.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_nav_tile.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_section_header.dart';

/// [Issue #808] "Integrations & Billing" tab: bank/accounting
/// connections, PDF-export branding, and billing management.
class SettingsIntegrationsTab extends StatelessWidget {
  const SettingsIntegrationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        const SettingsSectionHeader('Integrations'),
        const SizedBox(height: 12),
        const IntegrationsSection(),
        const SizedBox(height: 32),
        const SettingsSectionHeader('Branding'),
        const SizedBox(height: 12),
        SettingsNavTile(
          icon: Icons.palette_outlined,
          title: 'Branding',
          subtitle: 'Logo, company name, and brand color for PDF exports',
          onTap: () => Get.toNamed('/settings/branding'),
        ),
        const SizedBox(height: 32),
        const SettingsSectionHeader('Billing'),
        const SizedBox(height: 12),
        SettingsNavTile(
          icon: Icons.credit_card_rounded,
          title: 'Manage Billing',
          subtitle: 'Plan, renewal, and cancellation',
          onTap: () => Get.toNamed('/settings/billing'),
        ),
      ],
    );
  }
}
