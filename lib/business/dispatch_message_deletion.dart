import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_deleted_message.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';

/// Orchestrates "Delete for Everyone" (Issue #317 feature #19): wipes
/// the message via [BuildDeletedMessage], updates [inbox] in place
/// optimistically, then rebroadcasts the tombstone so
/// [ChatMessageRelayHandler]'s incoming-message path (which already
/// persists every message it receives) applies the same upsert on
/// echo/for peers.
class DispatchMessageDeletion {
  static Future<bool> call(
    ChatGatewayService gateway,
    RxList<ChatRoomMessageEntity> inbox,
    ChatRoomMessageEntity message,
  ) async {
    final tombstoned = BuildDeletedMessage.call(message);
    final index = inbox.indexWhere((m) => m.id == tombstoned.id);
    if (index != -1) inbox[index] = tombstoned;
    final result = await gateway.emitMessage(tombstoned);
    return result.success;
  }
}
