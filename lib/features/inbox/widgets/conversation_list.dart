import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/inbox_controller.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/action_card_actions.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/conversation_tile.dart';

/// The Inbox screen's list (Issue #72): one [ConversationTile] per
/// [ConversationSummary], wired to [InboxController] for ACTION_CARD
/// approvals (Issue #73) and anomaly dismissals (Issue #74).
class ConversationList extends StatelessWidget {
  final InboxController controller;
  final List<ConversationSummary> summaries;

  const ConversationList(
      {super.key, required this.controller, required this.summaries});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: summaries.length,
      itemBuilder: (context, index) {
        final summary = summaries[index];
        final actionCard = summary.actionCard;
        return ConversationTile(
          summary: summary,
          onTap: () {},
          actions: ActionCardActions(
            isApproving: controller.isApprovingAction(summary.conversationId),
            onApprove: actionCard == null
                ? () {}
                : () => controller.approveAction(
                    summary.conversationId, actionCard.messageId),
            isIgnoringAnomaly:
                controller.isIgnoringAnomaly(summary.conversationId),
            onIgnoreAnomaly: actionCard == null
                ? () {}
                : () => controller.ignoreAnomalyMerchant(
                    summary.conversationId, actionCard.messageId),
            isProcessingRecommendation:
                controller.isProcessingRecommendation(summary.conversationId),
            onActRecommendation:
                actionCard == null || actionCard.recommendationType == null
                    ? () {}
                    : () => controller
                        .actOnRecommendation(actionCard.recommendationType!),
            onDismissRecommendation: actionCard == null
                ? () {}
                : () => controller.dismissRecommendation(
                    summary.conversationId, actionCard.messageId),
            onSnoozeRecommendation: actionCard == null
                ? () {}
                : () => controller.snoozeRecommendation(
                    summary.conversationId, actionCard.messageId),
          ),
        );
      },
    );
  }
}
