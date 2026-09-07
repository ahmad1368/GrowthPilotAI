import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_nav_tile.dart';

/// [Issue #808] Accounting/banking connection entries,
/// Settings > Integrations & Billing.
class IntegrationsSection extends StatelessWidget {
  const IntegrationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: AppDesignTokens.card(theme.brightness),
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Icon(Icons.account_balance_rounded, color: theme.colorScheme.onSurface),
          title: const Text("Accounting & Banking"),
          subtitle: Text("Plaid, QuickBooks, Xero connections",
              style: theme.textTheme.bodySmall
                  ?.copyWith(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
          trailing: Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
          onTap: () => Get.toNamed('/settings/integrations'),
        ),
      ),
      const SizedBox(height: 12),
      SettingsNavTile(
        icon: Icons.account_balance_wallet_rounded,
        title: 'Connected Accounts',
        subtitle: 'Manage linked bank sub-accounts',
        onTap: () => Get.toNamed('/settings/connected-accounts'),
      ),
      const SizedBox(height: 12),
      SettingsNavTile(
        icon: Icons.compare_arrows_rounded,
        title: 'Duplicate Matches',
        subtitle: 'Review auto-merged Plaid/accounting transactions',
        onTap: () => Get.toNamed('/transactions/duplicates'),
      ),
    ]);
  }
}
