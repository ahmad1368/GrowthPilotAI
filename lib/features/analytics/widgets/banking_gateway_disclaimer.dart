import 'package:flutter/material.dart';

/// Always-visible notice that this is a local orchestration-layer
/// simulation, not a live connection to Stripe/PayPal/SWIFT/SEPA
/// (Issue #421) — this app has no real gateway credentials, backend
/// webhook receiver, or PCI-DSS-scoped infrastructure, so nothing
/// here moves real funds.
class BankingGatewayDisclaimer extends StatelessWidget {
  const BankingGatewayDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: scheme.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Simulation only — no live Stripe/PayPal/SWIFT/SEPA connection, forex feed, or real fund movement.',
        style: TextStyle(fontSize: 11, color: scheme.error),
      ),
    );
  }
}
