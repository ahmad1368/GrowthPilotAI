import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_verified_business_rating.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('verified when a chat room exists between rater and business', () {
    final rooms = [ChatRoomEntity(participantAId: 'buyer', participantBId: 'biz-1', createdAt: now)];
    expect(IsVerifiedBusinessRating.call(rooms, 'buyer', 'biz-1'), isTrue);
  });

  test('not verified with no shared chat history', () {
    expect(IsVerifiedBusinessRating.call([], 'buyer', 'biz-1'), isFalse);
  });
}
