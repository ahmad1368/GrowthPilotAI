import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/inbox_controller.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/conversation_tile.dart';

/// The Inbox screen's list (Issue #72): one [ConversationTile] per
/// [ConversationSummary], wired to [InboxController] for ACTION_CARD
/// approvals (Issue #73).
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
          isApprovingAction:
              controller.isApprovingAction(summary.conversationId),
          onApproveAction: actionCard == null
              ? () {}
              : () => controller.approveAction(
                  summary.conversationId, actionCard.messageId),
        );
      },
    );
  }
}
