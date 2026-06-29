import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../omni_glass_panel.dart';
import 'source_item.dart';

class ImageSourcePicker extends StatelessWidget {
  final Function(ImageSource) onSelected;

  const ImageSourcePicker({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return OmniGlassPanel(
      opacity: 0.12,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SourceItem(
            icon: Icons.camera_enhance_rounded,
            label: "Take Photo",
            onTap: () => onSelected(ImageSource.camera),
          ),
          const Divider(color: Colors.white10),
          SourceItem(
            icon: Icons.photo_library_rounded,
            label: "Choose from Gallery",
            onTap: () => onSelected(ImageSource.gallery),
          ),
        ],
      ),
    );
  }
}
