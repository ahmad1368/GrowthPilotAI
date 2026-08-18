import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_document_content_hash.dart';
import 'package:growth_pilot_ai/business/deduplicate_requirements.dart';
import 'package:growth_pilot_ai/business/extract_requirements_from_text.dart';
import 'package:growth_pilot_ai/controllers/text_sanitization_controller.dart';
import 'package:growth_pilot_ai/core/enum/document_processing_stage.dart';
import 'package:growth_pilot_ai/core/models/document_processing_record.dart';

/// Local stand-in for Issue #232's Node/Python/Redis async worker
/// pipeline — runs Issue #227's sanitization then #228's extraction
/// in-process, publishing [stage] transitions the same way the real
/// WebSocket `status_update` events would (see PR notes for what's not
/// built: BullMQ queue, Python heartbeat, S3 storage).
class DocumentProcessingOrchestratorController extends GetxController {
  final TextSanitizationController sanitizationController;

  DocumentProcessingOrchestratorController(this.sanitizationController);

  final stage = DocumentProcessingStage.pending.obs;
  final errorMessage = RxnString();
  final _cache = <String, DocumentProcessingRecord>{};

  DocumentProcessingRecord? findCached(String rawText) =>
      _cache[ComputeDocumentContentHash.call(rawText)];

  Future<DocumentProcessingRecord?> process(String rawText, {bool reuseCache = true}) async {
    stage.value = DocumentProcessingStage.uploading;
    final hash = ComputeDocumentContentHash.call(rawText);
    if (reuseCache && _cache.containsKey(hash)) {
      stage.value = DocumentProcessingStage.completed;
      return _cache[hash];
    }
    try {
      stage.value = DocumentProcessingStage.cleaning;
      sanitizationController.sanitize(rawText);
      final sanitized = sanitizationController.result.value?.sanitizedText ?? '';

      stage.value = DocumentProcessingStage.extracting;
      final requirements = DeduplicateRequirements.call(ExtractRequirementsFromText.call(sanitized));

      final record = DocumentProcessingRecord(
          contentHash: hash,
          sanitizedText: sanitized,
          requirements: requirements,
          processedAt: DateTime.now());
      _cache[hash] = record;
      stage.value = DocumentProcessingStage.completed;
      return record;
    } catch (e) {
      stage.value = DocumentProcessingStage.failed;
      errorMessage.value = e.toString();
      return null;
    }
  }
}
