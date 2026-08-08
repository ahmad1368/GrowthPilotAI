import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/list_forwardable_chat_rooms.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('excludes the current room and rooms the user is not part of', () {
    final current = ChatRoomEntity(id: 1, participantAId: 'buyer', participantBId: 'vendor-a', createdAt: now);
    final other = ChatRoomEntity(id: 2, participantAId: 'buyer', participantBId: 'vendor-b', createdAt: now);
    final unrelated = ChatRoomEntity(id: 3, participantAId: 'x', participantBId: 'y', createdAt: now);

    final result = ListForwardableChatRooms.call([current, other, unrelated], 'buyer', 1);

    expect(result, [other]);
  });
}
