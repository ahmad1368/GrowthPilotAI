import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Step 2 "Media Gallery" — a stand-in image picker (Issue #140).
/// Each tap generates+optimizes a fresh demo photo through the #139
/// pipeline, since there's no real device photo library to select
/// multiple images from in this simulation.
class ProductFormMediaStep extends StatelessWidget {
  final List<int> imageIds;
  final VoidCallback onAddImage;
  final void Function(int) onRemoveImage;
  final VoidCallback onCleanupStaleImages;

  const ProductFormMediaStep({
    super.key,
    required this.imageIds,
    required this.onAddImage,
    required this.onRemoveImage,
    required this.onCleanupStaleImages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ShadButton.ghost(onPressed: onAddImage, child: const Text('Add Demo Photo')),
        ShadButton.ghost(onPressed: onCleanupStaleImages, child: const Text('Clean Up Stale Photos')),
      ]),
      if (imageIds.isEmpty)
        const Text('No photos yet.', style: TextStyle(fontSize: 12))
      else
        for (final id in imageIds)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(children: [
              Text('Photo #$id', style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => onRemoveImage(id),
                child: const Text('Remove', style: TextStyle(fontSize: 12, color: Colors.red)),
              ),
            ]),
          ),
    ]);
  }
}
