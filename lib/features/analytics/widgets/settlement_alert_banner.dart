import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

/// Terminal-failure indicator for a settlement that fell off the
/// happy-path timeline (Issue #426, acceptance criterion 3) — shown
/// instead of a timeline step since [GatewayTransactionStatus.failed]
/// and [GatewayTransactionStatus.refunded] are alternate endings, not
/// a further stage of the 4-step progression.
class SettlementAlertBanner extends StatelessWidget {
  final GatewayTransactionStatus status;

  const SettlementAlertBanner({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isAlert =
        status == GatewayTransactionStatus.failed || status == GatewayTransactionStatus.refunded;
    if (!isAlert) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(status.name.toUpperCase(),
          style: const TextStyle(fontSize: 11, color: Colors.red, fontWeight: FontWeight.w600)),
    );
  }
}
