import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/chat_gateway_controller.dart';
import 'package:growth_pilot_ai/features/chat/widgets/chat_report_reason_picker.dart';

/// Block/Report interaction logic for [ChatRoomView] (Issue #124/#134),
/// kept out of the widget's State class for SRP.
class ChatModerationActions {
  final ChatGatewayController controller;
  final String currentUserId;
  final String otherUserId;

  ChatModerationActions(this.controller, this.currentUserId, this.otherUserId);

  /// "Instant Feedback" AC: block, then leave the chat immediately.
  void block(BuildContext context) {
    controller.blockPeer(currentUserId, otherUserId);
    Navigator.of(context).maybePop();
  }

  void report(BuildContext context) {
    showChatReportReasonPicker(
      context,
      (reason) => controller.reportPeer(currentUserId, otherUserId, reason),
    );
  }
}
