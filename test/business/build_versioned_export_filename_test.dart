import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_versioned_export_filename.dart';

void main() {
  group('BuildVersionedExportFilename', () {
    test('slugifies the base name and appends a zero-padded timestamp', () {
      final name = BuildVersionedExportFilename.call('KPI Dashboard', 'png',
          timestamp: DateTime(2026, 4, 9, 7, 5));

      expect(name, 'GrowthPilotAI_kpi_dashboard_20260409-0705.png');
    });

    test('two calls a minute apart produce different filenames', () {
      final first =
          BuildVersionedExportFilename.call('Flow', 'svg', timestamp: DateTime(2026, 1, 1, 10, 0));
      final second =
          BuildVersionedExportFilename.call('Flow', 'svg', timestamp: DateTime(2026, 1, 1, 10, 1));

      expect(first, isNot(second));
    });
  });
}
