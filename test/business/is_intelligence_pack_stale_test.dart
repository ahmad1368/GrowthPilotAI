import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_intelligence_pack_stale.dart';

void main() {
  final now = DateTime.utc(2027, 6, 1);

  test('a recently synced pack is not stale', () {
    expect(IsIntelligencePackStale.call(now.subtract(const Duration(days: 10)), now), isFalse);
  });

  test('a pack synced exactly 30 days ago is stale', () {
    expect(IsIntelligencePackStale.call(now.subtract(const Duration(days: 30)), now), isTrue);
  });

  test('a pack synced over 30 days ago is stale', () {
    expect(IsIntelligencePackStale.call(now.subtract(const Duration(days: 45)), now), isTrue);
  });
}
