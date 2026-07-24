import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Rasterizes a [RepaintBoundary]'s subtree into PNG bytes (Issue #117):
/// high-DPI (`pixelRatio: 3`, the issue's own target) so exported
/// dashboards stay print-quality. Disposes the intermediate [ui.Image]
/// immediately to avoid holding onto raw GPU texture memory on low-end
/// devices (#110).
class CaptureBoundaryImage {
  static Future<Uint8List> call(GlobalKey key, {double pixelRatio = 3}) async {
    final boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: pixelRatio);
    try {
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } finally {
      image.dispose();
    }
  }
}
