import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/features/transactions/widgets/merged_provider_badge.dart';

/// One record row on the Duplicate Matches screen (Issue #69). Merged
/// records show [MergedProviderBadge]; tapping opens the transaction's
/// details (merge view + Split action if merged).
class TransactionMatchTile extends StatelessWidget {
  final UnifiedTransactionEntity transaction;
  final List<String> originSources;
  final VoidCallback onTap;

  const TransactionMatchTile({
    super.key,
    required this.transaction,
    required this.originSources,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.receipt_long_rounded),
      title: Text(transaction.merchantName),
      subtitle: Text(transaction.date.toString().split(' ').first),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('\$${transaction.amount.toStringAsFixed(2)}'),
          if (transaction.isMerged)
            MergedProviderBadge(originSources: originSources),
        ],
      ),
    );
  }
}
