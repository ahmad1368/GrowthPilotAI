import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/toggle_message_pin.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';

/// Orchestrates pin/unpin (Issue #317 feature #22) — same optimistic-
/// upsert-then-rebroadcast shape as [DispatchMessageDeletion]/
/// [DispatchMessageEdit].
class DispatchMessagePinToggle {
  static Future<bool> call(
    ChatGatewayService gateway,
    RxList<ChatRoomMessageEntity> inbox,
    ChatRoomMessageEntity message,
  ) async {
    final toggled = ToggleMessagePin.call(message);
    final index = inbox.indexWhere((m) => m.id == toggled.id);
    if (index != -1) inbox[index] = toggled;
    final result = await gateway.emitMessage(toggled);
    return result.success;
  }
}
