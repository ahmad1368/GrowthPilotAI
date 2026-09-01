import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/performance_controller.dart';
import '../models/process_step.dart';
import 'step_indicator_point.dart';

class OmniStepProgress extends StatelessWidget {
  final List<ProcessStep> allSteps;
  final String currentStepId;
  final double subProgress;

  const OmniStepProgress({
    super.key,
    required this.allSteps,
    required this.currentStepId,
    this.subProgress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final currentStep = allSteps.firstWhere((s) => s.id == currentStepId);
    double totalPercent = _calculateTotalProgress(currentStep);
    // Issue #110: skip the BackdropFilter blur on low-end hardware / Power
    // Saver Mode — a plain, more-opaque surface stands in instead.
    final useBlur = Get.find<PerformanceController>().useBlur;

    final content = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: useBlur ? 0.08 : 0.16),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(currentStep, totalPercent),
          const SizedBox(height: 20),
          _buildProgressBar(context, totalPercent),
          const SizedBox(height: 20),
          _buildStepsRow(context, currentStep),
        ],
      ),
    );

    if (!useBlur) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: content,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: content,
      ),
    );
  }

  // منطق محاسبه درصد پیشرفت بر اساس وزن
  double _calculateTotalProgress(ProcessStep currentStep) {
    double totalWeight = allSteps.fold(0, (sum, item) => sum + item.weight);
    double completedWeight = 0;
    for (var step in allSteps) {
      if (step.order < currentStep.order) {
        completedWeight += step.weight;
      } else if (step.id == currentStepId) {
        completedWeight += step.weight * subProgress;
        break;
      }
    }
    return completedWeight / totalWeight;
  }

  Widget _buildHeader(ProcessStep currentStep, double totalPercent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Text(
            currentStep.title,
            key: ValueKey(currentStep.id),
            style: const TextStyle(
                // color: Colors.cyanAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text("${(totalPercent * 100).toInt()}%",
            style: const TextStyle(color: Colors.white38, fontSize: 12)),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context, double totalPercent) {
    return Stack(
      children: [
        Container(
            height: 8,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10))),
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          height: 8,
          width: (MediaQuery.of(context).size.width - 80) * totalPercent,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.cyanAccent]),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  Widget _buildStepsRow(BuildContext context, ProcessStep currentStep) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: allSteps
          .map((step) => StepIndicatorPoint(
                step: step,
                isCompleted: step.order < currentStep.order,
                isCurrent: step.id == currentStepId,
              ))
          .toList(),
    );
  }
}
