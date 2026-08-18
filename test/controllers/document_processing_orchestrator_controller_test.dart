import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/document_processing_orchestrator_controller.dart';
import 'package:growth_pilot_ai/controllers/text_sanitization_controller.dart';
import 'package:growth_pilot_ai/core/enum/document_processing_stage.dart';

void main() {
  late DocumentProcessingOrchestratorController orchestrator;

  const sampleText = 'The system shall log events.';

  setUp(() {
    orchestrator = DocumentProcessingOrchestratorController(TextSanitizationController());
  });

  group('DocumentProcessingOrchestratorController', () {
    test('process() runs the pipeline through to completed', () async {
      final record = await orchestrator.process(sampleText);

      expect(record, isNotNull);
      expect(record!.requirements, isNotEmpty);
      expect(orchestrator.stage.value, DocumentProcessingStage.completed);
    });

    test('findCached returns null before processing and the record after', () async {
      expect(orchestrator.findCached(sampleText), isNull);

      await orchestrator.process(sampleText);

      expect(orchestrator.findCached(sampleText), isNotNull);
    });

    test('process() with reuseCache returns the cached record for identical content', () async {
      final first = await orchestrator.process(sampleText);
      final second = await orchestrator.process(sampleText);

      expect(identical(first, second), isTrue);
    });

    test('process() with reuseCache: false reprocesses instead of reusing the cache', () async {
      final first = await orchestrator.process(sampleText);
      final second = await orchestrator.process(sampleText, reuseCache: false);

      expect(identical(first, second), isFalse);
      expect(second!.contentHash, first!.contentHash);
    });
  });
}
