import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';

/// Status/period summary + Renew/Cancel actions (Issue #171) — the
/// native equivalent of Stripe's "Manage Billing & Invoices" panel.
class SubscriptionStatusCard extends StatelessWidget {
  final SubscriptionEntity subscription;
  final VoidCallback onRenew;
  final VoidCallback onCancel;

  const SubscriptionStatusCard({
    super.key,
    required this.subscription,
    required this.onRenew,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Status: ${subscription.status.name}',
            style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('Current period ends ${subscription.currentPeriodEnd.toIso8601String().split('T').first}',
            style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
        const SizedBox(height: 12),
        Row(children: [
          ShadButton.outline(onPressed: onRenew, child: const Text('Renew Now')),
          const SizedBox(width: 8),
          ShadButton.destructive(onPressed: onCancel, child: const Text('Cancel')),
        ]),
      ]),
    );
  }
}
