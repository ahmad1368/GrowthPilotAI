import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/settlement_tracking_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/settlement_tracking_view_state.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders one timeline row per gateway transaction (Issue #426,
/// acceptance criteria 1-2 and 4). Purely presentational.
class SettlementTrackingView extends StatelessWidget {
  final SettlementTrackingViewState state;
  final VoidCallback onRefresh;

  const SettlementTrackingView({super.key, required this.state, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    if (state.transactions.isEmpty) {
      return const Text(
        'No settlements yet — transactions from the Banking Gateway (#421) '
        'will appear here as they progress.',
        style: TextStyle(fontSize: 12),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ShadButton.ghost(onPressed: onRefresh, child: const Text('Refresh')),
        ),
        for (final tx in state.transactions)
          SettlementTrackingRow(
            transaction: tx,
            escrow: state.escrowFor(tx),
            history: state.historyFor(tx),
          ),
      ],
    );
  }
}
