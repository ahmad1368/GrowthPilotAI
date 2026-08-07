import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/merchant_accounting_summary.dart';

/// One merchant's bookkeeping line (Issue #427, acceptance criterion
/// 1) — fees, waivers, payouts, tax, and net earnings.
class AccountingReportsRow extends StatelessWidget {
  final MerchantAccountingSummary summary;

  const AccountingReportsRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        '${summary.merchantName}: fees \$${summary.totalFees.toStringAsFixed(2)}, '
        'waived \$${summary.totalWaived.toStringAsFixed(2)}, '
        'payouts \$${summary.totalPayouts.toStringAsFixed(2)}, '
        'tax \$${summary.taxDeduction.toStringAsFixed(2)} → '
        'net \$${summary.netEarnings.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
