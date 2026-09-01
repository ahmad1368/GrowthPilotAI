import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/ai_engine_controller.dart';
import 'package:growth_pilot_ai/features/ai_engine/widgets/model_download_consent_gate.dart';
import 'package:growth_pilot_ai/features/ai_engine/widgets/model_download_progress_card.dart';

/// "AI Engine" settings page (Issue #196) — consent gate, then the
/// model download preview. Flat design (no Glassmorphism/BackdropFilter,
/// per this app's architecture).
class AiEngineScreen extends StatelessWidget {
  const AiEngineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AiEngineController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('AI Engine')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => controller.hasConsented.value
            ? ModelDownloadProgressCard(controller: controller)
            : ModelDownloadConsentGate(controller: controller)),
      ),
    );
  }
}
