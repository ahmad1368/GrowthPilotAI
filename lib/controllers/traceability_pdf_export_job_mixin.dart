import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_export_subject.dart';
import 'package:growth_pilot_ai/business/build_traceability_export_filename.dart';
import 'package:growth_pilot_ai/business/share_pdf_bytes.dart';
import 'package:growth_pilot_ai/core/data/entities/export_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/export_event_repository.dart';
import 'package:growth_pilot_ai/core/enum/pdf_export_job_status.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// "Loading State: Overlay Progress/Status SnackBar... prevents
/// repeated taps and duplicate requests" + "Direct Download... share
/// via the system's Share Intent" (Issue #251) — a one-tap PDF export
/// that guards against duplicate taps while the report renders, then
/// shares it and logs an #250 audit event. Also implements #252's
/// "if the data hasn't changed since the last export, serve a cached
/// version instead of re-rendering" via [reportContentFingerprint].
/// Mixed into `TraceabilityController` after
/// `TraceabilityReportPreviewMixin` (needs [buildReportPdfBytes]/
/// [reportContentFingerprint]) and `TraceabilityMultiShareMixin`
/// (needs [exportEventRepository]).
mixin TraceabilityPdfExportJobMixin on GetxController {
  Future<Uint8List> buildReportPdfBytes();
  Object get reportContentFingerprint;
  ExportEventRepository get exportEventRepository;

  final pdfExportJobStatus = PdfExportJobStatus.idle.obs;

  Object? _cachedFingerprint;
  Uint8List? _cachedBytes;

  Future<void> exportReportPdfViaJob() async {
    if (pdfExportJobStatus.value == PdfExportJobStatus.preparing) return;
    pdfExportJobStatus.value = PdfExportJobStatus.preparing;
    try {
      final fingerprint = reportContentFingerprint;
      final cached = _cachedBytes;
      final bytes =
          (cached != null && fingerprint == _cachedFingerprint) ? cached : await buildReportPdfBytes();
      _cachedFingerprint = fingerprint;
      _cachedBytes = bytes;

      final now = DateTime.now();
      final filename = BuildTraceabilityExportFilename.call(now, extension: 'pdf');
      await SharePdfBytes.call(bytes, filename,
          subject: BuildExportSubject.call('Traceability Report', timestamp: now));
      exportEventRepository
          .append(ExportEventEntity(format: 'pdf', filename: filename, fileBytes: bytes, occurredAt: now));
      pdfExportJobStatus.value = PdfExportJobStatus.ready;
    } catch (e, stack) {
      OmniLogger.error(
          title: 'Traceability PDF export failed',
          widgetName: 'TraceabilityPdfExportJobMixin',
          message: e,
          stackTrace: stack);
      pdfExportJobStatus.value = PdfExportJobStatus.failed;
    }
  }
}
