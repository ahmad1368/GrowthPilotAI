import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/microphone_consent_entity.dart';

void main() {
  group('MicrophoneConsentEntity', () {
    test('defaults to opted out (Privacy by Design)', () {
      final entity = MicrophoneConsentEntity();

      expect(entity.optedIn, isFalse);
      expect(entity.decidedAt, isNull);
    });
  });
}
