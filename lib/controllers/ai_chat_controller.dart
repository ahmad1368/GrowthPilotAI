import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_quick_prompts.dart';
import 'package:growth_pilot_ai/business/build_stub_assistant_reply.dart';
import 'package:growth_pilot_ai/business/should_clear_chat_session.dart';
import 'package:growth_pilot_ai/controllers/chat_reply_streamer.dart';
import 'package:growth_pilot_ai/core/models/chat_message.dart';

/// Floating Financial Assistant chat state (Issue #200) — streams a
/// stub reply word-by-word since no real inference exists yet.
class AiChatController extends GetxController {
  final isOpen = false.obs;
  final isMinimized = false.obs;
  final messages = <ChatMessage>[].obs;
  final currentScreenId = 'general'.obs;
  DateTime? _lastActivityAt;

  List<String> get quickPrompts => BuildQuickPrompts.call(currentScreenId.value);

  void open() {
    checkSessionExpiry();
    isOpen.value = true;
    isMinimized.value = false;
  }

  void minimize() => isMinimized.value = true;

  void close() => isOpen.value = false;

  void checkSessionExpiry() {
    if (ShouldClearChatSession.call(_lastActivityAt, DateTime.now())) messages.clear();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    _lastActivityAt = DateTime.now();
    messages.add(ChatMessage(id: _newId(), isFromUser: true, text: text, createdAt: DateTime.now()));
    final assistantId = _newId();
    messages.add(ChatMessage(id: assistantId, isFromUser: false, text: '', createdAt: DateTime.now()));
    await ChatReplyStreamer.call(messages, assistantId, BuildStubAssistantReply.call());
  }

  String _newId() => DateTime.now().microsecondsSinceEpoch.toString();
}
