import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/services/environment_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DeveloperToolsCard extends StatelessWidget {
  const DeveloperToolsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final envService = Get.find<EnvironmentService>();
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.all(16),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Remote Access",
                    style: theme.textTheme.p
                        .copyWith(fontWeight: FontWeight.bold)),
                Text("Toggle between Local and Cloud DB",
                    style: theme.textTheme.muted.copyWith(fontSize: 12)),
              ],
            ),
          ),
          Obx(() => Switch(
                value: envService.isRemoteEnabled.value,
                onChanged: (val) => envService.toggleDataSource(val),
                activeThumbColor: const Color(0xff22c55e),
              )),
        ],
      ),
    );
  }
}
