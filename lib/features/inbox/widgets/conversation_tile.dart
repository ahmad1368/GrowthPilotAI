import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/transaction_link_badge.dart';

/// One row on the Inbox screen (Issue #72): subject, latest message
/// preview, unread count, and — when linked — a [TransactionLinkBadge].
class ConversationTile extends StatelessWidget {
  final ConversationSummary summary;
  final VoidCallback onTap;

  const ConversationTile(
      {super.key, required this.summary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Text(summary.subject.isNotEmpty ? summary.subject[0] : '?'),
      ),
      title: Text(summary.subject),
      subtitle: Text(
        summary.lastMessagePreview,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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
