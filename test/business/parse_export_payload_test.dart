import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_export_payload.dart';
import 'package:growth_pilot_ai/core/enum/export_format.dart';
import 'package:growth_pilot_ai/core/models/canvas_bridge_message.dart';

void main() {
  group('ParseExportPayload', () {
    test('parses a valid PNG export message', () {
      final payload = ParseExportPayload.call(
        const CanvasBridgeMessage(
            event: 'onExportReady', payload: {'format': 'png', 'data': 'AAA='}),
      );

      expect(payload, isNotNull);
      expect(payload!.format, ExportFormat.png);
      expect(payload.base64Data, 'AAA=');
    });

    test('null for an unrelated event', () {
      expect(
          ParseExportPayload.call(
              const CanvasBridgeMessage(event: 'onNodeDoubleClick', payload: {})),
          isNull);
    });

    test('null for an unrecognized format', () {
      expect(
          ParseExportPayload.call(const CanvasBridgeMessage(
              event: 'onExportReady', payload: {'format': 'pdf', 'data': 'AAA='})),
          isNull);
    });

    test('null when data is missing', () {
      expect(
          ParseExportPayload.call(
              const CanvasBridgeMessage(event: 'onExportReady', payload: {'format': 'png'})),
          isNull);
    });
  });
}
