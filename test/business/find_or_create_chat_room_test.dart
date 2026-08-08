import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_or_create_chat_room.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('creates a new room when no pair matches', () {
    final room = FindOrCreateChatRoom.call([], 'a', 'b', now);
    expect(room.participantAId, 'a');
    expect(room.participantBId, 'b');
    expect(room.id, 0);
  });

  test('reuses an existing room regardless of participant order', () {
    final existing = ChatRoomEntity(
        id: 7, participantAId: 'a', participantBId: 'b', createdAt: now);
    final room = FindOrCreateChatRoom.call([existing], 'b', 'a', now);
    expect(room.id, 7);
    expect(identical(room, existing), isTrue);
  });

  test('does not reuse a room with a different participant pair', () {
    final existing =
        ChatRoomEntity(participantAId: 'a', participantBId: 'b', createdAt: now);
    final room = FindOrCreateChatRoom.call([existing], 'a', 'c', now);
    expect(identical(room, existing), isFalse);
  });
}
