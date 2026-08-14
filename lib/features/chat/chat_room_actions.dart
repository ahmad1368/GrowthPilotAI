import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/chat_gateway_controller.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_forward_room_picker.dart';

/// Send/reply/forward interaction logic for [ChatRoomView], kept out of
/// the widget's State class for SRP (Issue #132).
class ChatRoomActions {
  final ChatGatewayController controller;
  final String currentUserId;

  ChatRoomActions(this.controller, this.currentUserId);

  void send(String text, ChatRoomMessageEntity? replyingTo) {
    if (replyingTo == null) {
      controller.sendMessage(currentUserId, text);
    } else {
      controller.sendReply(currentUserId, text, replyingTo);
    }
  }

  void sendAttachment(String fileName, String mimeType, Uint8List bytes) =>
      controller.sendAttachment(currentUserId, fileName, mimeType, bytes);

  void forward(BuildContext context, ChatRoomMessageEntity message) {
    showChatForwardRoomPicker(
      context,
      rooms: controller.forwardableRooms(currentUserId),
      forwarderId: currentUserId,
      onSelect: (room) => controller.forwardMessage(message, room.id, currentUserId),
    );
  }
}
