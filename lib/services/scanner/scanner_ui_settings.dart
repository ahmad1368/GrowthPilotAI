import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ScannerUiSettings {
  static List<PlatformUiSettings> get(BuildContext context) {
    final theme = Theme.of(context);

    // تعریف نسبت‌های ابعاد در اینجا
    final presets = [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio3x2,
    ];

    return [
      AndroidUiSettings(
        toolbarTitle: 'Align Receipt',
        toolbarColor: theme.colorScheme.surface,
        activeControlsWidgetColor: theme.colorScheme.primary,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        aspectRatioPresets: presets, // اضافه شد
      ),
      IOSUiSettings(
        title: 'Align Receipt',
        aspectRatioPresets: presets, // اضافه شد
      ),
    ];
  }
}
