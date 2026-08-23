import 'package:growth_pilot_ai/business/is_scheduled_message_due.dart';
import 'package:growth_pilot_ai/controllers/chat_message_relay_handler.dart';
import 'package:growth_pilot_ai/core/data/repositories/scheduled_chat_message_repository.dart';

/// Sends every due scheduled message in a room and removes it from the
/// queue (Issue #317 feature #20) — called on room open, mirroring
/// #440's [LowStockScanTriggerService] "scan on visit" shape.
class DispatchDueScheduledMessages {
  static Future<void> call(
    ScheduledChatMessageRepository scheduledRepo,
    ChatMessageRelayHandler relay,
    int roomId,
    DateTime now,
  ) async {
    final due = scheduledRepo
        .getForRoom(roomId)
        .where((m) => IsScheduledMessageDue.call(m, now));
    for (final message in due.toList()) {
      await relay.send(message.senderId, message.body);
      scheduledRepo.remove(message);
    }
  }
}
