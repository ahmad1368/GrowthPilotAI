import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/ai_engine_controller.dart';
import 'package:growth_pilot_ai/core/enum/model_download_status.dart';
import 'package:growth_pilot_ai/features/ai_engine/widgets/model_download_action_button.dart';

/// Download progress + Pause/Resume controls (Issue #196 scaffolding).
class ModelDownloadProgressCard extends StatelessWidget {
  final AiEngineController controller;
  const ModelDownloadProgressCard({super.key, required this.controller});

  String _label(ModelDownloadStatus status) => switch (status) {
        ModelDownloadStatus.notStarted => 'Not started',
        ModelDownloadStatus.downloading => 'Downloading…',
        ModelDownloadStatus.paused => 'Paused',
        ModelDownloadStatus.completed => 'Ready',
        ModelDownloadStatus.failed => 'Failed',
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = controller.downloadState.value;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(_label(state.status), style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(value: state.progress, minHeight: 6),
        ),
        const SizedBox(height: 4),
        Text('${(state.progress * 100).toStringAsFixed(0)}%',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
        const SizedBox(height: 12),
        Text('Model files aren\'t hosted yet — this previews the download experience.',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
        const SizedBox(height: 12),
        ModelDownloadActionButton(controller: controller),
      ]),
    );
  }
}
