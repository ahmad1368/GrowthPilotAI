import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/diagram_generation_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/bottleneck_insight_row.dart';
import 'package:growth_pilot_ai/features/graph/widgets/diagram_generation_input.dart';
import 'package:growth_pilot_ai/features/graph/widgets/generated_steps_list.dart';

/// Assembles the input + generated result for Issue #224's "instant
/// feedback" flow: text in, steps + #223's bottleneck insights out.
class DiagramGenerationPanel extends StatelessWidget {
  final DiagramGenerationController controller;

  const DiagramGenerationPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DiagramGenerationInput(controller: controller),
        const SizedBox(height: 16),
        Obx(() {
          final result = controller.result.value;
          if (result == null) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneratedStepsList(positions: result.positions),
              const SizedBox(height: 12),
              for (final insight in result.insights) BottleneckInsightRow(insight: insight),
            ],
          );
        }),
      ],
    );
  }
}
