import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:growth_pilot_ai/core/business/scanner_pipeline_worker.dart';
import '../../features/scanner/screens/presentation/widgets/presentation/widgets/image_source_sheet.dart';
import 'scanner_pipeline_executor.dart';

class ScannerWorkflow {
  final _executor = ScannerPipelineExecutor();
  final RxString currentStepId = 'picking'.obs;
  final RxDouble subProgress = 0.0.obs;

  void start(BuildContext context, Function(String) onSave) {
    currentStepId.value = 'picking';
    subProgress.value = 0.0;
    Get.bottomSheet(
      ImageSourceSheet(
        onSourceSelected: (src) {
          Get.back(); // بستن باتم‌شیت پس از انتخاب
          runPipeline(src, context, onSave); // اجرای پایپ‌لاین اصلی
        },
      ),
    );
  }

  Future<void> runPipeline(
      ImageSource src, BuildContext ctx, Function(String) save) async {
    final outcome = await _executor.executeImageWorkflow(
        src, ctx, currentStepId, subProgress);
    await Future.delayed(const Duration(milliseconds: 250));

    final worker = const ScannerPipelineWorker();
    if (outcome.success && outcome.data != null) {
      worker.navigateToConfirmation(
          outcome.data!, outcome.message ?? "سایر موارد");
    } else {
      _executor.showErrorDialog(outcome, () => runPipeline(src, ctx, save));
    }
  }

  void dispose() {
    currentStepId.close();
    subProgress.close();
  }
}
