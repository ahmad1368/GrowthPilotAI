import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/forward_chat_message.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);
  final original = ChatRoomMessageEntity(
      roomId: 1, senderId: 'vendor', body: 'Price is $50/unit', sentAt: now);

  test('forwards into a room the forwarder participates in', () {
    final targetRoom = ChatRoomEntity(
        id: 2, participantAId: 'buyer', participantBId: 'other-vendor', createdAt: now);

    final forwarded = ForwardChatMessage.call(
        original: original, targetRoom: targetRoom, forwarderId: 'buyer', now: now);

    expect(forwarded, isNotNull);
    expect(forwarded!.roomId, 2);
    expect(forwarded.isForwarded, isTrue);
    expect(forwarded.forwardedFromSenderId, 'vendor');
    expect(forwarded.body, original.body);
  });

  test('refuses to forward into a room the forwarder is not part of', () {
    final targetRoom = ChatRoomEntity(
        id: 2, participantAId: 'someone-else', participantBId: 'other-vendor', createdAt: now);

    final forwarded = ForwardChatMessage.call(
        original: original, targetRoom: targetRoom, forwarderId: 'buyer', now: now);

    expect(forwarded, isNull);
  });
}
