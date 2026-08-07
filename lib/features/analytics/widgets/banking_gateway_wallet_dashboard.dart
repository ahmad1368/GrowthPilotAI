import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_wallet_balance_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';

/// Admin oversight of simulated crypto wallet balances per rail
/// (Issue #423, acceptance criterion 5) — this app has no real
/// wallet, so "balance" is the running total this simulation has
/// settled, not a live on-chain lookup.
class BankingGatewayWalletDashboard extends StatelessWidget {
  final List<BankingGatewayTransactionEntity> transactions;

  const BankingGatewayWalletDashboard({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final balances = BuildWalletBalanceSummary.call(transactions);
    if (balances.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Wallet balances', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          for (final entry in balances.entries)
            Text('${entry.key.name}: CAD ${entry.value.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
