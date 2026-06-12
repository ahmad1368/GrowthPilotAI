import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/business/scanner_pipeline_worker.dart';
import 'package:growth_pilot_ai/core/presentation/widgets/scanner_error_dialog.dart';
import '../../services/scanner/scanner_service.dart';

class ScannerPipelineExecutor {
  final _scannerService = Get.find<ScannerService>();
  final _worker = const ScannerPipelineWorker();

  Future<OmniResponse<OCRResult>> executeImageWorkflow(ImageSource src,
      BuildContext ctx, RxString step, RxDouble progress) async {
    try {
      final res =
          await _scannerService.pickAndCrop(src, ctx, onProgress: (id, val) {
        step.value = id;
        progress.value = val;
      });
      if (!res.success || res.data == null)
        return OmniResponse.error(res.message ?? "خطا در اسکن");

      step.value = 'finalizing';
      progress.value = 0.2;
      return await _worker.processHeavyAiTasks(res.data!, progress);
    } catch (e, stack) {
      _worker.logPipelineError(e, stack);
      return OmniResponse.error("خطای غیرمنتظره در جریان پردازش: $e");
    }
  }

  void showErrorDialog(
      OmniResponse<OCRResult> outcome, VoidCallback retryAction) {
    Get.dialog(
        ScannerErrorDialog(
          message: outcome.message ?? "خطای لایه پردازش هوش مصنوعی",
          onRetry: retryAction,
        ),
        barrierDismissible: false);
  }
}
