import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_dashboard_pdf_document.dart';
import 'package:image/image.dart' as img;

Uint8List _tinyPng() {
  final image = img.Image(width: 2, height: 2);
  return Uint8List.fromList(img.encodePng(image));
}

void main() {
  test('produces bytes starting with the PDF magic header', () async {
    final bytes = await BuildDashboardPdfDocument.call(
      DashboardPdfParams(canvasImage: _tinyPng(), title: 'Business Compass'),
    );

    // "%PDF" in ASCII.
    expect(bytes.sublist(0, 4), [0x25, 0x50, 0x44, 0x46]);
  });

  test('produces non-trivial output for a non-trivial input image', () async {
    final bytes = await BuildDashboardPdfDocument.call(
      DashboardPdfParams(canvasImage: _tinyPng(), title: 'Report'),
    );

    expect(bytes.length, greaterThan(100));
  });
}
