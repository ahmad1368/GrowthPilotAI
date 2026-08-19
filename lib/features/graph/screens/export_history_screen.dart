import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/export_history_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/export_history_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "The exported file remains accessible even if the app is closed"
/// (Issue #253) — a local list of every export/share event (#250),
/// each re-shareable within its 48h retention window.
class ExportHistoryScreen extends StatelessWidget {
  const ExportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final controller = Get.find<ExportHistoryController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: const Text('Export History'), backgroundColor: colors.background),
      body: Obx(() {
        if (controller.events.isEmpty) {
          return Center(child: Text('No exports yet', style: TextStyle(color: colors.mutedForeground)));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.events.length,
          itemBuilder: (context, index) {
            final event = controller.events[index];
            return ExportHistoryRow(
              event: event,
              isExpired: controller.isExpired(event),
              onReshare: () => controller.reshare(event),
            );
          },
        );
      }),
    );
  }
}
