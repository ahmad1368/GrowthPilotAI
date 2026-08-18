import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/services/ocr/document_scanner_service.dart';
import 'package:growth_pilot_ai/core/services/ocr/document_text_extractor_service.dart';

/// Drives "scan a physical paper, then extract its text" (Issue
/// #226/#227) — chains [DocumentScannerService] and
/// [DocumentTextExtractorService].
class DocumentScanController extends GetxController {
  final result = Rxn<OCRResult>();
  final errorMessage = RxnString();
  final isProcessing = false.obs;

  Future<void> scanAndExtract() async {
    isProcessing.value = true;
    errorMessage.value = null;
    try {
      final scan = await Get.find<DocumentScannerService>().scan();
      if (!scan.success || scan.data == null) {
        errorMessage.value = scan.message ?? 'Scan failed.';
        return;
      }
      final ocr = await Get.find<DocumentTextExtractorService>().extractText(scan.data!);
      if (!ocr.success || ocr.data == null) {
        errorMessage.value = ocr.message ?? 'Text extraction failed.';
        return;
      }
      result.value = ocr.data;
    } finally {
      isProcessing.value = false;
    }
  }
}
