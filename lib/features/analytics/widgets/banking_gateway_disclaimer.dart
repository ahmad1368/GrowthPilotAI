import 'package:flutter/material.dart';

/// Always-visible notice that this is a local orchestration-layer
/// simulation, not a live connection to any real payment rail (Issue
/// #421) — this app has no real gateway credentials, backend webhook
/// receiver, or PCI-DSS-scoped infrastructure, so nothing here moves
/// real funds. Extended for Issue #422's regional rails (Interac,
/// UnionPay): data-residency and regional-banking-authority
/// compliance (acceptance criterion 5) is likewise not claimed —
/// that's a regulatory audit, not something achievable in code.
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
        'Simulation only — no live Stripe/PayPal/SWIFT/SEPA/Interac/UnionPay connection, forex feed, '
        'real fund movement, or claimed regulatory/data-residency compliance.',
        style: TextStyle(fontSize: 11, color: scheme.error),
      ),
    );
  }
}
