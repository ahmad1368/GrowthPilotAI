import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_sector_benchmark.dart';
import 'package:growth_pilot_ai/core/models/anonymous_record.dart';

AnonymousRecord _record(String category, double amount) => AnonymousRecord(
      orgHash: 'h',
      period: '2027-03',
      region: 'V3J',
      category: category,
      amount: amount,
    );

void main() {
  test('rejects a sector with fewer than the minimum sample size', () {
    final records = List.generate(9, (i) => _record('marketing', 100));
    final result = ComputeSectorBenchmark.call(records, Random(1));

    expect(result.success, isFalse);
    expect(result.statusCode, 403);
    expect(result.message, contains('Insufficient data'));
  });

  test('returns a noised benchmark per category for a large enough sector', () {
    final records = [
      ...List.generate(10, (i) => _record('marketing', 100)),
      ...List.generate(10, (i) => _record('rent', 2000)),
    ];
    final result = ComputeSectorBenchmark.call(records, Random(1));

    expect(result.success, isTrue);
    expect(result.data!.keys.toSet(), {'marketing', 'rent'});
    expect(result.data!['rent'], greaterThan(result.data!['marketing']!));
  });

  test('groups uncategorized records together', () {
    final records = List.generate(
        10, (i) => const AnonymousRecord(orgHash: 'h', period: 'p', region: 'r', amount: 50));
    final result = ComputeSectorBenchmark.call(records, Random(1));

    expect(result.data!.keys, ['uncategorized']);
  });
}
