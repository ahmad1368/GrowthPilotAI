import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ImageSourcePicker extends StatelessWidget {
  final Function(ImageSource) onSelected;

  const ImageSourcePicker({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final isDark = ShadTheme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShadButton.ghost(
            width: double.infinity,
            onPressed: () => onSelected(ImageSource.camera),
            icon: Icon(Icons.camera_enhance_rounded, color: fgColor, size: 20),
            text: Text("Take Photo", style: ShadTheme.of(context).textTheme.p),
          ),
          const SizedBox(height: 4),
          Divider(
              color: isDark ? const Color(0xff27272a) : const Color(0xffe4e4e7),
              height: 1),
          const SizedBox(height: 4),
          ShadButton.ghost(
            width: double.infinity,
            onPressed: () => onSelected(ImageSource.gallery),
            icon: Icon(Icons.photo_library_rounded, color: fgColor, size: 20),
            text: Text("Choose from Gallery",
                style: ShadTheme.of(context).textTheme.p),
          ),
        ],
      ),
    );
  }
}
