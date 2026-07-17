import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/transaction_match_controller.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/features/transactions/widgets/merged_fields_section.dart';

/// Body of the Transaction Details screen (Issue #69): amount/merchant,
/// then [MergedFieldsSection] when this record was auto-matched.
class TransactionMergeDetail extends StatelessWidget {
  final UnifiedTransactionEntity transaction;
  final TransactionMatchController controller;

  const TransactionMergeDetail({
    super.key,
    required this.transaction,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final view = controller.viewFor(transaction);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(transaction.merchantName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('\$${transaction.amount.toStringAsFixed(2)}'),
          const SizedBox(height: 16),
          if (view == null)
            const Text('Not merged with another record.')
          else
            MergedFieldsSection(
              view: view,
              onSplit: () {
                controller.split(transaction);
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }
}
