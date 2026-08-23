import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_edited_message.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';

/// Orchestrates "Message Editing" (Issue #317 feature #18) — same
/// optimistic-upsert-then-rebroadcast shape as [DispatchMessageDeletion]
/// (Issue #317 feature #19): updates [inbox] in place, then relies on
/// [ChatMessageRelayHandler]'s upsert-by-id incoming path to persist
/// the echo and propagate it to peers.
class DispatchMessageEdit {
  static Future<bool> call(
    ChatGatewayService gateway,
    RxList<ChatRoomMessageEntity> inbox,
    ChatRoomMessageEntity message,
    String newBody,
  ) async {
    final edited = BuildEditedMessage.call(message, newBody, DateTime.now());
    final index = inbox.indexWhere((m) => m.id == edited.id);
    if (index != -1) inbox[index] = edited;
    final result = await gateway.emitMessage(edited);
    return result.success;
  }
}
