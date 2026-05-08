import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'omni_glass_panel.dart'; // حتما این را ایمپورت کنید

class ImageSourceSheet extends StatelessWidget {
  final Function(ImageSource) onSourceSelected;

  const ImageSourceSheet({super.key, required this.onSourceSelected});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: OmniGlassPanel(
        opacity: 0.2,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // خط کوچک بالای منو برای زیبایی (Handle)
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "انتخاب منبع تصویر",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              _buildOption(context, Icons.camera_alt_rounded, "دوربین",
                  ImageSource.camera),
              const SizedBox(height: 10),
              const Divider(color: Colors.white10, indent: 20, endIndent: 20),
              const SizedBox(height: 10),
              _buildOption(context, Icons.photo_library_rounded, "گالری",
                  ImageSource.gallery),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(
      BuildContext context, IconData icon, String label, ImageSource source) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.cyanAccent.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.cyanAccent),
      ),
      title: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
      onTap: () {
        debugPrint("🟡 Clicked on: $label with source: $source");
        onSourceSelected(source);
      },
    );
  }
}
