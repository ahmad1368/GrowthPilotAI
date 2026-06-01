// lib/features/document_classification/presentation/widgets/ocr_bounding_box_overlay.dart
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/ocr_block_data.dart';

class OCRBoundingBoxOverlay extends StatelessWidget {
  final List<OCRBlockData> blocks;
  final Size imageSize;

  const OCRBoundingBoxOverlay({
    super.key,
    required this.blocks,
    required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: OCRPainter(blocks: blocks, imageSize: imageSize),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class OCRPainter extends CustomPainter {
  final List<OCRBlockData> blocks;
  final Size imageSize;

  OCRPainter({required this.blocks, required this.imageSize});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageSize.width == 0 || imageSize.height == 0) return;
    final double scaleX = size.width / imageSize.width;
    final double scaleY = size.height / imageSize.height;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.cyanAccent.withValues(alpha: 0.7);

    for (var block in blocks) {
      final rect = Rect.fromLTRB(
        block.boundingBox.left * scaleX,
        block.boundingBox.top * scaleY,
        block.boundingBox.right * scaleX,
        block.boundingBox.bottom * scaleY,
      );
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(4)), paint);
    }
  }

  @override
  bool shouldRepaint(covariant OCRPainter oldDelegate) =>
      oldDelegate.blocks != blocks;
}
