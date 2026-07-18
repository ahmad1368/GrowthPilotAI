import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/approve_action_card.dart';
import 'package:growth_pilot_ai/business/filter_conversations_by_query.dart';
import 'package:growth_pilot_ai/business/load_inbox_summaries.dart';
import 'package:growth_pilot_ai/business/seed_demo_inbox_data.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/conversation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/message_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/unified_transaction_repository.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';

/// Drives the Inbox screen (Issue #72): seeds demo threads (Issue #70),
/// resolves each conversation's linked-transaction amount (Issue #69),
/// exposes a searchable, most-recent-first summary list, and processes
/// ACTION_CARD approvals (Issue #73).
class InboxController extends GetxController {
  late ConversationRepository _conversations;
  late MessageRepository _messages;
  late UnifiedTransactionRepository _transactions;

  final searchQuery = ''.obs;
  final _summaries = <ConversationSummary>[].obs;
  final _approvingConversationIds = <int>{}.obs;

  List<ConversationSummary> get visibleSummaries =>
      FilterConversationsByQuery.call(_summaries, searchQuery.value);

  bool isApprovingAction(int conversationId) =>
      _approvingConversationIds.contains(conversationId);

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
    _summaries.assignAll(
        LoadInboxSummaries.call(_conversations, _messages, _transactions));
  }

  /// Approves a PENDING action card. The delay stands in for the backend
  /// round-trip, making the anti-double-tap guard ([isApprovingAction])
  /// visible in the UI.
  Future<void> approveAction(int conversationId, int messageId) async {
    if (_approvingConversationIds.contains(conversationId)) return;
    _approvingConversationIds.add(conversationId);
    await Future.delayed(const Duration(milliseconds: 500));
    final message = _messages
        .getForConversation(conversationId)
        .firstWhere((m) => m.id == messageId);
    if (ApproveActionCard.call(message)) _messages.upsert(message);
    _reload();
    _approvingConversationIds.remove(conversationId);
  }
}
