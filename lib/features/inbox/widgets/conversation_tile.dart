import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/conversation_preview.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/transaction_link_badge.dart';

/// One Inbox row (Issue #72): subject, [ConversationPreview], unread badge.
class ConversationTile extends StatelessWidget {
  final ConversationSummary summary;
  final bool isApprovingAction;
  final VoidCallback onTap;
  final VoidCallback onApproveAction;

  const ConversationTile({
    super.key,
    required this.summary,
    required this.onTap,
    required this.isApprovingAction,
    required this.onApproveAction,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Text(summary.subject.isNotEmpty ? summary.subject[0] : '?'),
      ),
      title: Text(summary.subject),
      subtitle: ConversationPreview(
        summary: summary,
        isApprovingAction: isApprovingAction,
        onApproveAction: onApproveAction,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (summary.unreadCount > 0)
            CircleAvatar(
              radius: 9,
              child: Text('${summary.unreadCount}',
                  style: const TextStyle(fontSize: 11)),
            ),
          if (summary.hasLinkedTransaction)
            TransactionLinkBadge(amount: summary.linkedTransactionAmount!),
        ],
      ),
    );
  }
}
