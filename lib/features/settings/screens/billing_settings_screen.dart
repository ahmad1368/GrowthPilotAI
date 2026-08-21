import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/controllers/subscription_controller.dart';
import 'package:growth_pilot_ai/features/settings/widgets/subscription_status_card.dart';
import 'package:growth_pilot_ai/features/settings/widgets/subscription_tier_picker.dart';

/// "Manage Billing & Invoices" screen (Issue #171) — the native
/// in-app replacement for a Stripe Customer Portal redirect; no
/// Stripe account exists in this repo (see PR notes).
class BillingSettingsScreen extends StatefulWidget {
  const BillingSettingsScreen({super.key});

  @override
  State<BillingSettingsScreen> createState() => _BillingSettingsScreenState();
}

class _BillingSettingsScreenState extends State<BillingSettingsScreen> {
  static const _businessId = 'local-user';
  final _controller = Get.find<SubscriptionController>();
  late var _subscription = _controller.subscriptionFor(_businessId);

  void _refresh() => setState(() => _subscription = _controller.subscriptionFor(_businessId));

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: const Text('Billing'), backgroundColor: colors.background),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SubscriptionStatusCard(
            subscription: _subscription,
            onRenew: () async {
              await _controller.renew(_subscription, applyPst: true);
              _refresh();
            },
            onCancel: () {
              _controller.cancel(_subscription);
              _refresh();
            },
          ),
          const SizedBox(height: 24),
          Text('Change plan', style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SubscriptionTierPicker(
            selected: _subscription.tier,
            onSelected: (tier) {
              _controller.changeTier(_subscription, tier);
              _refresh();
            },
          ),
        ],
      ),
    );
  }
}
