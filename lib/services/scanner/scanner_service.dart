import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'scanner_ui_settings.dart';

class ScannerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickAndCrop(ImageSource source, BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (pickedFile == null) return null;

    // پارامترAspectRatioPresets از اینجا حذف شد تا خطا برطرف شود
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: ScannerUiSettings.get(context),
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }
}
