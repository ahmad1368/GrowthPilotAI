import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_action_card_data.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/enum/message_content_type.dart';

MessageEntity _plainMessage() => MessageEntity(
      conversationId: 1,
      senderId: 'vendor',
      body: 'hello',
      createdAt: DateTime(2026, 1, 1),
    );

MessageEntity _actionCardMessage({int status = 0}) => MessageEntity(
      id: 9,
      conversationId: 1,
      senderId: 'system',
      body: 'Approve the charge',
      dbContentType: MessageContentType.actionCard.index,
      dbActionCardType: ActionCardType.approveTransaction.index,
      dbActionCardStatus: status,
      actionCardAmount: 450.0,
      actionCardTransactionRefId: 'plaid-hd-451',
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  test('returns null for a plain text message', () {
    expect(ParseActionCardData.call(_plainMessage()), isNull);
  });

  test('parses an ACTION_CARD message into its display data', () {
    final data = ParseActionCardData.call(_actionCardMessage());

    expect(data, isNotNull);
    expect(data!.messageId, 9);
    expect(data.actionType, ActionCardType.approveTransaction);
    expect(data.status, ActionCardStatus.pending);
    expect(data.amount, 450.0);
    expect(data.transactionRefId, 'plaid-hd-451');
    expect(data.isPending, isTrue);
  });

  test('a COMPLETED action card is no longer pending', () {
    final data = ParseActionCardData.call(
        _actionCardMessage(status: ActionCardStatus.completed.index));
    expect(data!.isPending, isFalse);
  });
}
