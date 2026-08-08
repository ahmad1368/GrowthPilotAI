import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/find_or_create_chat_room.dart';
import 'package:growth_pilot_ai/controllers/chat_message_relay_handler.dart';
import 'package:growth_pilot_ai/controllers/chat_room_presence_handler.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_message_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_repository.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';

/// Drives a single marketplace chat room (Issue #122); delegates to
/// [ChatMessageRelayHandler]/[ChatRoomPresenceHandler] for SRP.
class ChatGatewayController extends GetxController {
  late ChatRoomRepository _rooms;
  late ChatGatewayService _gateway;
  late ChatRoomPresenceHandler _presence;
  late ChatMessageRelayHandler _relay;
  late ChatRoomEntity room;

  final messages = <ChatRoomMessageEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _rooms = ChatRoomRepository(store.box());
    _gateway = DependencyInjection.get<ChatGatewayService>();
    _presence = ChatRoomPresenceHandler(_rooms);
    _relay = ChatMessageRelayHandler(
        ChatRoomMessageRepository(store.box()), _gateway, messages);
  }

  void openRoom(String currentUserId, String otherUserId) {
    room = FindOrCreateChatRoom.call(
        _rooms.getAll(), currentUserId, otherUserId, DateTime.now());
    room.id = _rooms.upsert(room);
    _relay.openRoom(room.id);
    _gateway.connect(currentUserId);
  }

  Future<bool> sendMessage(String senderId, String body) =>
      _relay.send(senderId, body);

  void toggleOtherOnline() => _presence.toggleOnline(room);

  void toggleOtherTyping() => _presence.toggleTyping(room);

  @override
  void onClose() {
    _relay.dispose();
    super.onClose();
  }
}
