import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/get_sector_benchmark.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';

void main() {
  test('returns a distinct, valid benchmark for every sector', () {
    final seen = <String>{};
    for (final sector in BusinessSector.values) {
      final metrics = GetSectorBenchmark.call(sector);
      for (final value in metrics.toList()) {
        expect(value, inInclusiveRange(0.0, 1.0));
      }
      seen.add(metrics.toList().toString());
    }
    expect(seen.length, BusinessSector.values.length);
  });
}
