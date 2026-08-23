import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/controllers/service_health_controller.dart';
import 'package:growth_pilot_ai/core/enum/service_health_status.dart';
import 'package:growth_pilot_ai/features/settings/widgets/service_health_row.dart';

/// "System Health" diagnostics screen (Issue #166) — replaces the
/// original NestJS `/health` endpoint spec with a local dependency
/// panel; see PR notes.
class ServiceHealthScreen extends StatelessWidget {
  const ServiceHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final controller = Get.find<ServiceHealthController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('System Health'),
        backgroundColor: colors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: controller.reload,
          ),
        ],
      ),
      body: Obx(() {
        final status = controller.overallStatus.value;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              status == ServiceHealthStatus.up ? 'All systems operational' : 'Attention needed',
              style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            for (final indicator in controller.indicators) ServiceHealthRow(indicator: indicator),
          ],
        );
      }),
    );
  }
}
