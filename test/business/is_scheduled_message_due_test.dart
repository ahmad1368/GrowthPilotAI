import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_scheduled_message_due.dart';
import 'package:growth_pilot_ai/core/data/entities/scheduled_chat_message_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1, 12);

  ScheduledChatMessageEntity message(DateTime scheduledFor) => ScheduledChatMessageEntity(
        roomId: 1,
        senderId: 'buyer',
        body: 'follow up tomorrow',
        scheduledFor: scheduledFor,
        createdAt: now.subtract(const Duration(minutes: 1)),
      );

  group('IsScheduledMessageDue', () {
    test('is not due before the scheduled time (Issue #317 feature #20)', () {
      expect(IsScheduledMessageDue.call(message(now.add(const Duration(minutes: 1))), now), isFalse);
    });

    test('is due exactly at the scheduled time', () {
      expect(IsScheduledMessageDue.call(message(now), now), isTrue);
    });

    test('is due after the scheduled time has passed', () {
      expect(IsScheduledMessageDue.call(message(now.subtract(const Duration(minutes: 1))), now), isTrue);
    });
  });
}
