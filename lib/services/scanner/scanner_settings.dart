import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ScannerSettings {
  static List<PlatformUiSettings> get(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final presets = [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio3x2,
    ];

    return [
      AndroidUiSettings(
        toolbarTitle: 'Align Receipt',
        toolbarColor: colorScheme.surface,
        activeControlsWidgetColor: colorScheme.primary,
        lockAspectRatio: false,
        aspectRatioPresets: presets,
      ),
      IOSUiSettings(
        title: 'Align Receipt',
        aspectRatioPresets: presets,
      ),
    ];
  }
}
