import 'package:flutter/foundation.dart';

/// Display-ready shape of one Inbox row (Issue #72): last message preview,
/// unread count, and — when the conversation has a context link (Issue
/// #70) — the linked transaction's amount for the "Linked" badge.
@immutable
class ConversationSummary {
  final int conversationId;
  final String subject;
  final String lastMessagePreview;
  final DateTime lastMessageAt;
  final int unreadCount;
  final double? linkedTransactionAmount;

  const ConversationSummary({
    required this.conversationId,
    required this.subject,
    required this.lastMessagePreview,
    required this.lastMessageAt,
    required this.unreadCount,
    this.linkedTransactionAmount,
  });

  bool get hasLinkedTransaction => linkedTransactionAmount != null;
}
