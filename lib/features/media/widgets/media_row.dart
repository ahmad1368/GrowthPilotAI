import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/image_variant_entity.dart';

/// One processed image's before/after summary (Issue #139).
class MediaRow extends StatelessWidget {
  final ImageVariantEntity variant;
  const MediaRow({super.key, required this.variant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        '${variant.label} — ${(variant.originalSizeBytes / 1024).toStringAsFixed(0)}KB → '
        '${(variant.standardSizeBytes / 1024).toStringAsFixed(0)}KB '
        '(${variant.dataReductionPercent.toStringAsFixed(0)}% smaller)',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
