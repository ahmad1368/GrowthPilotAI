import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/capture_boundary_image.dart';
import 'package:growth_pilot_ai/business/share_png_bytes.dart';
import 'package:growth_pilot_ai/business/slugify_title.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_export_service.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';
import 'package:printing/printing.dart';

/// Drives the "Export" action on the Business Compass canvas (Issue #117):
/// captures the Gridded Canvas (#113) as-rendered, then shares it as PDF or PNG.
class DashboardExportController extends GetxController {
  final DashboardExportService _pdfService;
  DashboardExportController(this._pdfService);

  final isExporting = false.obs;

  Future<void> exportPdf(GlobalKey canvasKey, String title) =>
      _guarded('PDF', () async {
        final image = await CaptureBoundaryImage.call(canvasKey);
        final result =
            await _pdfService.buildPdf(canvasImage: image, title: title);
        if (result.success && result.data != null) {
          await Printing.sharePdf(
              bytes: result.data!, filename: '${SlugifyTitle.call(title)}.pdf');
        }
      });

  Future<void> exportPng(GlobalKey canvasKey, String title) =>
      _guarded('PNG', () async {
        final image = await CaptureBoundaryImage.call(canvasKey);
        await SharePngBytes.call(image, '${SlugifyTitle.call(title)}.png');
      });

  Future<void> _guarded(String kind, Future<void> Function() action) async {
    if (isExporting.value) return;
    isExporting.value = true;
    try {
      await action();
    } catch (e, stack) {
      OmniLogger.error(
          title: 'Dashboard $kind export failed',
          widgetName: 'DashboardExportController',
          message: e,
          stackTrace: stack);
    } finally {
      isExporting.value = false;
    }
  }
}
