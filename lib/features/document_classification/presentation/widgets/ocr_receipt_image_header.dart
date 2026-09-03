import 'dart:io';

import 'package:flutter/material.dart';

/// [Issue #27] Receipt image header — the cropped receipt was already
/// captured by ScannerWorkflow but never reached this screen, despite the
/// issue's own AC requiring it as a visual reference while editing.
class OcrReceiptImageHeader extends StatelessWidget {
  final File image;

  const OcrReceiptImageHeader({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: Image.file(image, fit: BoxFit.cover),
      ),
    );
  }
}
