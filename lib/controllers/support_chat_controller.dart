import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_auto_support_reply.dart';
import 'package:growth_pilot_ai/business/redact_sensitive_support_info.dart';
import 'package:growth_pilot_ai/core/data/entities/support_message_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/support_message_repository.dart';
import 'package:growth_pilot_ai/core/enum/support_message_sender.dart';

/// Drives the local mock support chat (Issue #193) — a self-contained
/// on-device replacement for an Intercom/Zendesk SDK (no third-party
/// account/backend exists in this repo; see PR notes).
class SupportChatController extends GetxController {
  static const businessId = 'local-user';

  late SupportMessageRepository _messages;
  final thread = <SupportMessageEntity>[].obs;
  final unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _messages = SupportMessageRepository(Get.find<ObjectBox>().store.box());
    _refresh();
  }

  void _refresh() {
    thread.assignAll(_messages.getForBusiness(businessId));
    unreadCount.value = _messages.unreadCount(businessId);
  }

  void sendMessage(String text) {
    final safeText = RedactSensitiveSupportInfo.call(text);
    final now = DateTime.now();
    _messages.append(SupportMessageEntity(
      businessId: businessId,
      dbSender: SupportMessageSender.user.index,
      body: safeText,
      sentAt: now,
      isRead: true,
    ));
    _messages.append(SupportMessageEntity(
      businessId: businessId,
      dbSender: SupportMessageSender.agent.index,
      body: BuildAutoSupportReply.call(safeText),
      sentAt: now.add(const Duration(seconds: 1)),
    ));
    _refresh();
  }

  void markAllRead() {
    _messages.markAllRead(businessId);
    _refresh();
  }
}
