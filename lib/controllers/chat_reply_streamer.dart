import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/verify_ai_response.dart';
import 'package:growth_pilot_ai/core/models/chat_message.dart';

/// Streams [reply] into the message at [messageId] word-by-word (Issue
/// #200's "Token Streaming"), firing a haptic per paragraph break and
/// once more at the end, then runs Issue #203's Verification Engine
/// over the completed text against [contextAmounts] — the real figures
/// the AI was actually given as RAG context.
class ChatReplyStreamer {
  static Future<void> call(RxList<ChatMessage> messages, String messageId, String reply,
      [List<double> contextAmounts = const []]) async {
    final words = reply.split(' ');
    var soFar = '';
    for (var i = 0; i < words.length; i++) {
      await Future.delayed(const Duration(milliseconds: 40));
      soFar = soFar.isEmpty ? words[i] : '$soFar ${words[i]}';
      final index = messages.indexWhere((m) => m.id == messageId);
      if (index != -1) messages[index] = messages[index].copyWith(text: soFar);
      if (words[i].contains('\n\n') || i == words.length - 1) HapticFeedback.lightImpact();
    }
    final finalIndex = messages.indexWhere((m) => m.id == messageId);
    if (finalIndex != -1) {
      messages[finalIndex] =
          messages[finalIndex].copyWith(verification: VerifyAiResponse.call(soFar, contextAmounts));
    }
  }
}
