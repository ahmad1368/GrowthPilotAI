import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/ignore_anomaly_merchant.dart';
import 'package:growth_pilot_ai/core/data/entities/ignored_merchant_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/ignored_merchant_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/message_repository.dart';

/// Extracted from [InboxController] (Issue #74) to keep that file within
/// the 50-line limit: tracks in-flight "Ignore for this Merchant" taps,
/// applies [IgnoreAnomalyMerchant], and persists the merchant into the
/// false-positive suppression list. The delay stands in for the backend
/// round-trip, making the anti-double-tap guard ([isIgnoring]) visible in
/// the UI.
class AnomalyIgnoreHandler {
  final MessageRepository _messages;
  final IgnoredMerchantRepository _ignoredMerchants;
  final _ignoringConversationIds = <int>{}.obs;

  AnomalyIgnoreHandler(this._messages, this._ignoredMerchants);

  bool isIgnoring(int conversationId) =>
      _ignoringConversationIds.contains(conversationId);

  Future<void> ignore(int conversationId, int messageId) async {
    if (_ignoringConversationIds.contains(conversationId)) return;
    _ignoringConversationIds.add(conversationId);
    await Future.delayed(const Duration(milliseconds: 500));
    final message = _messages
        .getForConversation(conversationId)
        .firstWhere((m) => m.id == messageId);
    if (IgnoreAnomalyMerchant.call(message)) {
      _messages.upsert(message);
      final merchant = message.actionCardMerchantName;
      if (merchant != null) {
        _ignoredMerchants.upsert(IgnoredMerchantEntity(merchantName: merchant));
      }
    }
    _ignoringConversationIds.remove(conversationId);
  }
}
