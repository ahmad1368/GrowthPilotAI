import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/image_variant_entity.dart';
import 'package:growth_pilot_ai/features/media/widgets/media_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the "process demo image" trigger plus the processed
/// variants list (Issue #139). Purely presentational.
class MediaView extends StatelessWidget {
  final List<ImageVariantEntity> variants;
  final VoidCallback onProcess;

  const MediaView({super.key, required this.variants, required this.onProcess});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ShadButton.ghost(onPressed: onProcess, child: const Text('Process Demo Photo')),
      if (variants.isEmpty)
        const Text('No images processed yet.', style: TextStyle(fontSize: 12))
      else
        for (final variant in variants) MediaRow(variant: variant),
    ]);
  }
}
