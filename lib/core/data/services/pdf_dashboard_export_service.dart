import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/business/build_dashboard_pdf_document.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_export_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Local PDF assembly (Issue #117): offloads the CPU-bound `pdf` package
/// document build to [compute] — not a raw `Isolate.run`, which throws on
/// web, while `compute` degrades to a same-thread call there instead of
/// failing — so a multi-widget dashboard export doesn't drop UI frames.
class PdfDashboardExportService implements DashboardExportService {
  @override
  OmniResult<Uint8List> buildPdf({
    required Uint8List canvasImage,
    required String title,
  }) async {
    try {
      final bytes = await compute(
        BuildDashboardPdfDocument.call,
        DashboardPdfParams(canvasImage: canvasImage, title: title),
      );
      OmniLogger.info('Built dashboard PDF export ($title, ${bytes.length}B)');
      return OmniResponse.success(bytes, message: 'PDF ready');
    } catch (e, stack) {
      OmniLogger.error(
        title: 'Dashboard PDF export failed',
        widgetName: 'PdfDashboardExportService',
        message: e,
        stackTrace: stack,
      );
      return OmniResponse.error('Could not build the PDF export');
    }
  }
}
