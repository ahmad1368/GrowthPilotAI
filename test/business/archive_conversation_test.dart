import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/archive_conversation.dart';
import 'package:growth_pilot_ai/core/data/entities/conversation_entity.dart';
import 'package:growth_pilot_ai/core/enum/conversation_status.dart';

ConversationEntity _conversation(ConversationStatus status) => ConversationEntity(
      subject: 'BC Hydro',
      participantIds: const ['me', 'vendor-bc-hydro'],
      lastMessageAt: DateTime(2026, 1, 1),
      dbStatus: status.index,
    );

void main() {
  test('an ACTIVE conversation is marked ARCHIVED and reports it applied', () {
    final conversation = _conversation(ConversationStatus.active);

    final applied = ArchiveConversation.call(conversation);

    expect(applied, isTrue);
    expect(conversation.isArchived, isTrue);
  });

  test('an already-archived conversation is a no-op', () {
    final conversation = _conversation(ConversationStatus.archived);

    expect(ArchiveConversation.call(conversation), isFalse);
  });
}
