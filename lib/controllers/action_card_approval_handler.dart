import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/approve_action_card.dart';
import 'package:growth_pilot_ai/core/data/repositories/message_repository.dart';

/// Extracted from [InboxController] (Issue #74) to keep that file within
/// the 50-line limit: tracks in-flight approval taps and applies
/// [ApproveActionCard] (Issue #73). The delay stands in for the backend
/// round-trip, making the anti-double-tap guard ([isApproving]) visible in
/// the UI.
class ActionCardApprovalHandler {
  final MessageRepository _messages;
  final _approvingConversationIds = <int>{}.obs;

  ActionCardApprovalHandler(this._messages);

  bool isApproving(int conversationId) =>
      _approvingConversationIds.contains(conversationId);

  Future<void> approve(int conversationId, int messageId) async {
    if (_approvingConversationIds.contains(conversationId)) return;
    _approvingConversationIds.add(conversationId);
    await Future.delayed(const Duration(milliseconds: 500));
    final message = _messages
        .getForConversation(conversationId)
        .firstWhere((m) => m.id == messageId);
    if (ApproveActionCard.call(message)) _messages.upsert(message);
    _approvingConversationIds.remove(conversationId);
  }
}
