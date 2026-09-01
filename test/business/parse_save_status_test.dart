import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_save_status.dart';
import 'package:growth_pilot_ai/core/enum/canvas_save_status.dart';
import 'package:growth_pilot_ai/core/models/canvas_bridge_message.dart';

void main() {
  group('ParseSaveStatus', () {
    test('parses saving/saved/idle from an onSaveStatusChanged message', () {
      expect(
          ParseSaveStatus.call(
              const CanvasBridgeMessage(event: 'onSaveStatusChanged', payload: {'status': 'saving'})),
          CanvasSaveStatus.saving);
      expect(
          ParseSaveStatus.call(
              const CanvasBridgeMessage(event: 'onSaveStatusChanged', payload: {'status': 'saved'})),
          CanvasSaveStatus.saved);
      expect(
          ParseSaveStatus.call(
              const CanvasBridgeMessage(event: 'onSaveStatusChanged', payload: {'status': 'idle'})),
          CanvasSaveStatus.idle);
    });

    test('null for an unrelated event', () {
      expect(
          ParseSaveStatus.call(
              const CanvasBridgeMessage(event: 'onNodeDoubleClick', payload: {'status': 'saving'})),
          isNull);
    });

    test('null for an unrecognized status value', () {
      expect(
          ParseSaveStatus.call(
              const CanvasBridgeMessage(event: 'onSaveStatusChanged', payload: {'status': 'weird'})),
          isNull);
    });
  });
}
