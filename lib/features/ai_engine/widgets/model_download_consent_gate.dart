import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/ai_engine_controller.dart';

/// Explicit consent step before the ~2GB model download starts (Issue
/// #196 AC: "Consent... to avoid unexpected data charges", Issue #183).
class ModelDownloadConsentGate extends StatelessWidget {
  final AiEngineController controller;
  const ModelDownloadConsentGate({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('On-Device AI', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          'Downloading the on-device AI model uses about 2GB of data and storage. '
          'It only needs to happen once, and your financial data never leaves this device.',
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: controller.grantConsent,
          child: const Text('I understand, continue'),
        ),
      ]),
    );
  }
}
