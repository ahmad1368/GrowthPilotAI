import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:growth_pilot_ai/core/widgets/omni_step_progress.dart';
import 'package:growth_pilot_ai/core/constants/scan_pipelines.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'interactive_option_item.dart'; // امپورت ویجت فرزند جهت رفع خطای undefined_method

class ImageSourceSheet extends StatelessWidget {
  final Function(ImageSource) onSourceSelected;
  const ImageSourceSheet({super.key, required this.onSourceSelected});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final txtColor = isDark ? Colors.white : Colors.black;

    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.all(20),
      radius: const BorderRadius.vertical(top: Radius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.white24 : Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 25),
          OmniStepProgress(
            allSteps: ScanPipelines.docScanSteps,
            currentStepId: 'picking',
            subProgress: 0.5,
          ),
          const SizedBox(height: 30),
          Text(
            "انتخاب منبع تصویر",
            style: ShadTheme.of(context).textTheme.h3.copyWith(color: txtColor),
          ),
          const SizedBox(height: 25),
          InteractiveOptionItem(
            icon: Icons.camera_alt_rounded,
            label: "دوربین",
            onTap: () => onSourceSelected(ImageSource.camera),
          ),
          const SizedBox(height: 12),
          InteractiveOptionItem(
            icon: Icons.photo_library_rounded,
            label: "گالری",
            onTap: () => onSourceSelected(ImageSource.gallery),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
