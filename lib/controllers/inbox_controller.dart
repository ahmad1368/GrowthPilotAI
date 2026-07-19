import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/filter_conversations_by_query.dart';
import 'package:growth_pilot_ai/business/load_inbox_summaries.dart';
import 'package:growth_pilot_ai/business/seed_demo_inbox_data.dart';
import 'package:growth_pilot_ai/controllers/action_card_approval_handler.dart';
import 'package:growth_pilot_ai/controllers/anomaly_ignore_handler.dart';
import 'package:growth_pilot_ai/controllers/smart_recommendation_handler.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/conversation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/ignored_merchant_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/message_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/recommendation_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/unified_transaction_repository.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';

/// Drives the Inbox screen (Issue #72): seeds demo threads (Issue #70),
/// resolves each conversation's linked-transaction amount (Issue #69), and
/// exposes a searchable, most-recent-first summary list. ACTION_CARD
/// approvals (Issue #73), anomaly dismissals (Issue #74) and Smart
/// Recommendation actions (Issue #75) are delegated to
/// [ActionCardApprovalHandler]/[AnomalyIgnoreHandler]/
/// [SmartRecommendationHandler] to stay under the 50-line file limit.
class InboxController extends GetxController {
  late ConversationRepository _conversations;
  late MessageRepository _messages;
  late UnifiedTransactionRepository _transactions;
  late ActionCardApprovalHandler _approvalHandler;
  late AnomalyIgnoreHandler _anomalyIgnoreHandler;
  late SmartRecommendationHandler _recommendationHandler;

  final searchQuery = ''.obs;
  final _summaries = <ConversationSummary>[].obs;

  List<ConversationSummary> get visibleSummaries =>
      FilterConversationsByQuery.call(_summaries, searchQuery.value);

  bool isApprovingAction(int conversationId) =>
      _approvalHandler.isApproving(conversationId);

  bool isIgnoringAnomaly(int conversationId) =>
      _anomalyIgnoreHandler.isIgnoring(conversationId);

  bool isProcessingRecommendation(int conversationId) =>
      _recommendationHandler.isProcessing(conversationId);

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _conversations = ConversationRepository(store.box());
    _messages = MessageRepository(store.box());
    _transactions = UnifiedTransactionRepository(store.box());
    _approvalHandler = ActionCardApprovalHandler(_messages);
    _anomalyIgnoreHandler = AnomalyIgnoreHandler(
        _messages, IgnoredMerchantRepository(store.box()));
    _recommendationHandler = SmartRecommendationHandler(
        _messages, RecommendationLogRepository(store.box()));

    _transactions.seedIfEmpty();
    SeedDemoInboxData.call(_conversations, _messages);
    _reload();
  }

  void _reload() {
    _summaries.assignAll(
        LoadInboxSummaries.call(_conversations, _messages, _transactions));
  }

  Future<void> approveAction(int conversationId, int messageId) async {
    await _approvalHandler.approve(conversationId, messageId);
    _reload();
  }

  Future<void> ignoreAnomalyMerchant(int conversationId, int messageId) async {
    await _anomalyIgnoreHandler.ignore(conversationId, messageId);
    _reload();
  }

  Future<void> dismissRecommendation(int conversationId, int messageId) async {
    await _recommendationHandler.dismiss(conversationId, messageId);
    _reload();
  }

  Future<void> snoozeRecommendation(int conversationId, int messageId) async {
    await _recommendationHandler.snooze(conversationId, messageId);
    _reload();
  }

  Future<void> actOnRecommendation(RecommendationType type) =>
      _recommendationHandler.act(type);
}
