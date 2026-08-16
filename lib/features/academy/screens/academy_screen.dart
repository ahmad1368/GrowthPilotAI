import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/academy_controller.dart';
import 'package:growth_pilot_ai/features/academy/widgets/academy_category_chips.dart';
import 'package:growth_pilot_ai/features/academy/widgets/academy_video_grid.dart';
import 'package:growth_pilot_ai/features/academy/widgets/continue_watching_row.dart';

/// "Business Academy" video hub (Issue #163) — flat design, category
/// filtering, and a "Continue Watching" shelf; playback opens externally
/// (see [AcademyController.openVideo]) since no player is embedded.
class AcademyScreen extends StatelessWidget {
  const AcademyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AcademyController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Business Academy')),
      body: Obx(() => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AcademyCategoryChips(
                selected: controller.selectedCategory.value,
                onSelected: (category) => controller.selectedCategory.value = category,
              ),
              const SizedBox(height: 24),
              ContinueWatchingRow(
                  videos: controller.continueWatching, onTap: controller.openVideo),
              if (controller.continueWatching.isNotEmpty) const SizedBox(height: 24),
              AcademyVideoGrid(videos: controller.visibleVideos, onTap: controller.openVideo),
            ]),
          )),
    );
  }
}
