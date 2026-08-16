import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_stub_assistant_reply.dart';
import 'package:growth_pilot_ai/business/should_clear_chat_session.dart';
import 'package:growth_pilot_ai/controllers/chat_feedback_recorder.dart';
import 'package:growth_pilot_ai/controllers/chat_reply_streamer.dart';
import 'package:growth_pilot_ai/controllers/quick_prompts_provider.dart';
import 'package:growth_pilot_ai/core/enum/feedback_reason.dart';
import 'package:growth_pilot_ai/core/models/chat_message.dart';

/// Floating Financial Assistant chat state (Issues #200/#201/#209).
class AiChatController extends GetxController {
  final isOpen = false.obs;
  final isMinimized = false.obs;
  final messages = <ChatMessage>[].obs;
  final currentScreenId = 'general'.obs;
  final prompts = QuickPromptsProvider();
  DateTime? _lastActivityAt;

  List<String> get quickPrompts => prompts.forScreen(currentScreenId.value);

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

  void submitFeedback(String messageId, bool isHelpful, {FeedbackReason? reason}) =>
      ChatFeedbackRecorder.call(messages, messageId, isHelpful, reason: reason);
  Future<void> tapQuickPrompt(String prompt) async {
    prompts.recordClick(prompt);
    await sendMessage(prompt);
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
