import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/anonymizer_service.dart';
import 'package:growth_pilot_ai/core/utils/data_generalizer.dart';
import 'package:growth_pilot_ai/core/utils/pseudonymizer.dart';

void main() {
  group('Pseudonymizer.hash', () {
    test('is deterministic for the same input + salt', () {
      expect(Pseudonymizer.hash('org-1', salt: 's'),
          Pseudonymizer.hash('org-1', salt: 's'));
    });

    test('differs across inputs and produces a 64-char SHA-256 hex', () {
      final a = Pseudonymizer.hash('org-1', salt: 's');
      expect(a, isNot(Pseudonymizer.hash('org-2', salt: 's')));
      expect(a.length, 64);
    });

    test('is not reversible to the raw value', () {
      expect(Pseudonymizer.hash('org-1', salt: 's'), isNot(contains('org-1')));
    });
  });

  group('DataGeneralizer', () {
    test('reduces a date to YYYY-MM', () {
      expect(DataGeneralizer.monthPeriod(DateTime.utc(2027, 3, 14)), '2027-03');
    });

    test('reduces a postal code to its 3-char FSA', () {
      expect(DataGeneralizer.forwardSortationArea('V3J 1A2'), 'V3J');
      expect(DataGeneralizer.forwardSortationArea(null), '');
    });

    // Issue #90: generalized age bucket for k-anonymity grouping.
    test('reduces a year to its decade', () {
      expect(DataGeneralizer.decade(1989), '1980s');
      expect(DataGeneralizer.decade(2001), '2000s');
    });
  });

  group('AnonymizerService.transformForStorage', () {
    test('strips identity while keeping analytical metrics', () {
      final record = AnonymizerService().transformForStorage(
        orgId: 'acme-inc',
        date: DateTime.utc(2027, 3, 14),
        amount: 1250.0,
        postalCode: 'V3J 1A2',
        category: 'rent',
      );
      expect(record.orgHash, isNot('acme-inc'));
      expect(record.orgHash.length, 64);
      expect(record.period, '2027-03');
      expect(record.region, 'V3J');
      expect(record.amount, 1250.0);
      expect(record.currency, 'CAD');
      expect(record.category, 'rent');
    });

    test('produces a consistent org hash across records (time-series)', () {
      final service = AnonymizerService();
      final a = service.transformForStorage(
          orgId: 'x', date: DateTime.utc(2027, 1, 1), amount: 1);
      final b = service.transformForStorage(
          orgId: 'x', date: DateTime.utc(2027, 2, 1), amount: 2);
      expect(a.orgHash, b.orgHash);
    });

    // Issue #80 "Data Perturbation": opt-in noise stays within ±1% and
    // is off by default, so callers above keep exact amounts.
    test('perturbs the amount by up to 1% when noiseRandom is given', () {
      final record = AnonymizerService().transformForStorage(
        orgId: 'acme-inc',
        date: DateTime.utc(2027, 3, 14),
        amount: 1000.0,
        noiseRandom: Random(42),
      );
      expect(record.amount, greaterThanOrEqualTo(990.0));
      expect(record.amount, lessThanOrEqualTo(1010.0));
    });
  });
}
