import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/mark_chat_room_messages_as_read.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_message_repository.dart';

/// Read Receipts (Issue #131 AC): marks the other participant's messages
/// read and persists the change, refreshing [inbox] in place since the
/// entities mutate rather than the list itself changing.
class ChatReadReceiptHandler {
  final ChatRoomMessageRepository _messages;
  final RxList<ChatRoomMessageEntity> inbox;

  ChatReadReceiptHandler(this._messages, this.inbox);

  void markRead(String readerId) {
    final changed =
        MarkChatRoomMessagesAsRead.call(inbox, readerId, DateTime.now());
    if (changed.isEmpty) return;
    for (final message in changed) {
      _messages.insert(message);
    }
    inbox.refresh();
  }
}
