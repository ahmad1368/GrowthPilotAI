import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/capture_boundary_image.dart';
import 'package:growth_pilot_ai/business/share_png_bytes.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// "High-Resolution Visual Exports (PNG)" for the KPI Dashboard (Issue
/// #248) — reuses #117's [CaptureBoundaryImage]/[SharePngBytes]
/// exactly as [DashboardExportController] does for the Business
/// Compass canvas. No SVG: `RepaintBoundary.toImage` only produces a
/// raster `ui.Image`, not vector paths (see PR notes).
class KpiDashboardExportController extends GetxController {
  final captureKey = GlobalKey();
  final isExporting = false.obs;

  Future<void> exportPng() async {
    if (isExporting.value) return;
    isExporting.value = true;
    try {
      final image = await CaptureBoundaryImage.call(captureKey);
      await SharePngBytes.call(image, 'kpi_dashboard.png');
    } catch (e, stack) {
      OmniLogger.error(
          title: 'KPI Dashboard PNG export failed',
          widgetName: 'KpiDashboardExportController',
          message: e,
          stackTrace: stack);
    } finally {
      isExporting.value = false;
    }
  }
}
