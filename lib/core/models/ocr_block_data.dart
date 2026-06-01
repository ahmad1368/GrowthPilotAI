// lib/core/models/ocr_block_data.dart
import 'package:flutter/material.dart';

class OCRBlockData {
  final Rect boundingBox;
  final String text;

  const OCRBlockData({
    required this.boundingBox,
    required this.text,
  });
}
