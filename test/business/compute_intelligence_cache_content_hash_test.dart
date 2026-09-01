import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_intelligence_cache_content_hash.dart';

void main() {
  group('ComputeIntelligenceCacheContentHash', () {
    test('is deterministic for the same input', () {
      final a = ComputeIntelligenceCacheContentHash.call('{"a":1}');
      final b = ComputeIntelligenceCacheContentHash.call('{"a":1}');
      expect(a, b);
    });

    test('differs for different input', () {
      final a = ComputeIntelligenceCacheContentHash.call('{"a":1}');
      final b = ComputeIntelligenceCacheContentHash.call('{"a":2}');
      expect(a, isNot(b));
    });

    test('produces a 64-character hex digest', () {
      final hash = ComputeIntelligenceCacheContentHash.call('anything');
      expect(hash, hasLength(64));
      expect(RegExp(r'^[0-9a-f]{64}$').hasMatch(hash), isTrue);
    });
  });
}
