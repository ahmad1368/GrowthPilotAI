import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/controllers/support_chat_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/settings/widgets/support_message_bubble.dart';

/// Local mock support chat (Issue #193) — the on-device replacement
/// for an Intercom/Zendesk Messenger; see [SupportChatController] and
/// PR notes.
class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final _controller = Get.find<SupportChatController>();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.markAllRead();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _send() {
    if (_textController.text.trim().isEmpty) return;
    _controller.sendMessage(_textController.text.trim());
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Bug fix: this screen never had a ShadTheme ancestor, so
    // ShadTheme.of(context) here and in SupportMessageBubble would
    // throw as soon as this rendered - same class of bug as #189's fix.
    final shadTheme = AppShadTheme.build(Theme.of(context).brightness);
    final colors = shadTheme.colorScheme;
    return ShadTheme(
      data: shadTheme,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(title: const Text('Support'), backgroundColor: colors.background),
        body: Column(children: [
          Expanded(
            child: Obx(() => ListView(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  children: [for (final m in _controller.thread) SupportMessageBubble(message: m)],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              Expanded(
                  child: ShadInput(
                      controller: _textController, placeholder: const Text('Describe your issue...'))),
              const SizedBox(width: 8),
              ShadButton(onPressed: _send, child: const Text('Send')),
            ]),
          ),
        ]),
      ),
    );
  }
}
