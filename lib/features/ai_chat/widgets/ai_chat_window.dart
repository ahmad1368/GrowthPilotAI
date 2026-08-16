import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/ai_chat_controller.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/ai_chat_disclaimer.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/ai_chat_empty_state.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/ai_chat_header.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/ai_chat_input_bar.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/ai_chat_message_list.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/animated_prompt_entrance.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/quick_prompt_chips.dart';

/// The chat window body (Issue #200/#201) — flat surface, not the
/// issue's literal Glassmorphism ask (this app's architecture forbids
/// BackdropFilter).
class AiChatWindow extends StatelessWidget {
  const AiChatWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AiChatController>();
    final theme = Theme.of(context);

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(16),
      color: theme.brightness == Brightness.dark ? const Color(0xFF18181B) : Colors.white,
      child: SizedBox(
        width: 320,
        height: 440,
        child: Column(children: [
          AiChatHeader(onMinimize: controller.minimize, onClose: controller.close),
          const Divider(height: 1),
          Expanded(child: Obx(() => controller.messages.isEmpty
              ? const AiChatEmptyState()
              : AiChatMessageList(messages: controller.messages))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AnimatedPromptEntrance(
              child: Obx(() => QuickPromptChips(
                  prompts: controller.quickPrompts, onTap: controller.tapQuickPrompt)),
            ),
          ),
          AiChatInputBar(onSubmit: controller.sendMessage),
          const AiChatDisclaimer(),
        ]),
      ),
    );
  }
}
