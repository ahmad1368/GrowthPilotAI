import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/unarchive_conversation.dart';
import 'package:growth_pilot_ai/core/data/entities/conversation_entity.dart';
import 'package:growth_pilot_ai/core/enum/conversation_status.dart';

ConversationEntity _conversation(ConversationStatus status) => ConversationEntity(
      subject: 'BC Hydro',
      participantIds: const ['me', 'vendor-bc-hydro'],
      lastMessageAt: DateTime(2026, 1, 1),
      dbStatus: status.index,
    );

void main() {
  test('an ARCHIVED conversation is restored to ACTIVE (Undo)', () {
    final conversation = _conversation(ConversationStatus.archived);

    final applied = UnarchiveConversation.call(conversation);

    expect(applied, isTrue);
    expect(conversation.isArchived, isFalse);
  });

  test('an already-active conversation is a no-op', () {
    final conversation = _conversation(ConversationStatus.active);

    expect(UnarchiveConversation.call(conversation), isFalse);
  });
}
