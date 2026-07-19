import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/inbox_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/conversation_list.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Main Inbox screen (Issue #72): searchable, most-recent-first
/// [ConversationList]. Flat shadcn_ui per the design-system pivot.
class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final controller = Get.find<InboxController>();

    return ShadTheme(
      data: AppShadTheme.build(brightness),
      child: Scaffold(
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : const Color(0xFFFFFFFF),
        appBar: AppBar(title: const Text('Inbox')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ShadInput(
                placeholder: const Text('Search conversations'),
                onChanged: (value) => controller.searchQuery.value = value,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Obx(() {
                  final summaries = controller.visibleSummaries;
                  if (summaries.isEmpty) {
                    return const Center(child: Text('No conversations yet'));
                  }
                  return ConversationList(
                      controller: controller, summaries: summaries);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
