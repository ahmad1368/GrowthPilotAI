import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_sync_intelligence_pack.dart';

void main() {
  test('syncs when no local pack exists yet', () {
    expect(ShouldSyncIntelligencePack.call(null, 1), isTrue);
  });

  test('syncs when the remote version is newer', () {
    expect(ShouldSyncIntelligencePack.call(1, 2), isTrue);
  });

  test('does not sync when local is already current', () {
    expect(ShouldSyncIntelligencePack.call(2, 2), isFalse);
  });

  test('does not sync when local is somehow ahead', () {
    expect(ShouldSyncIntelligencePack.call(3, 2), isFalse);
  });
}
