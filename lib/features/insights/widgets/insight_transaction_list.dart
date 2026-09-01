import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Transaction List view (Issue #261) — flat rows, not the issue's
/// literal "Glassmorphism List" (architecture forbids Glassmorphism/
/// BackdropFilter).
class InsightTransactionList extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const InsightTransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Column(
      children: [
        for (final t in transactions)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                    child: Text(t.description,
                        style: TextStyle(color: colors.foreground, fontSize: 13))),
                Text('\$${t.amount.toStringAsFixed(2)}',
                    style: TextStyle(color: colors.foreground, fontSize: 13)),
              ],
            ),
          ),
      ],
    );
  }
}
