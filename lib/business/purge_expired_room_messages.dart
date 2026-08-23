import 'package:growth_pilot_ai/business/is_message_expired.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_message_repository.dart';

/// Sweeps Secret Chat messages past their self-destruct timer (Issue
/// #317 feature #2) out of [all], purging them from [repo] and
/// returning only the still-live messages.
class PurgeExpiredRoomMessages {
  static List<ChatRoomMessageEntity> call(
      ChatRoomMessageRepository repo, List<ChatRoomMessageEntity> all, DateTime now) {
    final expired = all.where((m) => IsMessageExpired.call(m, now)).toList();
    if (expired.isNotEmpty) repo.removeExpired(expired);
    return all.where((m) => !expired.contains(m)).toList();
  }
}
