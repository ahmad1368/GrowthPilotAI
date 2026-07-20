import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/inbox_controller.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/action_card_actions.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/dismissible_conversation_tile.dart';

/// The Inbox screen's list (Issue #72): one [DismissibleConversationTile]
/// per [ConversationSummary], wired to [InboxController] for ACTION_CARD
/// approvals (Issue #73), anomaly dismissals (Issue #74), and
/// swipe/multi-select archive (Issue #76).
class ConversationList extends StatelessWidget {
  final InboxController controller;
  final List<ConversationSummary> summaries;

  const ConversationList(
      {super.key, required this.controller, required this.summaries});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      itemCount: summaries.length,
      itemBuilder: (context, index) {
        final summary = summaries[index];
        final actionCard = summary.actionCard;
        return DismissibleConversationTile(
          summary: summary,
          selectionMode: controller.selection.selectionMode.value,
          isSelected: controller.selection.isSelected(summary.conversationId),
          onLongPress: () => controller.selection.enter(summary.conversationId),
          onToggleSelected: () =>
              controller.selection.toggle(summary.conversationId),
          onArchive: () async {
            final entity =
                controller.archiveConversation(summary.conversationId);
            if (entity == null || !context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Archived "${summary.subject}"'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () => controller.undoArchive([entity]),
              ),
            ));
          },
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
    ));
  }
}
