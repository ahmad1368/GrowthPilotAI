import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_traceability_export_filename.dart';

void main() {
  group('BuildTraceabilityExportFilename', () {
    test('zero-pads month and day into the filename', () {
      final name = BuildTraceabilityExportFilename.call(DateTime(2026, 4, 9));

      expect(name, 'Traceability_Matrix_20260409.xlsx');
    });

    test('uses a custom baseName for the batch ZIP bundle (Issue #258)', () {
      final name =
          BuildTraceabilityExportFilename.call(DateTime(2026, 4, 9), extension: 'zip', baseName: 'Project_Bundle');

      expect(name, 'Project_Bundle_20260409.zip');
    });
  });
}
