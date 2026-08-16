import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_unload_inference_engine.dart';

void main() {
  group('ShouldUnloadInferenceEngine', () {
    final lastActiveAt = DateTime(2026, 1, 1, 12);

    test('false immediately after being marked active', () {
      expect(ShouldUnloadInferenceEngine.call(lastActiveAt, lastActiveAt), isFalse);
    });

    test('false just under the 2-minute inactivity threshold', () {
      final now = lastActiveAt.add(const Duration(minutes: 1, seconds: 59));
      expect(ShouldUnloadInferenceEngine.call(lastActiveAt, now), isFalse);
    });

    test('true at exactly 2 minutes and beyond', () {
      final now = lastActiveAt.add(const Duration(minutes: 2));
      expect(ShouldUnloadInferenceEngine.call(lastActiveAt, now), isTrue);
    });

    test('false when the engine was never marked active', () {
      expect(ShouldUnloadInferenceEngine.call(null, DateTime.now()), isFalse);
    });
  });
}
