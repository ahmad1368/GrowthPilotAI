import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/image_source_sheet.dart';
import '../utils/ui_helper.dart';

class ImageWorkflowHelper {
  // تغییر متد برای پذیرش فایل کراپ شده نهایی (File?) به جای XFile
  static void showPicker(BuildContext context, Function(dynamic) onResult) {
    final bool isWide = UIHelper.isWide(context);

    if (isWide) {
      _showAsDialog(context, onResult);
    } else {
      _showAsBottomSheet(context, onResult);
    }
  }

  static void _showAsDialog(BuildContext context, Function(dynamic) onResult) {
    Get.dialog(
      Center(
        child: SizedBox(
          width: 400,
          child: ImageSourceSheet(
            onSourceSelected: (source) => onResult(source),
          ),
        ),
      ),
    );
  }

  static void _showAsBottomSheet(
      BuildContext context, Function(dynamic) onResult) {
    Get.bottomSheet(
      ImageSourceSheet(
        onSourceSelected: (source) => onResult(source),
      ),
    );
  }
}
