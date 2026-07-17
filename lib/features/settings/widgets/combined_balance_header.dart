import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Total Combined Balance" summary card for the Connected Accounts screen
/// (Issue #68) — reflects active accounts only.
class CombinedBalanceHeader extends StatelessWidget {
  final double combinedBalance;

  const CombinedBalanceHeader({super.key, required this.combinedBalance});

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      title: const Text('Total Combined Balance'),
      description: const Text('Active accounts only'),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          '\$${combinedBalance.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
