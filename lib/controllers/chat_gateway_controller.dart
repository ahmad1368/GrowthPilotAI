import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/chat_connection_authorizer.dart';
import 'package:growth_pilot_ai/controllers/chat_message_relay_handler.dart';
import 'package:growth_pilot_ai/controllers/chat_read_receipt_handler.dart';
import 'package:growth_pilot_ai/controllers/chat_room_join_handler.dart';
import 'package:growth_pilot_ai/controllers/chat_room_presence_handler.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/auth_session_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_message_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_repository.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';

/// Drives a single marketplace chat room (Issue #122/#131); delegates to
/// the Chat* handler classes for SRP.
class ChatGatewayController extends GetxController {
  late ChatRoomJoinHandler _join;
  late ChatRoomPresenceHandler _presence;
  late ChatMessageRelayHandler _relay;
  late ChatReadReceiptHandler _readReceipts;
  ChatRoomEntity? room;

  final messages = <ChatRoomMessageEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    final rooms = ChatRoomRepository(store.box());
    final gateway = DependencyInjection.get<ChatGatewayService>();
    final messageRepo = ChatRoomMessageRepository(store.box());
    _relay = ChatMessageRelayHandler(messageRepo, gateway, messages);
    _readReceipts = ChatReadReceiptHandler(messageRepo, messages);
    _presence = ChatRoomPresenceHandler(rooms);
    _join = ChatRoomJoinHandler(rooms,
        ChatConnectionAuthorizer(AuthSessionRepository(store.box())), _relay, gateway);
  }

  /// Returns false without joining if there is no valid, unexpired
  /// session (Issue #131 AC: JWT-authenticated connections).
  bool openRoom(String currentUserId, String otherUserId) {
    final joined = _join.open(currentUserId, otherUserId);
    room = joined;
    return joined != null;
  }

  Future<bool> sendMessage(String senderId, String body) =>
      _relay.send(senderId, body);

  void markMessagesRead(String readerId) => _readReceipts.markRead(readerId);

  void toggleOtherOnline() => _presence.toggleOnline(room!);

  void toggleOtherTyping() => _presence.toggleTyping(room!);

  @override
  void onClose() {
    _join.close();
    _relay.dispose();
    super.onClose();
  }
}
