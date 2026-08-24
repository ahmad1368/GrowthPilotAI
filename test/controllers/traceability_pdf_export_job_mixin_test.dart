import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_pdf_export_job_mixin.dart';
import 'package:growth_pilot_ai/core/data/entities/export_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/export_event_repository.dart';
import 'package:growth_pilot_ai/core/enum/pdf_export_job_status.dart';

class _FakeExportEventRepository implements ExportEventRepository {
  final appended = <ExportEventEntity>[];

  @override
  void append(ExportEventEntity event) => appended.add(event);

  @override
  List<ExportEventEntity> getAll() => appended;
}

class _TestController extends GetxController with TraceabilityPdfExportJobMixin {
  _TestController(this._exportEventRepository, this._bytesProvider);

  final ExportEventRepository _exportEventRepository;
  final Future<Uint8List> Function() _bytesProvider;

  Object fingerprint = 0;

  @override
  ExportEventRepository get exportEventRepository => _exportEventRepository;

  @override
  Object get reportContentFingerprint => fingerprint;

  @override
  Future<Uint8List> buildReportPdfBytes() => _bytesProvider();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // exportReportPdfViaJob() calls Get.snackbar on failure - without
  // testMode, that needs a real mounted GetMaterialApp navigator, which
  // a plain test() (no widget pumped) can never provide. See GetX's own
  // README: "if you are using your navigation in your controllers, use
  // Get.testMode = true".
  Get.testMode = true;

  group('TraceabilityPdfExportJobMixin', () {
    test('starts idle', () {
      final controller = _TestController(_FakeExportEventRepository(), () async => Uint8List(0));
      expect(controller.pdfExportJobStatus.value, PdfExportJobStatus.idle);
    });

    test('ignores a second tap while a job is already preparing', () async {
      var buildCallCount = 0;
      final completer = Completer<Uint8List>();
      final repo = _FakeExportEventRepository();
      final controller = _TestController(repo, () {
        buildCallCount++;
        return completer.future;
      });

      final first = controller.exportReportPdfViaJob();
      expect(controller.pdfExportJobStatus.value, PdfExportJobStatus.preparing);

      await controller.exportReportPdfViaJob();
      expect(buildCallCount, 1);

      completer.completeError('rendering failed');
      await first;
      expect(controller.pdfExportJobStatus.value, PdfExportJobStatus.failed);
    });

    test('marks the job failed and logs no audit event when rendering throws', () async {
      final repo = _FakeExportEventRepository();
      final controller = _TestController(repo, () async => throw Exception('render failed'));

      await controller.exportReportPdfViaJob();

      expect(controller.pdfExportJobStatus.value, PdfExportJobStatus.failed);
      expect(repo.appended, isEmpty);
    });

    test('reuses the cached PDF bytes when the report fingerprint is unchanged', () async {
      var buildCallCount = 0;
      final controller = _TestController(_FakeExportEventRepository(), () async {
        buildCallCount++;
        return Uint8List(0);
      });

      await controller.exportReportPdfViaJob();
      expect(buildCallCount, 1);

      await controller.exportReportPdfViaJob();
      expect(buildCallCount, 1);
    });

    test('re-renders when the report fingerprint changes since the last export', () async {
      var buildCallCount = 0;
      final controller = _TestController(_FakeExportEventRepository(), () async {
        buildCallCount++;
        return Uint8List(0);
      });

      await controller.exportReportPdfViaJob();
      controller.fingerprint = 1;
      await controller.exportReportPdfViaJob();

      expect(buildCallCount, 2);
    });
  });
}
