import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/document_classification/presentation/widgets/classification_status_panel.dart';
import 'package:growth_pilot_ai/features/insights/presentation/widgets/pages/insight_page.dart';

class AdaptiveClassificationLayout extends StatelessWidget {
  final bool isProcessing;
  final Widget cameraPreview;

  const AdaptiveClassificationLayout({
    super.key,
    required this.isProcessing,
    required this.cameraPreview,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final isWide = width > 600;

    return InsightPage(
      child: isWide
          ? Row(
              children: [
                Expanded(flex: 2, child: cameraPreview),
                Expanded(
                    child: Center(
                        child: ClassificationStatusPanel(
                            isChecking: isProcessing))),
              ],
            )
          : Stack(
              children: [
                cameraPreview,
                Positioned(
                    bottom: 32,
                    left: 16,
                    right: 16,
                    child: ClassificationStatusPanel(isChecking: isProcessing)),
              ],
            ),
    );
  }
}
