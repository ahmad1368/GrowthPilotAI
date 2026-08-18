import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_flutter_bridge_message.dart';

void main() {
  group('ParseFlutterBridgeMessage', () {
    test('parses a valid event with payload', () {
      final message =
          ParseFlutterBridgeMessage.call('{"event":"onNodeDoubleClick","payload":{"nodeId":"a"}}');

      expect(message, isNotNull);
      expect(message!.event, 'onNodeDoubleClick');
      expect(message.payload['nodeId'], 'a');
    });

    test('defaults to an empty payload when missing', () {
      final message = ParseFlutterBridgeMessage.call('{"event":"ping"}');

      expect(message!.payload, isEmpty);
    });

    test('returns null for malformed JSON', () {
      expect(ParseFlutterBridgeMessage.call('not json'), isNull);
    });

    test('returns null when event is missing', () {
      expect(ParseFlutterBridgeMessage.call('{"payload":{}}'), isNull);
    });
  });
}
