import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_batch_export_zip_archive.dart';

void main() {
  group('BuildBatchExportZipArchive', () {
    test('produces a ZIP containing every given file with matching bytes', () {
      final files = [
        (filename: '01_Report.pdf', bytes: utf8.encode('pdf-bytes')),
        (filename: '02_Matrix.xlsx', bytes: utf8.encode('xlsx-bytes')),
        (filename: '03_Matrix.csv', bytes: utf8.encode('csv-bytes')),
      ];

      final zipBytes = BuildBatchExportZipArchive.call(files);
      expect(zipBytes, isNotEmpty);

      final decoded = ZipDecoder().decodeBytes(zipBytes);
      expect(decoded.map((f) => f.name).toSet(), {'01_Report.pdf', '02_Matrix.xlsx', '03_Matrix.csv'});
      final pdfEntry = decoded.findFile('01_Report.pdf')!;
      expect(utf8.decode(pdfEntry.content as List<int>), 'pdf-bytes');
    });

    test('produces a valid (empty) ZIP when given no files', () {
      final zipBytes = BuildBatchExportZipArchive.call(const []);
      expect(ZipDecoder().decodeBytes(zipBytes), isEmpty);
    });
  });
}
