import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/seed_demo_conversations.dart';
import 'package:growth_pilot_ai/core/enum/conversation_context_type.dart';

void main() {
  test('links the Home Depot thread to the Issue #69 duplicate transaction', () {
    final conversations = SeedDemoConversations.call();

    expect(conversations.length, 2);
    final homeDepot = conversations.first;
    expect(homeDepot.contextType, ConversationContextType.transaction);
    expect(homeDepot.contextRefId, 'plaid-hd-451');
    expect(homeDepot.hasContext, isTrue);
  });

  test('the second demo thread has no contextual link', () {
    final conversations = SeedDemoConversations.call();

    final bcHydro = conversations[1];
    expect(bcHydro.hasContext, isFalse);
    expect(bcHydro.contextType, ConversationContextType.none);
  });
}
