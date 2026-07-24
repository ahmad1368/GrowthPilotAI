import 'dart:typed_data';

import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Assembles a print-ready PDF from an already-captured widget snapshot
/// (Issue #117). Kept separate from the widget-capture step (which needs a
/// live [BuildContext]/[GlobalKey]) so this stays swappable for a future
/// server-side renderer (#251/#252) without touching the capture/share flow.
abstract class DashboardExportService {
  OmniResult<Uint8List> buildPdf({
    required Uint8List canvasImage,
    required String title,
  });
}
