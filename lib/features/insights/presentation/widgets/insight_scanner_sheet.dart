import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../document_analysis/presentation/widgets/source_item.dart';

class InsightScannerSheet {
  static void show(BuildContext context) {
    final isDark = ShadTheme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SourceItem(
                icon: Icons.camera_alt_rounded,
                label: "Take Photo",
                onTap: () => Navigator.of(ctx).pop(),
              ),
              SourceItem(
                icon: Icons.image_rounded,
                label: "Choose from Gallery",
                onTap: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
