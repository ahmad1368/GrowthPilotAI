import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'scanner/scanner_settings.dart'; // وارد کردن تنظیمات جدید

class ImagePickerService extends GetxService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickAndCrop(ImageSource source, BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (pickedFile == null) return null;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: ScannerSettings.get(context), // استفاده از کلاس کمکی
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }
}
