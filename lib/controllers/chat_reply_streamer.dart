import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/models/chat_message.dart';

/// Streams [reply] into the message at [messageId] word-by-word (Issue
/// #200's "Token Streaming"/StreamBuilder AC), firing a haptic per
/// paragraph break and once more at the end (AC: "haptic... for each
/// new paragraph").
class ChatReplyStreamer {
  static Future<void> call(RxList<ChatMessage> messages, String messageId, String reply) async {
    final words = reply.split(' ');
    var soFar = '';
    for (var i = 0; i < words.length; i++) {
      await Future.delayed(const Duration(milliseconds: 40));
      soFar = soFar.isEmpty ? words[i] : '$soFar ${words[i]}';
      final index = messages.indexWhere((m) => m.id == messageId);
      if (index != -1) messages[index] = messages[index].copyWith(text: soFar);
      if (words[i].contains('\n\n') || i == words.length - 1) HapticFeedback.lightImpact();
    }
  }
}
