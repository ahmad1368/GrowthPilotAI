import 'dart:async';

import 'package:growth_pilot_ai/business/batch_chat_notifications.dart';
import 'package:growth_pilot_ai/business/dispatch_notification_usecase.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/inbox_notification_repository.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';

/// Push-notification dispatch for new chat messages (Issue #137) — reuses
/// the existing Socket.io/FCM-abstracting pipeline from #71 rather than
/// adding a real `firebase_messaging` dependency this repo has no
/// Firebase project to back. Listens to the gateway directly (not via
/// [ChatMessageRelayHandler]) so it stays independent of the optimistic
/// send/receive bookkeeping.
class ChatNotificationHandler {
  final DispatchNotificationUseCase _dispatch;
  final InboxNotificationRepository _notifications;
  late final StreamSubscription<ChatRoomMessageEntity> _subscription;
  String currentUserId = '';
  int roomId = 0;

  ChatNotificationHandler(ChatGatewayService gateway, this._dispatch, this._notifications) {
    _subscription = gateway.incomingMessages.listen(_onMessage);
  }

  Future<void> _onMessage(ChatRoomMessageEntity message) async {
    if (message.roomId != roomId || message.senderId == currentUserId) return;
    final now = DateTime.now();
    final recent = _notifications.since(now.subtract(const Duration(hours: 1)));
    final notification = BatchChatNotifications.call(recent, message.senderId, roomId, now);
    _notifications.upsert(notification);
    await _dispatch.dispatch(notification, recent);
  }

  void dispose() => _subscription.cancel();
}
