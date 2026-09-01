import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_export_file_name.dart';
import 'package:growth_pilot_ai/core/enum/export_format.dart';

void main() {
  group('BuildExportFileName', () {
    test('uses the correct extension per format', () {
      final now = DateTime(2026, 1, 1, 12);

      expect(BuildExportFileName.call(ExportFormat.png, now), endsWith('.png'));
      expect(BuildExportFileName.call(ExportFormat.svg, now), endsWith('.svg'));
    });

    test('two exports at different times never collide', () {
      final a = BuildExportFileName.call(ExportFormat.png, DateTime(2026, 1, 1, 12, 0, 0));
      final b = BuildExportFileName.call(ExportFormat.png, DateTime(2026, 1, 1, 12, 0, 1));

      expect(a, isNot(b));
    });
  });
}
