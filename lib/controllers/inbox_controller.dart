import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_conversation_summary.dart';
import 'package:growth_pilot_ai/business/filter_conversations_by_query.dart';
import 'package:growth_pilot_ai/business/seed_demo_inbox_data.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/conversation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/message_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/unified_transaction_repository.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';

/// Drives the Inbox screen (Issue #72): seeds demo threads (Issue #70),
/// resolves each conversation's linked-transaction amount (Issue #69), and
/// exposes a searchable, most-recent-first summary list.
class InboxController extends GetxController {
  late ConversationRepository _conversations;
  late MessageRepository _messages;
  late UnifiedTransactionRepository _transactions;

  final searchQuery = ''.obs;
  final _summaries = <ConversationSummary>[].obs;

  List<ConversationSummary> get visibleSummaries =>
      FilterConversationsByQuery.call(_summaries, searchQuery.value);

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _conversations = ConversationRepository(store.box());
    _messages = MessageRepository(store.box());
    _transactions = UnifiedTransactionRepository(store.box());

    _transactions.seedIfEmpty();
    SeedDemoInboxData.call(_conversations, _messages);
    _reload();
  }

  void _reload() {
    final txAmountByExternalId = {
      for (final tx in _transactions.getAll()) tx.externalId: tx.amount,
    };
    final summaries = _conversations.getAll().map((conversation) {
      final messages = _messages.getForConversation(conversation.id);
      final amount = conversation.contextRefId == null
          ? null
          : txAmountByExternalId[conversation.contextRefId];
      return BuildConversationSummary.call(conversation, messages, amount);
    }).toList()
      ..sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    _summaries.assignAll(summaries);
  }
}
