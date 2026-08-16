import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/ai_engine_controller.dart';
import 'package:growth_pilot_ai/core/enum/model_download_status.dart';

/// The single relevant action for the current download status (Issue
/// #196) — Start/Pause/Resume, or nothing once completed/failed.
class ModelDownloadActionButton extends StatelessWidget {
  final AiEngineController controller;
  const ModelDownloadActionButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    switch (controller.downloadState.value.status) {
      case ModelDownloadStatus.notStarted:
        return ElevatedButton(onPressed: controller.startDownload, child: const Text('Start'));
      case ModelDownloadStatus.downloading:
        return OutlinedButton(onPressed: controller.pause, child: const Text('Pause'));
      case ModelDownloadStatus.paused:
        return ElevatedButton(onPressed: controller.resume, child: const Text('Resume'));
      case ModelDownloadStatus.completed:
      case ModelDownloadStatus.failed:
        return const SizedBox.shrink();
    }
  }
}
