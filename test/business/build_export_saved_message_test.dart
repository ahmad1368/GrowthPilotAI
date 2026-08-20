import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_export_saved_message.dart';

void main() {
  group('BuildExportSavedMessage', () {
    test('reports the Downloads path when a copy was actually saved', () {
      final message = BuildExportSavedMessage.call('report.pdf', savedToDownloads: true);
      expect(message, 'Saved to Downloads/report.pdf');
    });

    test('falls back to a share-only message when Downloads is unavailable', () {
      final message = BuildExportSavedMessage.call('report.pdf', savedToDownloads: false);
      expect(message, 'Ready to share: report.pdf');
    });
  });
}
