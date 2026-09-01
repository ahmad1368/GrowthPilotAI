import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_service_restriction_narrative.dart';
import 'package:growth_pilot_ai/business/compute_service_restriction_statuses.dart';
import 'package:growth_pilot_ai/core/data/entities/service_restriction_entity.dart';

ServiceRestrictionEntity _restriction({
  String merchantName = 'Acme Foods',
  String serviceName = 'Marketplace',
  bool isBlocked = true,
  String reasonMessage = 'Overdue invoice',
  DateTime? updatedAt,
}) =>
    ServiceRestrictionEntity(
      merchantName: merchantName,
      serviceName: serviceName,
      isBlocked: isBlocked,
      reasonMessage: reasonMessage,
      updatedAt: updatedAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeServiceRestrictionStatuses', () {
    test('returns empty list when no restrictions are logged', () {
      expect(ComputeServiceRestrictionStatuses.call(const []), isEmpty);
    });

    test('keeps only the most recent decision per merchant/service pair', () {
      final results = ComputeServiceRestrictionStatuses.call([
        _restriction(isBlocked: true, updatedAt: DateTime(2024, 1, 1)),
        _restriction(isBlocked: false, updatedAt: DateTime(2024, 6, 1)),
      ]);

      expect(results, hasLength(1));
      expect(results.single.isBlocked, isFalse);
    });

    test('treats different merchants or services as separate pairs', () {
      final results = ComputeServiceRestrictionStatuses.call([
        _restriction(merchantName: 'Acme Foods', serviceName: 'Marketplace'),
        _restriction(merchantName: 'Acme Foods', serviceName: 'Analytics'),
        _restriction(merchantName: 'Other Merchant', serviceName: 'Marketplace'),
      ]);

      expect(results, hasLength(3));
    });

    test('sorts results by most recently updated first', () {
      final results = ComputeServiceRestrictionStatuses.call([
        _restriction(serviceName: 'Old', updatedAt: DateTime(2024, 1, 1)),
        _restriction(serviceName: 'New', updatedAt: DateTime(2024, 6, 1)),
      ]);

      expect(results.first.serviceName, 'New');
      expect(results.last.serviceName, 'Old');
    });
  });

  group('BuildServiceRestrictionNarrative', () {
    test('falls back when no restrictions are logged', () {
      expect(BuildServiceRestrictionNarrative.call(const []),
          contains('No service restrictions logged'));
    });

    test('falls back when no services are currently blocked', () {
      final results = ComputeServiceRestrictionStatuses.call(
          [_restriction(isBlocked: false)]);

      expect(BuildServiceRestrictionNarrative.call(results),
          contains('No services are currently locked'));
    });

    test('names the merchant, service, and reason for the latest lockdown', () {
      final results = ComputeServiceRestrictionStatuses.call([
        _restriction(
            merchantName: 'Acme Foods',
            serviceName: 'Marketplace',
            isBlocked: true,
            reasonMessage: 'Overdue invoice'),
      ]);

      final narrative = BuildServiceRestrictionNarrative.call(results);
      expect(narrative, contains('Acme Foods'));
      expect(narrative, contains('Marketplace'));
      expect(narrative, contains('Overdue invoice'));
    });
  });
}
