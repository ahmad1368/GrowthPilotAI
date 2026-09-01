import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/engine_lifecycle_state.dart';

void main() {
  group('EngineLifecycleState', () {
    test('initial state is unloaded with no active timestamp', () {
      final state = EngineLifecycleState.initial();
      expect(state.isLoaded, isFalse);
      expect(state.lastActiveAt, isNull);
    });

    test('copyWith updates only the given fields', () {
      final now = DateTime(2026, 1, 1);
      final state = EngineLifecycleState.initial().copyWith(isLoaded: true, lastActiveAt: now);

      expect(state.isLoaded, isTrue);
      expect(state.lastActiveAt, now);
    });
  });
}
