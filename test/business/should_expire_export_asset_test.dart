import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_expire_export_asset.dart';

void main() {
  group('ShouldExpireExportAsset', () {
    final now = DateTime(2026, 8, 18, 12);

    test('is not expired within the 48h default window', () {
      final occurredAt = now.subtract(const Duration(hours: 47));
      expect(ShouldExpireExportAsset.call(occurredAt, now), isFalse);
    });

    test('is expired once the 48h default window has elapsed', () {
      final occurredAt = now.subtract(const Duration(hours: 49));
      expect(ShouldExpireExportAsset.call(occurredAt, now), isTrue);
    });

    test('is not expired exactly at the boundary', () {
      final occurredAt = now.subtract(const Duration(hours: 48));
      expect(ShouldExpireExportAsset.call(occurredAt, now), isFalse);
    });

    test('honors a custom ttl override', () {
      final occurredAt = now.subtract(const Duration(hours: 2));
      expect(ShouldExpireExportAsset.call(occurredAt, now, ttl: const Duration(hours: 1)), isTrue);
    });
  });
}
