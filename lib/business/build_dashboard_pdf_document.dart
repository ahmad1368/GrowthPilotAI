import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Input for [BuildDashboardPdfDocument.call] — plain data (no [pw.Document]
/// or Flutter types) so it can safely cross the `compute()` isolate
/// boundary (Issue #117).
class DashboardPdfParams {
  final Uint8List canvasImage;
  final String title;
  const DashboardPdfParams({required this.canvasImage, required this.title});
}

/// Assembles the exported dashboard PDF (Issue #117): one page holding the
/// captured Gridded Canvas (#113) raster as-rendered, a header with the
/// report title + date, and a privacy footer. A top-level-callable static
/// method so [PdfDashboardExportService] can run it off the UI thread via
/// `compute()`.
class BuildDashboardPdfDocument {
  static Future<Uint8List> call(DashboardPdfParams params) async {
    final doc = pw.Document();
    final image = pw.MemoryImage(params.canvasImage);
    doc.addPage(pw.Page(
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(params.title,
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text(DateTime.now().toIso8601String().split('T').first),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Expanded(child: pw.Image(image, fit: pw.BoxFit.contain)),
          pw.SizedBox(height: 8),
          pw.Text(
            'Contains generalized market data only. No personally identifiable information.',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          ),
        ],
      ),
    ));
    return doc.save();
  }
}
