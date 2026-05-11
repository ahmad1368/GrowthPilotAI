import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'omni_glass_panel.dart';
import 'adaptive_text.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(ImageSource) onSourceSelected;

  const ImageSourceSheet({super.key, required this.onSourceSelected});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;

    return Material(
      color: Colors.transparent,
      child: OmniGlassPanel(
        // استاندارد جدید: غلظت بالا در لایت‌مد برای ایجاد سطح سفید ملموس
        opacity: isDark ? 0.1 : 0.9,
        fullBorderRadius: false, // برای چسبیدن به پایین صفحه
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // خط کوچک بالای منو (Handle)
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const AdaptiveText(
                "انتخاب منبع تصویر",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              _buildOption(
                context,
                Icons.camera_alt_rounded,
                "دوربین",
                ImageSource.camera,
                isDark,
              ),
              const SizedBox(height: 10),
              Divider(
                color: isDark
                    ? Colors.white10
                    : Colors.black.withValues(alpha: 0.05),
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: 10),
              _buildOption(
                context,
                Icons.photo_library_rounded,
                "گالری",
                ImageSource.gallery,
                isDark,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, IconData icon, String label,
      ImageSource source, bool isDark) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.cyan.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.cyan),
      ),
      title: AdaptiveText(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: isDark ? Colors.white24 : Colors.black26,
        size: 16,
      ),
      onTap: () {
        onSourceSelected(source);
      },
    );
  }
}
