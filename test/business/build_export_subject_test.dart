import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_export_subject.dart';

void main() {
  group('BuildExportSubject', () {
    test('formats project name, title, and zero-padded date', () {
      final subject = BuildExportSubject.call('Traceability Export', timestamp: DateTime(2026, 3, 5));
      expect(subject, 'GrowthPilotAI Traceability Export — 2026-03-05');
    });

    test('pads single-digit month and day', () {
      final subject = BuildExportSubject.call('Report', timestamp: DateTime(2026, 1, 9));
      expect(subject, 'GrowthPilotAI Report — 2026-01-09');
    });

    test('uses current time when timestamp omitted', () {
      final subject = BuildExportSubject.call('Report');
      expect(subject, startsWith('GrowthPilotAI Report — '));
    });
  });
}
