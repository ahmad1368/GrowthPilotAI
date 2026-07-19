import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/models/action_card_data.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/action_card_actions.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/anomaly_review_card.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/transaction_approval_card.dart';

/// Maps an [ActionCardData] payload to its Inbox row widget (Issues #73/74).
/// [ActionCardType.signContract]/[payInvoice] have no dedicated card yet and
/// fall back to a plain status label.
class CardFactory {
  static Widget build({
    required ActionCardData data,
    required ActionCardActions actions,
  }) {
    switch (data.actionType) {
      case ActionCardType.approveTransaction:
        return TransactionApprovalCard(
          data: data,
          isProcessing: actions.isApproving,
          onApprove: actions.onApprove,
        );
      case ActionCardType.reviewAnomaly:
        return AnomalyReviewCard(
          data: data,
          isProcessing: actions.isIgnoringAnomaly,
          onIgnore: actions.onIgnoreAnomaly,
        );
      case ActionCardType.signContract:
      case ActionCardType.payInvoice:
        return Text(data.isPending ? 'Action pending' : 'Action completed',
            style: const TextStyle(fontSize: 12));
    }
  }
}
