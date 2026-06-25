// lib/features/document_classification/presentation/widgets/document_scanner_view.dart
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/ocr_block_data.dart';
import 'scanning_laser_line.dart';
import 'ocr_bounding_box_overlay.dart';

class DocumentScannerView extends StatelessWidget {
  final Widget cameraPreview;
  final bool isLoading;
  final List<OCRBlockData> ocrBlocks;
  final Size originalImageSize;

  const DocumentScannerView({
    super.key,
    required this.cameraPreview,
    required this.isLoading,
    required this.ocrBlocks,
    required this.originalImageSize,
  });

  @override
  Widget build(BuildContext context) {
    // طراحی کاملاً واکنش‌گرا و انعطاف‌پذیر با استفاده از LayoutBuilder
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // لایه ۱: پیش‌نمایش زنده دوربین یا تصویر خام ورودی
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: cameraPreview,
              ),

              // لایه ۲: انیمیشن خط لیزری متحرک گلس‌مورفیسم در زمان پردازش
              if (isLoading) const ScanningLaserLine(),

              // لایه ۳: رندر کادرهای هوشمند متنی تفکیک‌شده به محض آماده‌سازی دیتا
              if (ocrBlocks.isNotEmpty)
                OCRBoundingBoxOverlay(
                  blocks: ocrBlocks,
                  imageSize: originalImageSize,
                ),
            ],
          ),
        );
      },
    );
  }
}
