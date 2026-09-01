import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/services/pdf_dashboard_export_service.dart';
import 'package:image/image.dart' as img;

Uint8List _tinyPng() {
  final image = img.Image(width: 2, height: 2);
  return Uint8List.fromList(img.encodePng(image));
}

void main() {
  test('buildPdf resolves with PDF bytes on success', () async {
    final service = PdfDashboardExportService();

    final result = await service.buildPdf(
      canvasImage: _tinyPng(),
      title: 'Business Compass',
    );

    expect(result.success, true);
    expect(result.data, isNotNull);
    expect(result.data!.sublist(0, 4), [0x25, 0x50, 0x44, 0x46]);
  });
}
