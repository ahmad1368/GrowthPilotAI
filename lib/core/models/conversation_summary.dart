import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/models/action_card_data.dart';

/// Display-ready shape of one Inbox row (Issue #72): last message preview,
/// unread count, and — when the conversation has a context link (Issue
/// #70) — the linked transaction's amount for the "Linked" badge. When the
/// latest message is an ACTION_CARD (Issue #73), [actionCard] replaces the
/// plain-text preview in the UI. [isLatestMessageRead] drives the Issue #78
/// read-receipt icon (single check vs. double check).
@immutable
class ConversationSummary {
  final int conversationId;
  final String subject;
  final String lastMessagePreview;
  final DateTime lastMessageAt;
  final int unreadCount;
  final double? linkedTransactionAmount;
  final ActionCardData? actionCard;
  final bool isLatestMessageRead;

  const ConversationSummary({
    required this.conversationId,
    required this.subject,
    required this.lastMessagePreview,
    required this.lastMessageAt,
    required this.unreadCount,
    this.linkedTransactionAmount,
    this.actionCard,
    this.isLatestMessageRead = true,
  });

  bool get hasLinkedTransaction => linkedTransactionAmount != null;
}
