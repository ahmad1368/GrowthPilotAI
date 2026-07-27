import 'package:flutter/widgets.dart';
import 'package:growth_pilot_ai/business/capture_boundary_image.dart';
import 'package:growth_pilot_ai/business/slugify_title.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_export_service.dart';
import 'package:printing/printing.dart';

/// Captures the valuation widget and shares it as PDF (Issue #446), reusing
/// the dashboard-level capture/share pipeline (#117).
class ExportInventoryValuationPdf {
  static Future<void> call(GlobalKey boundaryKey, String title) async {
    final image = await CaptureBoundaryImage.call(boundaryKey);
    final result = await DependencyInjection.get<DashboardExportService>()
        .buildPdf(canvasImage: image, title: title);
    if (result.success && result.data != null) {
      await Printing.sharePdf(bytes: result.data!, filename: '${SlugifyTitle.call(title)}.pdf');
    }
  }
}
