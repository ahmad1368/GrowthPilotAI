import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/models/action_card_data.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/transaction_approval_card.dart';

/// Maps an [ActionCardData] payload to its Inbox row widget (Issue #73).
/// Only [ActionCardType.approveTransaction] has a dedicated card so far;
/// other action types fall back to a plain status label.
class CardFactory {
  static Widget build({
    required ActionCardData data,
    required bool isProcessing,
    required VoidCallback onApprove,
  }) {
    switch (data.actionType) {
      case ActionCardType.approveTransaction:
        return TransactionApprovalCard(
          data: data,
          isProcessing: isProcessing,
          onApprove: onApprove,
        );
      case ActionCardType.signContract:
      case ActionCardType.payInvoice:
        return Text(data.isPending ? 'Action pending' : 'Action completed',
            style: const TextStyle(fontSize: 12));
    }
  }
}
