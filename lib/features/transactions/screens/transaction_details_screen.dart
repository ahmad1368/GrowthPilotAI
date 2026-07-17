import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/transaction_match_controller.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/core/theme/mapping_shad_theme.dart';
import 'package:growth_pilot_ai/features/transactions/widgets/transaction_merge_detail.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Transaction Details screen (Issue #69): shows the "Merged" badge with
/// both providers' icons and a "Split" action when this record was
/// auto-matched with a counterpart from the other feed.
class TransactionDetailsScreen extends StatelessWidget {
  final UnifiedTransactionEntity transaction;
  final TransactionMatchController controller;

  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return ShadTheme(
      data: MappingShadTheme.build(brightness),
      child: Scaffold(
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : const Color(0xFFFFFFFF),
        appBar: AppBar(title: const Text('Transaction Details')),
        body: TransactionMergeDetail(transaction: transaction, controller: controller),
      ),
    );
  }
}
