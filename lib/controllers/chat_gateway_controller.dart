import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/list_forwardable_chat_rooms.dart';
import 'package:growth_pilot_ai/controllers/chat_connection_authorizer.dart';
import 'package:growth_pilot_ai/business/dispatch_due_scheduled_messages.dart';
import 'package:growth_pilot_ai/business/dispatch_notification_usecase.dart';
import 'package:growth_pilot_ai/controllers/chat_forward_handler.dart';
import 'package:growth_pilot_ai/controllers/chat_message_relay_handler.dart';
import 'package:growth_pilot_ai/controllers/chat_notification_handler.dart';
import 'package:growth_pilot_ai/controllers/chat_read_receipt_handler.dart';
import 'package:growth_pilot_ai/controllers/chat_room_join_handler.dart';
import 'package:growth_pilot_ai/controllers/chat_room_presence_handler.dart';
import 'package:growth_pilot_ai/controllers/moderation_controller.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/auth_session_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_message_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/inbox_notification_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/scheduled_chat_message_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/scheduled_chat_message_repository.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/enum/moderation_reason.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';

/// Drives a single marketplace chat room (Issue #122/#131); delegates to
/// the Chat* handler classes for SRP.
class ChatGatewayController extends GetxController {
  late ChatRoomJoinHandler _join;
  late ChatRoomPresenceHandler _presence;
  late ChatMessageRelayHandler _relay;
  late ChatReadReceiptHandler _readReceipts;
  late ChatForwardHandler _forward;
  late ChatNotificationHandler _notifications;
  late ModerationController _moderation;
  late ChatRoomRepository _rooms;
  late ScheduledChatMessageRepository _scheduled;
  final _room = Rx<ChatRoomEntity?>(null);
  ChatRoomEntity? get room => _room.value;

  final messages = <ChatRoomMessageEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _rooms = ChatRoomRepository(store.box());
    _scheduled = ScheduledChatMessageRepository(store.box());
    final gateway = DependencyInjection.get<ChatGatewayService>();
    final messageRepo = ChatRoomMessageRepository(store.box());
    _relay = ChatMessageRelayHandler(messageRepo, gateway, messages);
    _readReceipts = ChatReadReceiptHandler(messageRepo, messages);
    _presence = ChatRoomPresenceHandler(_rooms);
    _forward = ChatForwardHandler(_rooms, messageRepo);
    _notifications = ChatNotificationHandler(gateway,
        DependencyInjection.get<DispatchNotificationUseCase>(), InboxNotificationRepository(store.box()));
    _moderation = Get.isRegistered<ModerationController>()
        ? Get.find<ModerationController>()
        : Get.put(ModerationController());
    _join = ChatRoomJoinHandler(_rooms,
        ChatConnectionAuthorizer(AuthSessionRepository(store.box())), _relay, gateway);
  }

  /// Returns false without joining if there is no valid, unexpired
  /// session (Issue #131 AC: JWT-authenticated connections).
  bool openRoom(String currentUserId, String otherUserId) {
    _room.value = _join.open(currentUserId, otherUserId);
    if (room != null) {
      _notifications.currentUserId = currentUserId;
      _notifications.roomId = room!.id;
      _relay.isSenderBlocked = (senderId) => _moderation.isBlocked(currentUserId, senderId);
      // Issue #317 feature #20 — fire-and-forget, mirrors #440's
      // scan-on-visit trigger shape.
      DispatchDueScheduledMessages.call(_scheduled, _relay, room!.id, DateTime.now());
    }
    return room != null;
  }

  /// "Message Scheduling" (Issue #317 feature #20) — held until
  /// [scheduledFor], dispatched the next time this room is opened.
  void scheduleMessage(String senderId, String body, DateTime scheduledFor) {
    _scheduled.insert(ScheduledChatMessageEntity(
        roomId: room!.id, senderId: senderId, body: body, scheduledFor: scheduledFor, createdAt: DateTime.now()));
  }

  bool isPeerBlocked(String currentUserId, String otherUserId) =>
      _moderation.isBlocked(currentUserId, otherUserId);

  void blockPeer(String currentUserId, String otherUserId) =>
      _moderation.blockUser(currentUserId, otherUserId);

  void reportPeer(String reporterId, String targetId, ModerationReason reason) =>
      _moderation.submitReport(reporterId, targetId, reason, messages);

  Future<bool> sendMessage(String senderId, String body, {bool isSilent = false}) =>
      _relay.send(senderId, body, isSilent: isSilent);

  Future<bool> sendReply(String senderId, String body, ChatRoomMessageEntity parent) =>
      _relay.sendReply(senderId, body, parent);

  Future<bool> sendAttachment(
          String senderId, String fileName, String mimeType, Uint8List bytes) =>
      _relay.sendAttachment(senderId, fileName, mimeType, bytes);

  /// "Delete for Everyone" (Issue #317 feature #19).
  Future<bool> deleteMessage(ChatRoomMessageEntity message) => _relay.deleteMessage(message);

  /// "Message Editing" (Issue #317 feature #18).
  Future<bool> editMessage(ChatRoomMessageEntity message, String newBody) =>
      _relay.editMessage(message, newBody);

  /// Pin/unpin (Issue #317 feature #22).
  Future<bool> togglePin(ChatRoomMessageEntity message) => _relay.togglePin(message);

  bool forwardMessage(ChatRoomMessageEntity original, int targetRoomId, String forwarderId) =>
      _forward.forward(original, targetRoomId, forwarderId);

  List<ChatRoomEntity> forwardableRooms(String userId) =>
      ListForwardableChatRooms.call(_rooms.getAll(), userId, room?.id ?? 0);

  void markMessagesRead(String readerId) => _readReceipts.markRead(readerId);

  void toggleOtherOnline() {
    _presence.toggleOnline(room!);
    _room.refresh();
  }

  /// "Custom Chat Themes" (Issue #317 feature #25).
  void setRoomTheme(String? hex) {
    room!.themeColorHex = hex;
    _rooms.upsert(room!);
    _room.refresh();
  }

  void toggleOtherTyping() {
    _presence.toggleTyping(room!);
    _room.refresh();
  }

  @override
  void onClose() {
    _join.close();
    _relay.dispose();
    _notifications.dispose();
    super.onClose();
  }
}
