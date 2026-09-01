import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/dashboard_export_controller.dart';

/// AppBar "Export" action for the Business Compass canvas (Issue #117): a
/// flat [PopupMenuButton] — no Glassmorphism — offering PDF or PNG, with a
/// spinner swapped in while [DashboardExportController.isExporting].
class DashboardExportButton extends StatelessWidget {
  final GlobalKey canvasKey;
  final String title;

  const DashboardExportButton(
      {super.key, required this.canvasKey, required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardExportController>();
    return Obx(() {
      if (controller.isExporting.value) {
        return const Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
              width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
        );
      }
      return PopupMenuButton<void>(
        tooltip: 'Export dashboard',
        icon: const Icon(Icons.ios_share),
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () => controller.exportPdf(canvasKey, title),
            child: const Text('Export as PDF'),
          ),
          PopupMenuItem(
            onTap: () => controller.exportPng(canvasKey, title),
            child: const Text('Export as PNG'),
          ),
        ],
      );
    });
  }
}
